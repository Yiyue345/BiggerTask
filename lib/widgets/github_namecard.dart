import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/routes/follow_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';

class GitHubNameCard extends StatelessWidget {
  final GitHubUser? user;

  GitHubNameCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:
          CircleAvatar(
            radius: 40,
            backgroundImage: user?.avatarUrl != null
                ? NetworkImage(user!.avatarUrl)
                : null,
            child: user?.avatarUrl == null
                ? Icon(
              Icons.account_circle,
              size: 80,
            )
                : null,
          ),

        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user?.name != null)...[
              Text(
                user?.name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                user?.login ?? '未登录',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700]
                ),
              ),
            ]
            else
              Text(
                user?.login ?? '未登录',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            Row(
              children: [
                Icon(
                  OctIcons.people,
                  size: 16,
                  color: Colors.grey,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 3)
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => FollowersRoute(
                        login: user!.login,
                        followersCount: user!.followers)
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    overlayColor: WidgetStateProperty.all(Colors.transparent), // 移除点击高亮
                    splashFactory: NoSplash.splashFactory,
                    visualDensity: VisualDensity.compact,
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // 移除圆角
                    )),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.followersCount(user!.followers),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    ),
                  ),
                  ),
                Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 14),),
                TextButton(
                  onPressed: () {
                    Get.to(() => FollowingRoute(
                        login: user!.login,
                        followingCount: user!.following)
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(Size.zero),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    overlayColor: WidgetStateProperty.all(Colors.transparent), // 移除点击高亮
                    splashFactory: NoSplash.splashFactory,
                    visualDensity: VisualDensity.compact,
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // 移除圆角
                    )),
                  ),
                    child: Text(
                      AppLocalizations.of(context)!.followingCount(user!.following),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      ),
                    ),
                ),
              ],
            )
          ],
        ),

      ],
    );
  }
}

class GitHubUserTile extends StatefulWidget{
  final SimpleGitHubUser? user;

  GitHubUserTile({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _GitHubUserTileState();
}

class _GitHubUserTileState extends State<GitHubUserTile> with AutomaticKeepAliveClientMixin {
  late SimpleGitHubUser? user;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: Methods.getUserInfo(user!.login, Global.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: user?.avatarUrl != null
                      ? NetworkImage(user!.avatarUrl)
                      : null,
                  child: user?.avatarUrl == null
                      ? Icon(Icons.account_circle, size: 40)
                      : null,
                ),
                title: Text(user!.login),
                subtitle: Text(AppLocalizations.of(context)!.loading),
                onTap: () {
                  Get.to(() => UserInfoRoute(username: user!.login,));
                }
            );
          }
          else if (snapshot.hasError) {
            return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: user?.avatarUrl != null
                      ? NetworkImage(user!.avatarUrl)
                      : null,
                  child: user?.avatarUrl == null
                      ? Icon(Icons.account_circle, size: 40)
                      : null,
                ),
                title: Text(user!.login),
                subtitle: Text(AppLocalizations.of(context)!.loadFailed),
                onTap: () {
                  Get.to(() => UserInfoRoute(username: user!.login,));
                }
            );
          }
          else {
            final gitHubUser = snapshot.data as GitHubUser;
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(gitHubUser.avatarUrl),

                child: null,
              ),
              title: Row(
                children: [
                  if (gitHubUser.name != null) ...[
                    Text(
                      gitHubUser.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Flexible(
                        child: Text(
                          gitHubUser.login,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        )
                    )

                  ],
                ],
              ),
              subtitle: Text(
                gitHubUser.bio ?? '无简介',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              onTap: () {
                Get.to(() => UserInfoRoute(username: user!.login,));
              },
            );
          }
        }
    );
  }


}
