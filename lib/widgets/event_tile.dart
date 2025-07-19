import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final List<String> eventTypes = [
    'CommitCommentEvent',
    'CreateEvent',
    'DeleteEvent',
    'ForkEvent',
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
    'WatchEvent'

  ];

  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event.type == null) {
      return SizedBox();
    }
    // fork 仓库
    if (event.type! == 'ForkEvent') {
      return CommonRepositoryEventTile(event: event, action: '复刻了一个仓库');
    }

    else if (event.type == 'WatchEvent') {
      return CommonRepositoryEventTile(event: event, action: '标星了一个仓库');
    }

    else if (event.type == 'CreateEvent') {
      if (event.payload.refType == 'repository') {
        return CommonRepositoryEventTile(event: event, action: '创建了一个仓库');
      }
      else if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(event: event, action: '创建了一个分支');
      }
      else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(event: event, action: '创建了一个标签');
      }
    }
    else if (event.type == 'DeleteEvent') {
      if (event.payload.refType == 'branch') {
        return CommonRepositoryEventTile(
            event: event, action: '删除了一个分支');
      } else if (event.payload.refType == 'tag') {
        return CommonRepositoryEventTile(
            event: event, action: '删除了一个标签');
      }
    }

    return SizedBox();
  }
}

class RepositoryEventTile extends StatelessWidget {
  final String repoName;
  late final Repository? repository;
  final StarController starController = Get.put(StarController());

  Future<void> _fetchRepository() async {
    repository = await Methods.getRepository(repoName, Global.token);

    if (repository != null) {
      await  starController.initializeRepo(
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
            return ListTile();
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
                onTap: () async {
                  await _fetchRepository();
                },
              );
            }
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                        repository!.fullName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
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
                        starController._starCounts[repository!.fullName].toString() ?? '0',
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
      await Methods.unstarRepository(repoFullName, token);
      _starredRepos[repoFullName] = false;
      _starCounts[repoFullName] = currentCount - 1;
    } else {
      await Methods.starRepository(repoFullName, token);
      _starredRepos[repoFullName] = true;
      _starCounts[repoFullName] = currentCount + 1;
    }
  }

  Future<void> initializeRepo(String repoFullName, String token, int starCount) async {
    if (!_starredRepos.containsKey(repoFullName)) {
      bool starred = await Methods.isStarred(repoFullName, token);
      _starredRepos[repoFullName] = starred;
      _starCounts[repoFullName] = starCount;
    }
  }
}

class CommonRepositoryEventTile extends StatelessWidget {
  final Event event;
  final String action;

  const CommonRepositoryEventTile({Key? key, required this.event, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryFixed,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(event.actor.avatarUrl),
                    radius: 16,
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
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: RepositoryEventTile(repoName: event.repo.name)
            ),
          ],
        ),
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