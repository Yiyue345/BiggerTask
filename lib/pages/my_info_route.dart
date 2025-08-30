import 'dart:convert';
import 'dart:math';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/routes/repo/repos_route.dart';
import 'package:biggertask/routes/repo/starred_repos_route.dart';
import 'package:biggertask/widgets/github_login.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../common/methods.dart';

class MyInfoRoute extends StatefulWidget {
  const MyInfoRoute({super.key});

  @override
  State<MyInfoRoute> createState() => _MyInfoRouteState();
}

class _MyInfoRouteState extends State<MyInfoRoute> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (!Global.isLogin || Global.gitHubUser == null)
              GitHubNameCard(
                user: Global.gitHubUser,
                onAvatarTap: _login,
                onNameTap: _login,
              ),

            if (Global.isLogin && Global.gitHubUser != null) ...[
              GitHubNameCard(
                user: Global.gitHubUser,
                onAvatarTap: _onAvatarTap,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              if (Global.gitHubUser?.bio != null)...[
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  height: 0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
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
                  color: Theme.of(context).colorScheme.primary,
                  height: 0,
                ),
              ],
              ListTile(
                  leading: Icon(OctIcons.repo,),
                  title: Text(AppLocalizations.of(context)!.repositories),
                  onTap: () {
                    Get.to(() => RepositoriesRoute(user: Global.gitHubUser!));
                  },
                  trailing: Text(
                    (Global.gitHubUser!.publicRepos + (Global.gitHubUser!.privateRepos == null ? 0 : Global.gitHubUser!.privateRepos! + 1)).toString(),
                  )
              ),
              ListTile(
                leading: Icon(OctIcons.star),
                title: Text(AppLocalizations.of(context)!.stars),
                trailing: FutureBuilder(
                    future: Methods.getStarredCount(token: Global.token, user: Global.gitHubUser!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(snapshot.data.toString());
                      } else {
                        return Text('');
                      }
                    }
                ),
                onTap: () {
                  Get.to(() => StarredReposRoute(user: Global.gitHubUser!));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app,),
                title: Text(AppLocalizations.of(context)!.exit),
                onTap: () async {
                  bool? exit = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)!.exitTitle),
                          content: Text(AppLocalizations.of(context)!.exitMessage),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(AppLocalizations.of(context)!.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(AppLocalizations.of(context)!.confirm),
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
            ]

          ],
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
              Fluttertoast.showToast(msg: AppLocalizations.of(context)!.loginFailed(e));
            }
        )
        )
      );

    } catch (e) {
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.loginError(e));
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
    final userInfo = await Methods.getMyInfo(token: Global.token);
    if (userInfo != null) {
      Global.gitHubUser = GitHubUser.fromJson(userInfo);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonEncode(Global.gitHubUser));

    }

    setState(() {

    });
  }

  void _onAvatarTap() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      onLongPress: () async {
                        await showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await Methods.saveImage(
                                          context: context,
                                          imageUrl: Global.gitHubUser!.avatarUrl,
                                          imageName: 'github_avatar_${DateTime.now().millisecondsSinceEpoch}'
                                      );
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(Global.gitHubUser!.avatarUrl, width: 40, height: 40,),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(AppLocalizations.of(context)!.saveImage),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        );
                      },
                      child: Hero(
                          tag: 'avatar',
                          child: Image(image: NetworkImage(Global.gitHubUser!.avatarUrl),)
                      ),
                    ),
                  ),
                )
            );
          },
        )
    );
  }

}

