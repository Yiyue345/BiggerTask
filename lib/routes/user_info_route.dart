import 'dart:convert';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/widgets/github_login.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
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
    // if (Global.token != null) {
    //
    //   Methods.getUserInfo(Global.token!);
    // }

    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            Center(
              child: Global.isLogin && Global.gitHubUser != null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GitHubNameCard(user: Global.gitHubUser,),

                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  if (Global.gitHubUser?.bio != null)...[
                    Divider(
                      color: Colors.grey[300],
                      height: 0,
                    ),
                    ListTile(
                      leading: Icon(
                          Icons.info_outline,
                        color: Colors.grey[700],
                        size: 22,
                      ),
                      title: Text(
                        Global.gitHubUser!.bio!,
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                      // tileColor: Colors.grey[200],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      height: 0,
                    ),
                  ],
                  ListTile(
                    leading: Icon(OctIcons.repo),
                    title: Text('仓库'),
                    onTap: () {

                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('退出'),
                    onTap: () async {
                      bool? exit = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('退出登录'),
                              content: Text('你真的要退出登录吗？'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('取消'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('确定'),
                                )
                              ],
                            );
                          }
                      );

                      if (exit == true) {
                        _exit();
                      }
                    },
                  )
                ],
              )
                  : ElevatedButton(
                  onPressed: _login,
                  child: Text('登录')
              ),
            )
          ],
        )
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

              setState(() {

              });
            },
            onLoginError: (e) {
              Fluttertoast.showToast(msg: '登录失败: $e');
            }
        )
        )
      );



    } catch (e) {
      Fluttertoast.showToast(msg: '登录过程出错: $e');
    }



  }

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

  Future<void> _onRefresh() async {
    await Methods.getUserInfo(Global.token);
    setState(() {

    });
  }

}

