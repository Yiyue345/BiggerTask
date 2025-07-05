import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/routes/followers_route.dart';
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
                        login: Global.gitHubUser!.login,
                        followersCount: Global.gitHubUser!.followers)
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
                      '${user?.followers ?? 0} 粉丝',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    ),
                  ),
                  ),
                Text(
                    ' | ${user?.following ?? 0} 关注',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    )
                ),
              ],
            )
          ],
        ),

      ],
    );
  }
}

class GitHubUserTile extends StatelessWidget {
  final SimpleGitHubUser? user;


  GitHubUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

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
              subtitle: Text('加载中...'),
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
              subtitle: Text('加载失败'),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Text(
                        gitHubUser.login,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],


                ],
              ),
              subtitle: Text(
                  gitHubUser.bio ?? '无简介',
                maxLines: 2,
              ),
            );
          }
        }
    );
  }
}
