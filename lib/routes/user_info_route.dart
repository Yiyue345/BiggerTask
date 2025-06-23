import 'dart:convert';

import 'package:biggertask/global/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_oauth/github_oauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoRoute extends StatefulWidget {
  const UserInfoRoute({super.key});

  @override
  State<UserInfoRoute> createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute> {
  @override
  Widget build(BuildContext context) {
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
    final dio = Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final gitHubSignIn = GitHubSignIn(
        clientId: dotenv.env['GITHUB_CLIENT_ID']!,
        clientSecret: dotenv.env['GITHUB_CLIENT_SECRET']!,
        redirectUrl: 'http://127.0.0.1:4567/callback',
    );

    final result = await gitHubSignIn.signIn(context);

    if (result.status == GitHubSignInResultStatus.ok) {
      final token = result.token;
      final profile = result.userProfile;

      Global.isLogin = true;
      Global.token = token;

      await prefs.setString('token', token ?? '');
      await prefs.setBool('isLogin', Global.isLogin);
    }
    else {
      Fluttertoast.showToast(msg: 'error: ${result.errorMessage}');
      return;
    }

    dio.options.headers['Authorization'] = 'Bearer ${Global.token}';
    final response = await dio.get('https://api.github.com/user');
    if (response.statusCode != 200) {
      Fluttertoast.showToast(msg: '获取用户信息失败');
      return;
    }
    else {

      print(response.data);
      Global.gitHubUser = GitHubUser.fromJson(response.data);
      await prefs.setString('userData', jsonEncode(Global.gitHubUser));
    }

    setState(() {

    });

  }

}

