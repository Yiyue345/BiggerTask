import 'dart:convert';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/widgets/github_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_oauth/github_oauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/methods.dart';

class UserInfoRoute extends StatefulWidget {
  const UserInfoRoute({super.key});

  @override
  State<UserInfoRoute> createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute> {


  @override
  Widget build(BuildContext context) {
    if (Global.token != null) {
      // todo 还是改成下拉刷新好
      Methods.getUserInfo(Global.token!);
    }

    return Center(
      child: Global.isLogin && Global.gitHubUser != null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipOval(
                  child: Global.gitHubUser?.avatarUrl != null
                  ? Image.network(
                    Global.gitHubUser!.avatarUrl,
                    width: 80,
                  )
                  : Icon(
                    Icons.account_circle,
                    size: 80,
                  ),
                ),
              ),
              Text(
                Global.gitHubUser?.login ?? '未登录',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 8),

          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('退出'),
            onTap: _exit,
          )
        ],
      )
          : ElevatedButton(
          onPressed: _login,
          child: Text('登录')
      ),
    );
  }

  void _login() async {

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final storage = FlutterSecureStorage(
          aOptions: AndroidOptions(
              encryptedSharedPreferences: true
          )
      );

      
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => GitHubLogin(
            onLoginSuccess: (token, userInfo) async {


              Global.isLogin = true;
              Global.token = token;

              await storage.write(key: 'github_token', value: token);
              await prefs.setBool('isLogin', Global.isLogin);

              Global.gitHubUser = GitHubUser.fromJson(userInfo);
              await prefs.setString('userData', jsonEncode(Global.gitHubUser));
            },
            onLoginError: (e) {
              Fluttertoast.showToast(msg: '登录失败: $e');
            }
        )
        )
      );

      // 以下作废

      // final gitHubSignIn = GitHubSignIn(
      //   clientId: dotenv.env['GITHUB_CLIENT_ID']!,
      //   clientSecret: dotenv.env['GITHUB_CLIENT_SECRET']!,
      //   redirectUrl: 'http://127.0.0.1:4567/callback',
      // );
      //
      // final result = await gitHubSignIn.signIn(context);
      //
      // if (result.status == GitHubSignInResultStatus.ok) {
      //   final token = result.token;
      //   final profile = result.userProfile;
      //
      //   Global.isLogin = true;
      //   Global.token = token;
      //
      //   await storage.write(key: 'github_token', value: token);
      //   await prefs.setBool('isLogin', Global.isLogin);
      //
      //
      //
      //   // Navigator.of(context).pushReplacementNamed('homepage');
      // }
      // else {
      //   Fluttertoast.showToast(msg: 'error: ${result.errorMessage}');
      //   return;
      // }
      //
      // await _getUserInfo(Global.token!);


    } catch (e) {
      Fluttertoast.showToast(msg: '登录过程出错: $e');
    }

  }

  // Future<void> _getUserInfo(String token) async {
  //   final dio = Dio();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dio.options.headers['Authorization'] = 'Bearer $token';
  //   try {
  //     final response = await dio.get('https://api.github.com/user');
  //     if (response.statusCode != 200) {
  //       Fluttertoast.showToast(msg: '获取用户信息失败');
  //       return;
  //     }
  //     else {
  //       print(response.data);
  //       Global.gitHubUser = GitHubUser.fromJson(response.data);
  //       await prefs.setString('userData', jsonEncode(Global.gitHubUser));
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: '请重新登录');
  //     Global.isLogin = false;
  //     Global.token = null;
  //     print('Error fetching user info: $e');
  //     Fluttertoast.showToast(msg: '获取用户信息失败');
  //     return;
  //   }
  // }

  // 以上作废

  void _exit() {
    Global.isLogin = false;
    Global.token = null;
    Global.gitHubUser = null;

    final storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
            encryptedSharedPreferences: true
        )
    );

    storage.delete(key: 'github_token');
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isLogin', Global.isLogin);
      prefs.remove('userData');
    });

    setState(() {

    });
  }

}

