import 'package:biggertask/models/github_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
                Text(
                  '${user?.followers ?? 0} 粉丝',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
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