import 'package:biggertask/common/github_color.dart';
import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repo/release_route.dart';
import 'package:biggertask/routes/repo/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
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
        action: AppLocalizations.of(context)!.forkARepository,
        trailing: RepositoryEventTile(repoName: event.repo.name),
      );
    }

    else if (event.type == 'WatchEvent') {
      return CommonRepositoryEventTile(
        event: event,
        action: AppLocalizations.of(context)!.starARepository,
        trailing: RepositoryEventTile(repoName: event.repo.name),
      );
    }

    else if (event.type == 'CreateEvent') {
      if (event.payload.refType == 'repository') {
        return CommonRepositoryEventTile(
          event: event,
          action: AppLocalizations.of(context)!.createARepository,
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
      else if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(
          event: event,
          action: AppLocalizations.of(context)!.createABranch,
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
      else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(
          event: event,
          action: AppLocalizations.of(context)!.createATag,
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
    }
    else if (event.type == 'DeleteEvent') {
      if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(
          event: event,
          action: AppLocalizations.of(context)!.deleteABranch,
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      } else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(
          event: event,
          action: AppLocalizations.of(context)!.deleteATag,
          trailing: RepositoryEventTile(repoName: event.repo.name),
        );
      }
    }
    else if (event.type == 'ReleaseEvent') {
      return CommonRepositoryEventTile(
        event: event,
        action: AppLocalizations.of(context)!.releaseANewVersion,
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

  late final Map<String, int> languages;
  late final int totalBytes;
  late final String mostUsedLanguage;
  late final int mostUsedLanguageBytes;

  Future<void> _fetchRepository() async {
    final future = [
      Methods.getRepository(fullName: repoName, token: Global.token),
      Methods.getRepositoryLanguages(repoFullName: repoName, token: Global.token)
    ];

    final results = await Future.wait(future);
    repository = results[0] as Repository?;

    if (repository != null) {
      await starController.initializeRepo(
          repoName,
          Global.token!,
          repository!.stargazersCount
      );
    }
    languages = results[1] as Map<String, int>;

    if (languages.isNotEmpty) {
      totalBytes = languages.values.reduce((a, b) => a + b);

      // 找到使用最多的语言
      String maxLanguage = languages.keys.first;
      int maxBytes = languages.values.first;

      for (var entry in languages.entries) {
        if (entry.value > maxBytes) {
          maxLanguage = entry.key;
          maxBytes = entry.value;
        }
      }

      mostUsedLanguage = maxLanguage;
      mostUsedLanguageBytes = maxBytes;
    } else {
      totalBytes = 0;
      mostUsedLanguage = '';
      mostUsedLanguageBytes = 0;
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
              title: Text(AppLocalizations.of(context)!.loadFailed),
              onTap: () async {
                await _fetchRepository();
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (repository == null) {
              return ListTile(
                title: Text(
                    AppLocalizations.of(context)!.repoNoExistOrPrivate,
                  style: TextStyle(
                    fontSize: 14
                  ),
                ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repository?.description ?? AppLocalizations.of(context)!.noDescription,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                      ),
                    ),
                    if (mostUsedLanguage.isNotEmpty)
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: GitHubColor.getColor(mostUsedLanguage)
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(mostUsedLanguage)
                          ],
                        ),
                      )
                  ],
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
  /// 事件的动作描述，例如 "forked a repository" 或 "starred a repository"
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
    final String relativeTime;
    if (event.timeAgo.inSeconds < 60) {
      relativeTime = AppLocalizations.of(context)!.now;
    } else if (event.timeAgo.inMinutes < 60) {
      relativeTime = AppLocalizations.of(context)!.minuteAgo(event.timeAgo.inMinutes);
    } else if (event.timeAgo.inHours < 24) {
      relativeTime = AppLocalizations.of(context)!.hourAgo(event.timeAgo.inHours);
    } else if (event.timeAgo.inDays < 30) {
      relativeTime = AppLocalizations.of(context)!.dayAgo(event.timeAgo.inDays);
    } else {
      relativeTime = event.createdAt;
      
    }

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
                  Flexible(
                      child: Row(
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
                      Flexible(
                          child: Text(
                        action,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                            fontSize: 12
                        ),
                        overflow: TextOverflow.ellipsis,
                      ))
                    ],
                  )
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
