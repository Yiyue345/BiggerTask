import 'package:biggertask/common/methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class GitHubLogin extends StatefulWidget {
  final Function(String token, Map<String, dynamic> userInfo) onLoginSuccess;
  final Function(String error) onLoginError;
  const GitHubLogin({
    super.key,
    required this.onLoginSuccess,
    required this.onLoginError,
  });

  @override
  _GitHubLoginState createState() => _GitHubLoginState();
}

class _GitHubLoginState extends State<GitHubLogin> {

  late final WebViewController _controller;
  final String clientId = dotenv.env['GITHUB_CLIENT_ID']!;
  final String clientSecret = dotenv.env['GITHUB_CLIENT_SECRET']!;
  final String redirectUrl = 'http://127.0.0.1:4567/callback';
  late final WebViewCookieManager _cookieManager;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cookieManager = WebViewCookieManager();
    _clearBrowserData();
    _setupWebViewController();
  }

  Future<void> _clearBrowserData() async {
    await _cookieManager.clearCookies();

    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      final androidController = _controller.platform as AndroidWebViewController;
      await androidController.clearCache();
      await androidController.clearLocalStorage();
    }
  }

  void _setupWebViewController() {
    // 初始化 WebViewController
    _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });

              print("收到URL: $url");

              // 如果是需要的回调 URL
              if (url.startsWith(redirectUrl)) {
                // 就从中提取授权码
                final uri = Uri.parse(url);
                final code = uri.queryParameters['code'];

                if (code != null) {
                  print("获取到授权码: $code");
                  Navigator.of(context).pop(); // 关闭 WebView
                  // 通过授权码获取令牌
                  _getAccessToken(code);
                }
                else {
                  print("URL 匹配但没有授权码: $url");
                  widget.onLoginError("授权码获取失败");
                  Navigator.of(context).pop();
                }

              }
              
              else if (url.contains('error=')) {
                // 处理错误情况
                final uri = Uri.parse(url);
                final error = uri.queryParameters['error'] ?? "未知错误";
                widget.onLoginError(error);
                Navigator.of(context).pop();
              }

            },
            onWebResourceError: (WebResourceError error) {
              print('WebView 发生错误：${error.description}');
            }

          )
        )
      // 第一发请求，去 GitHub 登录
        ..loadRequest(Uri.parse(
            'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUrl&scope=user,repo'
        ));
  }

  // 第二发请求，用授权码获得令牌
  Future<void> _getAccessToken(String code) async {
    try {
      final dio = Dio();

      // 发射！
      final tokenResponse = await dio.post(
        'https://github.com/login/oauth/access_token',
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUrl,
        },
        options: Options(
          headers: {'Accept': 'application/json'},
        )
      );

      if (tokenResponse.statusCode == 200 && tokenResponse.data['access_token'] != null) {
        final accessToken = tokenResponse.data['access_token'];
        print("获取到访问令牌");

        // 获取用户信息
        final userInfo = await Methods.getMyInfo(accessToken);
        if (userInfo != null) {
          widget.onLoginSuccess(accessToken, userInfo);
        }
        else {
          widget.onLoginError('获取用户信息失败');
        }
      }
      else {
        widget.onLoginError('获取访问令牌失败');
      }

    } catch (e) {
      print("获取访问令牌时发生错误: $e");
      widget.onLoginError('登录过程出现错误: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub 登录'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
