import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/routes/repo/repos_route.dart';
import 'package:biggertask/routes/repo/starred_repos_route.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

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
        title: Text(AppLocalizations.of(context)!.userInfo),
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
                    GitHubNameCard(
                      user: _user,
                      onAvatarTap: _onAvatarTap,
                    ),
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
                      title: Text(AppLocalizations.of(context)!.repositories),
                      onTap: () {
                        Get.to(() => RepositoriesRoute(user: _user!));
                      },
                      trailing: Text(
                          (_user!.publicRepos + (_user!.privateRepos == null ? 0 : _user!.privateRepos!)).toString(),
                      ),
                    ),
                    ListTile(
                      leading: Icon(OctIcons.star),
                      title: Text(AppLocalizations.of(context)!.stars),
                      trailing: FutureBuilder(
                          future: Methods.getStarredCount(token: Global.token, user: _user!),
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
                                          imageUrl: _user!.avatarUrl,
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
                                            child: Image.network(_user!.avatarUrl, width: 40, height: 40,),
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
                          child: PhotoView(
                            imageProvider: NetworkImage(_user!.avatarUrl),
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2.0,
                          )
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
