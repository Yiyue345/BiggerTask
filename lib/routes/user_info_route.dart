import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/routes/repos_route.dart';
import 'package:biggertask/routes/starred_repos_route.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';

class UserInfoRoute extends StatefulWidget {
  UserInfoRoute({super.key, required this.username});
  final String username;

  @override
  State<UserInfoRoute> createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute> {

  late GitHubUser? _user;
  bool _isLoading = true;

  void _initUser() async {
    _isLoading = true;
    _user = await Methods.getUserInfo(widget.username, Global.token);
    _isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户信息'),
      ),
      body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GitHubNameCard(user: _user,),

                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    if (_user?.bio != null)...[
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        height: 0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 22,
                        ),
                        title: Text(
                          _user!.bio!,
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
                      leading: Icon(
                          OctIcons.repo,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Text('仓库'),
                      onTap: () {
                        Get.to(() => RepositoriesRoute(user: _user!));
                      },
                      trailing: Text(
                          (_user!.publicRepos + (_user!.privateRepos == null ? 0 : _user!.privateRepos!)).toString(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(OctIcons.star),
                      title: Text('标星'),
                      trailing: FutureBuilder(
                          future: Methods.getStarredCount(Global.token, _user!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text(snapshot.data.toString());
                            } else {
                              return Text('');
                            }
                          }
                      ),
                      onTap: () {
                        Get.to(() => StarredReposRoute(user: _user!));
                      },
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    final user = await Methods.getUserInfo(_user!.login, Global.token);
    if (user != null) {
      _user = user;
    }

    setState(() {
      _isLoading = false;
    });
  }
}
