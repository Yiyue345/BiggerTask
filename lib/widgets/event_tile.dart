import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/release_route.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final List<String> eventTypes = [
    'CommitCommentEvent',
    'CreateEvent', // 完成
    'DeleteEvent', // 完成
    'ForkEvent', // 完成
    'GollumEvent',
    'IssueCommentEvent',
    'IssuesEvent',
    'MemberEvent',
    'PublicEvent',
    'PullRequestEvent',
    'PullRequestReviewEvent',
    'PullRequestReviewCommentEvent',
    'PullRequestReviewThreadEvent',
    'PushEvent',
    'ReleaseEvent',
    'SponsorshipEvent',
    'WatchEvent' // 完成

  ];

  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event.type == null) {
      return SizedBox();
    }
    // fork 仓库
    if (event.type! == 'ForkEvent') {
      return CommonRepositoryEventTile(
        event: event,
        action: '复刻了一个仓库',
        trailing: RepositoryEventTile(repoName: event.repo.name),
      );
    }

    else if (event.type == 'WatchEvent') {
      return CommonRepositoryEventTile(
        event: event,
        action: '标星了一个仓库',
        trailing: RepositoryEventTile(repoName: event.repo.name),
      );
    }

    else if (event.type == 'CreateEvent') {
      if (event.payload.refType == 'repository') {
        return CommonRepositoryEventTile(
          event: event,
          action: '创建了一个仓库',
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
      else if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(
          event: event,
          action: '创建了一个分支',
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
      else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(
          event: event,
          action: '创建了一个标签',
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
    }
    else if (event.type == 'DeleteEvent') {
      if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(
          event: event,
          action: '删除了一个分支',
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      } else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(
          event: event,
          action: '删除了一个标签',
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
    }
    else if (event.type == 'ReleaseEvent') {
      return CommonRepositoryEventTile(
        event: event,
        action: '发布了一个版本',
        trailing: ReleaseEventTile(event: event)
      );
    }

    return SizedBox();
  }
}

class RepositoryEventTile extends StatelessWidget {
  final String repoName;
  late final Repository? repository;
  final StarController starController = Get.put(StarController());

  Future<void> _fetchRepository() async {
    repository = await Methods.getRepository(fullName: repoName, token: Global.token);

    if (repository != null) {
      await starController.initializeRepo(
          repoName,
          Global.token!,
          repository!.stargazersCount
      );
    }
  }

  RepositoryEventTile({Key? key, required this.repoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchRepository(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListTile(
              minVerticalPadding: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                        ),
                        SizedBox(width: 4,),
                        Flexible(
                          child: Text(
                            repoName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return ListTile(
              title: Text('加载失败'),
              onTap: () async {
                await _fetchRepository();
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (repository == null) {
              return ListTile(
                title: Text('仓库不存在或不可见'),
              );
            }
            return ListTile(
              minVerticalPadding: 0,
              // 仓库的所有者、名字与星标数
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(repository!.owner.avatarUrl),
                            radius: 8,
                          ),
                          SizedBox(width: 4,),
                          Flexible(
                            child: Text(
                              repository!.fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                  Obx(() => TextButton.icon(
                      onPressed: () async {
                        await starController.toggleStar(
                            repository!.fullName,
                            Global.token!,
                            starController._starCounts[repository!.fullName] ?? 0
                        );
                        repository!.stargazersCount = starController.getStarCount(repository!.fullName);
                      },
                    label: Text(
                        starController._starCounts[repository?.fullName].toString(),
                      style: TextStyle(
                        color: starController.isStarred(repository!.fullName)
                          ? Colors.amber
                          : Theme.of(context).colorScheme.onSecondaryFixedVariant,
                      ),
                    ),
                    icon: Icon(
                        OctIcons.star,
                        color: starController.isStarred(repository!.fullName)
                          ? Colors.amber
                          : Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    ),
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          // tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 收缩点击区域
                          minimumSize: WidgetStatePropertyAll(Size.zero), // 移除最小尺寸
                          visualDensity: VisualDensity.compact, // 紧凑的视觉密度
                          overlayColor: WidgetStatePropertyAll(Colors.transparent)
                      )
                  )
                  ),

                ],
              ),
              subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  repository?.description ?? '无描述',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => RepositoryRoute(repository: repository!));
              },
            );
          }

          return SizedBox();
        }
    );
  }

}

class StarController extends GetxController {
  final RxMap<String, bool> _starredRepos = <String, bool>{}.obs;
  final RxMap<String, int> _starCounts = <String, int>{}.obs;

  bool isStarred(String repoFullName) {
    return _starredRepos[repoFullName] ?? false;
  }
  int getStarCount(String repoFullName) {
    return _starCounts[repoFullName] ?? 0;
  }

  Future<void> toggleStar(String repoFullName, String token, int currentCount) async {
    bool currentState = isStarred(repoFullName);

    if (currentState) {
      await Methods.unstarRepository(repoFullName: repoFullName, token: token);
      _starredRepos[repoFullName] = false;
      _starCounts[repoFullName] = currentCount - 1;
    } else {
      await Methods.starRepository(repoFullName: repoFullName, token: token);
      _starredRepos[repoFullName] = true;
      _starCounts[repoFullName] = currentCount + 1;
    }
  }

  Future<void> initializeRepo(String repoFullName, String token, int starCount) async {
    if (!_starredRepos.containsKey(repoFullName)) {
      bool starred = await Methods.isStarred(repoFullName: repoFullName, token: token);
      _starredRepos[repoFullName] = starred;
      _starCounts[repoFullName] = starCount;
    }
  }
}

class CommonRepositoryEventTile extends StatelessWidget {
  final Event event;
  final String action;
  final Widget? trailing;

  const CommonRepositoryEventTile({
    Key? key,
    required this.event,
    required this.action,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String relativeTime = event.timeAgo;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration( // 背景
            color: Theme.of(context).colorScheme.secondaryFixed,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              // 谁在什么时候做了什么事
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(event.actor.avatarUrl),
                        radius: 12,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(UserInfoRoute(username: event.actor.login));
                          },
                        ),
                      ),
                      SizedBox(width: 8,),
                      GestureDetector(
                        onTap: () {
                          Get.to(UserInfoRoute(username: event.actor.login));
                        },
                        child: Text(
                          event.actor.login,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondaryFixed
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        action,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),

                  Text(
                      relativeTime,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                          fontSize: 12
                      )
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 2, bottom: 4),
                child: trailing
            ),
          ],
        ),
      ),
    );
  }



}

class ReleaseEventTile extends StatelessWidget {
  final Event event;
  
  ReleaseEventTile({Key? key, required this.event}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              event.payload.release!.author.avatarUrl,
            ),
            radius: 8,
          ),
          SizedBox(width: 4,),
          Flexible(
            child: Text(
              event.repo.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4,),
          Text(
            event.payload.release!.name,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ReleaseRoute(
                  release: event.payload.release!,
                  repositoryName: event.repo.name
              ));
            },
            child: SizedBox(
              height: 160,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  MarkdownWidget(
                    data: event.payload.release!.body,
                    shrinkWrap: true,
                    selectable: false,
                  ),
                  Container(
                    // height: 160,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.secondaryFixed.withValues(alpha: 0),
                              Theme.of(context).colorScheme.secondaryFixed.withValues(alpha: 0.5),
                              Theme.of(context).colorScheme.secondaryFixed.withValues(alpha: 0.7),
                              Theme.of(context).colorScheme.secondaryFixed
                            ],
                            stops: [0.0, 0.5, 0.7, 1.0]
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).colorScheme.onSecondaryFixed.withValues(alpha: 0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2)
                            )
                          ]
                      ),
                      child: Text('查看发布详情 > '),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 暂时存在这里
//   {
//     "actor": {
//       "avatar_url": "https://avatars.githubusercontent.com/u/50800434?",
//       "display_login": "FishCat233",
//       "gravatar_id": "",
//       "id": 50800434,
//       "login": "FishCat233",
//       "url": "https://api.github.com/users/FishCat233"
//     },
//     "created_at": "2025-06-25T04:12:04Z",
//     "id": "51306641489",
//     "org": null,
//     "payload": {
//       "action": "created",
//       "comment": {
//         "author_association": "COLLABORATOR",
//         "body": "现在东西还不多吧？多了在整",
//         "body_html": null,
//         "body_text": null,
//         "created_at": "2025-06-25T04:12:03Z",
//         "html_url": "https://github.com/Yiyue345/Brain.Init/issues/28#issuecomment-3003028490",
//         "id": 3003028490,
//         "issue_url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28",
//         "node_id": "IC_kwDOOrPeEs6y_pQK",
//         "performed_via_github_app": null,
//         "reactions": {
//           "+1": 0,
//           "-1": 0,
//           "confused": 0,
//           "eyes": 0,
//           "heart": 0,
//           "hooray": 0,
//           "laugh": 0,
//           "rocket": 0,
//           "total_count": 0,
//           "url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/comments/3003028490/reactions"
//         },
//         "updated_at": "2025-06-25T04:12:03Z",
//         "url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/comments/3003028490",
//         "user": {
//           "avatar_url": "https://avatars.githubusercontent.com/u/50800434?v=4",
//           "events_url": "https://api.github.com/users/FishCat233/events{/privacy}",
//           "followers_url": "https://api.github.com/users/FishCat233/followers",
//           "following_url": "https://api.github.com/users/FishCat233/following{/other_user}",
//           "gists_url": "https://api.github.com/users/FishCat233/gists{/gist_id}",
//           "gravatar_id": "",
//           "html_url": "https://github.com/FishCat233",
//           "id": 50800434,
//           "login": "FishCat233",
//           "node_id": "MDQ6VXNlcjUwODAwNDM0",
//           "organizations_url": "https://api.github.com/users/FishCat233/orgs",
//           "received_events_url": "https://api.github.com/users/FishCat233/received_events",
//           "repos_url": "https://api.github.com/users/FishCat233/repos",
//           "site_admin": false,
//           "starred_at": null,
//           "starred_url": "https://api.github.com/users/FishCat233/starred{/owner}{/repo}",
//           "subscriptions_url": "https://api.github.com/users/FishCat233/subscriptions",
//           "type": "User",
//           "url": "https://api.github.com/users/FishCat233"
//         }
//       },
//       "issue": {
//         "active_lock_reason": null,
//         "assignee": null,
//         "assignees": [],
//         "author_association": "COLLABORATOR",
//         "body": "对现在杂七杂八凑在一起的教程进行归类，如编程入门类，实用工具类，网站开发类，比如根目录下面增加实用工具文件夹，里放鸽子的各种工具的教程.md，git文件夹，然后git文件夹里放各种自己写的或者收集到的git教程",
//         "body_html": null,
//         "body_text": null,
//         "closed_at": null,
//         "comments": 1,
//         "comments_url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28/comments",
//         "created_at": "2025-06-24T13:55:23Z",
//         "events_url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28/events",
//         "html_url": "https://github.com/Yiyue345/Brain.Init/issues/28",
//         "id": 3172115052,
//         "labels": [],
//         "labels_url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28/labels{/name}",
//         "locked": false,
//         "milestone": null,
//         "node_id": "I_kwDOOrPeEs69EqJs",
//         "number": 28,
//         "performed_via_github_app": null,
//         "pull_request": null,
//         "state": "open",
//         "timeline_url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28/timeline",
//         "title": "教程是否应该按照领域来分类？",
//         "updated_at": "2025-06-25T04:12:03Z",
//         "url": "https://api.github.com/repos/Yiyue345/Brain.Init/issues/28",
//         "user": {
//           "avatar_url": "https://avatars.githubusercontent.com/u/177394082?v=4",
//           "events_url": "https://api.github.com/users/shiroe120/events{/privacy}",
//           "followers_url": "https://api.github.com/users/shiroe120/followers",
//           "following_url": "https://api.github.com/users/shiroe120/following{/other_user}",
//           "gists_url": "https://api.github.com/users/shiroe120/gists{/gist_id}",
//           "gravatar_id": "",
//           "html_url": "https://github.com/shiroe120",
//           "id": 177394082,
//           "login": "shiroe120",
//           "node_id": "U_kgDOCpLRog",
//           "organizations_url": "https://api.github.com/users/shiroe120/orgs",
//           "received_events_url": "https://api.github.com/users/shiroe120/received_events",
//           "repos_url": "https://api.github.com/users/shiroe120/repos",
//           "site_admin": false,
//           "starred_at": null,
//           "starred_url": "https://api.github.com/users/shiroe120/starred{/owner}{/repo}",
//           "subscriptions_url": "https://api.github.com/users/shiroe120/subscriptions",
//           "type": "User",
//           "url": "https://api.github.com/users/shiroe120"
//         }
//       },
//       "pages": null
//     },
//     "public": true,
//     "repo": {
//       "id": 984866322,
//       "name": "Yiyue345/Brain.Init",
//       "url": "https://api.github.com/repos/Yiyue345/Brain.Init"
//     },
//     "type": "IssueCommentEvent"
//   },

// {
//     "actor": {
//       "avatar_url": "https://avatars.githubusercontent.com/u/44803668?",
//       "display_login": "YerongAI",
//       "gravatar_id": "",
//       "id": 44803668,
//       "login": "YerongAI",
//       "url": "https://api.github.com/users/YerongAI"
//     },
//     "created_at": "2025-07-09T05:34:58Z",
//     "id": "51859549200",
//     "org": null,
//     "payload": {
//       "action": "published",
//       "comment": null,
//       "issue": null,
//       "pages": null,
//       "forkee": null,
//       "ref": null,
//       "ref_type": null,
//       "master_branch": null,
//       "description": null,
//       "pusher_type": null,
//       "release": {
//         "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/231029497",
//         "html_url": "https://github.com/YerongAI/Office-Tool/releases/tag/v10.24.68.0",
//         "assets_url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/231029497/assets",
//         "upload_url": "https://uploads.github.com/repos/YerongAI/Office-Tool/releases/231029497/assets{?name,label}",
//         "tarball_url": "https://api.github.com/repos/YerongAI/Office-Tool/tarball/v10.24.68.0",
//         "zipball_url": "https://api.github.com/repos/YerongAI/Office-Tool/zipball/v10.24.68.0",
//         "discussion_url": null,
//         "id": 231029497,
//         "node_id": "RE_kwDOCVIChM4NxTr5",
//         "tag_name": "v10.24.68.0",
//         "target_commitish": "main",
//         "name": "Office Tool Plus v10.24.68.0",
//         "body": "## Change log\r\n\r\n- Added new language Arabic (Libya), thanks to Abdul Salam Bin Ali.\r\n- Themes and controls optimization.\r\n- Support to create HTTP response cache to reduce duplicate requests.\r\n- Optimize background thread processing and optimize the logic and performance of asynchronous threads.\r\n- Optimize the UTF-8 encoding and remove the BOM identifier.\r\n- Fixed some issues related to RTL layout.\r\n- Enhanced program security.\r\n- Translation update.\r\n\r\n#### Home\r\n\r\n- Support to download app icon through proxy server.\r\n- Use a new method to detect AppX packages.\r\n\r\n#### Deploy\r\n\r\n- Redesigned the application preference management module to load faster and support filtering items.\r\n- Support to check whether newly added products will conflict with each other.\r\n- Replaced the API to get the historical versions of Office.\r\n- Before deploying Office, the system environment variables will be checked to see if they are correct.\r\n- Double-click the Office installation to view the JSON data of the installation files.\r\n- Optimize XML configuration reading function.\r\n- Fixed an issue where the wrong Office version number might be retrieved. #1000\r\n- Fixed an issue with shortcut keys.\r\n\r\n#### Activate\r\n\r\n- Removed Tenant ID from Enterprise license. You can still get the ID via copy button.\r\n\r\n#### Toolbox\r\n\r\n- Support to collect Office removal logs.\r\n- Support to press Enter to view the C2R release data.\r\n- Fix an issue where proofing tools settings aren't cleared when resetting Office to defaults.\r\n\r\n#### Settings\r\n\r\n- Support to set and save proxy settings.\r\n- Support to download background image through proxy server.\r\n\r\n## Contributors\r\n\r\nTranslation: @AnomSanjaya @VenusGirl @iDolmatov @bovirus @igorruckert \r\n\r\n## Packages\r\n\r\n_**In most cases we recommend that you download the version that includes runtime, you can run Office Tool Plus without runtime installation.**_\r\n\r\nOr manually install .NET 8.0 Desktop Runtime to run Office Tool Plus.\r\n\r\n- [.NET 8.0 Desktop Runtime x86](https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-x86.exe)\r\n- [.NET 8.0 Desktop Runtime x64](https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-x64.exe)\r\n- [.NET 8.0 Desktop Runtime ARM64](https://aka.ms/dotnet/8.0/windowsdesktop-runtime-win-arm64.exe)\r\n\r\n| File name | SHA-256 |\r\n| :-- | :-- |\r\n| Office_Tool_v10.24.68.0_arm64.zip | 1AD067E365462963FCBED47EB85193463C02A40932C3E6BA1D9BAA60B10652A0 |\r\n| Office_Tool_v10.24.68.0_x64.zip | 6F5DBAE536FF15004C8059DD3DAF4BB779CC3F45F92E4B0E29CF4AEB1DCD766A |\r\n| Office_Tool_v10.24.68.0_x86.zip | BFAED82A5C8034F2C032F033F6186CE0F71F2D54FEFBCA7959057C2639F74D5E |\r\n| Office_Tool_with_runtime_v10.24.68.0_arm64.7z | 42328C8958CE798659AEE46D2F8CDEBA6EE34ECA5A757431DBDA3207E0FD47BD |\r\n| Office_Tool_with_runtime_v10.24.68.0_arm64.zip | 2753D8A1F4272A645F6BDE1BC5C108A3CB3C7F7283422308E29D14537556F93E |\r\n| Office_Tool_with_runtime_v10.24.68.0_x64.7z | EA3D7C6D7F2A90B66E77236CBA9860E22BEDF08DFBCB46BD191F1B47AC5933F9 |\r\n| Office_Tool_with_runtime_v10.24.68.0_x64.zip | E6BFECFD56AC53011A229861B5F5EC5CFFD2318D7572F44B93BDE31FD450EE2F |\r\n| Office_Tool_with_runtime_v10.24.68.0_x86.7z | 1C1FFB387E74726796205F33A78DA415BA307FEF08CFB787720512F37F4E8E27 |\r\n| Office_Tool_with_runtime_v10.24.68.0_x86.zip | D132F09AD094953B9D6345F3FABA4A572165074AE540889F8A050007485B8561 |\r\n",
//         "draft": false,
//         "prerelease": false,
//         "immutable": false,
//         "created_at": "2025-07-03T23:55:09Z",
//         "published_at": "2025-07-09T05:34:58Z",
//         "author": {
//           "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//           "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//           "followers_url": "https://api.github.com/users/YerongAI/followers",
//           "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//           "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//           "gravatar_id": "",
//           "html_url": "https://github.com/YerongAI",
//           "id": 44803668,
//           "login": "YerongAI",
//           "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//           "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//           "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//           "repos_url": "https://api.github.com/users/YerongAI/repos",
//           "site_admin": false,
//           "starred_at": null,
//           "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//           "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//           "type": "User",
//           "url": "https://api.github.com/users/YerongAI"
//         },
//         "assets": [
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269919",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_v10.24.68.0_arm64.zip",
//             "id": 271269919,
//             "node_id": "RA_kwDOCVIChM4QK0Af",
//             "name": "Office_Tool_v10.24.68.0_arm64.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 10257927,
//             "digest": "sha256:1ad067e365462963fcbed47eb85193463c02a40932c3e6ba1d9baa60b10652a0",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:22Z",
//             "updated_at": "2025-07-09T05:33:26Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269922",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_v10.24.68.0_x64.zip",
//             "id": 271269922,
//             "node_id": "RA_kwDOCVIChM4QK0Ai",
//             "name": "Office_Tool_v10.24.68.0_x64.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 10274751,
//             "digest": "sha256:6f5dbae536ff15004c8059dd3daf4bb779cc3f45f92e4b0e29cf4aeb1dcd766a",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:26Z",
//             "updated_at": "2025-07-09T05:33:28Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269923",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_v10.24.68.0_x86.zip",
//             "id": 271269923,
//             "node_id": "RA_kwDOCVIChM4QK0Aj",
//             "name": "Office_Tool_v10.24.68.0_x86.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 11736087,
//             "digest": "sha256:bfaed82a5c8034f2c032f033f6186ce0f71f2d54fefbca7959057c2639f74d5e",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:28Z",
//             "updated_at": "2025-07-09T05:33:30Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269929",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_arm64.7z",
//             "id": 271269929,
//             "node_id": "RA_kwDOCVIChM4QK0Ap",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_arm64.7z",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-compressed",
//             "size": 49485309,
//             "digest": "sha256:42328c8958ce798659aee46d2f8cdeba6ee34eca5a757431dbda3207e0fd47bd",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:30Z",
//             "updated_at": "2025-07-09T05:33:41Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269960",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_arm64.zip",
//             "id": 271269960,
//             "node_id": "RA_kwDOCVIChM4QK0BI",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_arm64.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 74000201,
//             "digest": "sha256:2753d8a1f4272a645f6bde1bc5c108a3cb3c7f7283422308e29d14537556f93e",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:41Z",
//             "updated_at": "2025-07-09T05:33:58Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271269988",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_x64.7z",
//             "id": 271269988,
//             "node_id": "RA_kwDOCVIChM4QK0Bk",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_x64.7z",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-compressed",
//             "size": 54417879,
//             "digest": "sha256:ea3d7c6d7f2a90b66e77236cba9860e22bedf08dfbcb46bd191f1b47ac5933f9",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:33:58Z",
//             "updated_at": "2025-07-09T05:34:10Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271270007",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_x64.zip",
//             "id": 271270007,
//             "node_id": "RA_kwDOCVIChM4QK0B3",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_x64.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 77327206,
//             "digest": "sha256:e6bfecfd56ac53011a229861b5f5ec5cffd2318d7572f44b93bde31fd450ee2f",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:34:10Z",
//             "updated_at": "2025-07-09T05:34:27Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271270063",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_x86.7z",
//             "id": 271270063,
//             "node_id": "RA_kwDOCVIChM4QK0Cv",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_x86.7z",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-compressed",
//             "size": 50905425,
//             "digest": "sha256:1c1ffb387e74726796205f33a78da415ba307fef08cfb787720512f37f4e8e27",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:34:27Z",
//             "updated_at": "2025-07-09T05:34:38Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           },
//           {
//             "url": "https://api.github.com/repos/YerongAI/Office-Tool/releases/assets/271270088",
//             "browser_download_url": "https://github.com/YerongAI/Office-Tool/releases/download/v10.24.68.0/Office_Tool_with_runtime_v10.24.68.0_x86.zip",
//             "id": 271270088,
//             "node_id": "RA_kwDOCVIChM4QK0DI",
//             "name": "Office_Tool_with_runtime_v10.24.68.0_x86.zip",
//             "label": null,
//             "state": "uploaded",
//             "content_type": "application/x-zip-compressed",
//             "size": 73628278,
//             "digest": "sha256:d132f09ad094953b9d6345f3faba4a572165074ae540889f8a050007485b8561",
//             "download_count": 0,
//             "created_at": "2025-07-09T05:34:38Z",
//             "updated_at": "2025-07-09T05:34:54Z",
//             "uploader": {
//               "avatar_url": "https://avatars.githubusercontent.com/u/44803668?v=4",
//               "events_url": "https://api.github.com/users/YerongAI/events{/privacy}",
//               "followers_url": "https://api.github.com/users/YerongAI/followers",
//               "following_url": "https://api.github.com/users/YerongAI/following{/other_user}",
//               "gists_url": "https://api.github.com/users/YerongAI/gists{/gist_id}",
//               "gravatar_id": "",
//               "html_url": "https://github.com/YerongAI",
//               "id": 44803668,
//               "login": "YerongAI",
//               "node_id": "MDQ6VXNlcjQ0ODAzNjY4",
//               "organizations_url": "https://api.github.com/users/YerongAI/orgs",
//               "received_events_url": "https://api.github.com/users/YerongAI/received_events",
//               "repos_url": "https://api.github.com/users/YerongAI/repos",
//               "site_admin": false,
//               "starred_at": null,
//               "starred_url": "https://api.github.com/users/YerongAI/starred{/owner}{/repo}",
//               "subscriptions_url": "https://api.github.com/users/YerongAI/subscriptions",
//               "type": "User",
//               "url": "https://api.github.com/users/YerongAI"
//             }
//           }
//         ]
//       }
//     },
//     "public": true,
//     "repo": {
//       "id": 156369540,
//       "name": "YerongAI/Office-Tool",
//       "url": "https://api.github.com/repos/YerongAI/Office-Tool"
//     },
//     "type": "ReleaseEvent"
//   },