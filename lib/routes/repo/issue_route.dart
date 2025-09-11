import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/issue.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repo/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';

class IssueRoute extends StatefulWidget {
  const IssueRoute({super.key, required this.issueNumber, required this.repoFullName});
  final String repoFullName;
  final int issueNumber;

  @override
 State<StatefulWidget> createState() => _IssueRouteState();
}

class _IssueRouteState extends State<IssueRoute> {
  Issue? _issue;
  bool _isLoaded = false;
  List<Comment> _comments = [];
  late final Repository _repository;
  bool _commentsLoaded = false;

  Future<void> _loadIssue() async {
    final futures = [
      Methods.getRepository(fullName: widget.repoFullName, token: Global.token),
      Methods.getIssue(
          token: Global.token,
          repoFullName: widget.repoFullName,
          issueNumber: widget.issueNumber
      )
    ];
    final results = await Future.wait(futures);

    setState(() {
      _issue = results[1] as Issue;
      _repository = results[0] as Repository;
      _isLoaded = true;
    });
  }

  Future<void> _loadComments() async {
    final comments = await Methods.getIssueComments(
        token: Global.token,
        repoFullName: widget.repoFullName,
        issueNumber: widget.issueNumber
    );

    setState(() {
      _comments = comments;
      _commentsLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadIssue();
    _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.issue + ' #' +
              widget.issueNumber.toString()),
        ),
        body: !_isLoaded
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 头像，拥有者和仓库
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(_repository.owner.avatarUrl),
                            radius: 12,
                          ),
                          onTap: () {
                            Get.to(() => UserInfoRoute(username: _repository.owner.login));
                          },
                        ),
                        SizedBox(width: 4,),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => UserInfoRoute(username: _repository.owner.login));
                          },
                          child: Text(
                            _repository.owner.login, // 仓库拥有者
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primaryFixedDim,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          ' / ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primaryFixedDim
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => RepositoryRoute(repository: _repository));
                          },
                          child: Text(
                            _repository.fullName.split('/')[1], // 仓库名称
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primaryFixedDim,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 2,),
                        Text(
                          '#${widget.issueNumber}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                            )
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                        backgroundImage: NetworkImage(_issue!.user.avatarUrl),
                        radius: 16,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => UserInfoRoute(username: _issue!.user.login));
                          },
                        ),
                      ),

                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => UserInfoRoute(username: _issue!.user.login));
                                    },
                                    child: Text(_issue!.user.login, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(width: 6,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: BoxBorder.all(
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 1.5
                                      )
                                    ),
                                    child: Text(
                                        getAuthorAssociation(_issue!.authorAssociation),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text('#${_issue!.number} opened on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(_issue!.createdAt))}'),
                            ],
                          ),
                        ),
                        if (_issue!.state == 'open')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(AppLocalizations.of(context)!.open, style: const TextStyle(color: Colors.white)),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(AppLocalizations.of(context)!.closed, style: const TextStyle(color: Colors.white)),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(_issue!.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    height: 0,
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (_issue!.body != null)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      child: MarkdownBlock(
                          data: _issue!.body ?? ''
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _commentsLoaded
                      ? ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            final String relativeTime;
                            final DateTime createdAt = DateTime.parse(comment.createdAt);
                            final Duration timeAgo;
                            timeAgo = DateTime.now().difference(createdAt);

                            if (timeAgo.inSeconds < 60) {
                              relativeTime = AppLocalizations.of(context)!.now;
                            } else if (timeAgo.inMinutes < 60) {
                              relativeTime = AppLocalizations.of(context)!.minuteAgo(timeAgo.inMinutes);
                            } else if (timeAgo.inHours < 24) {
                              relativeTime = AppLocalizations.of(context)!.hourAgo(timeAgo.inHours);
                            } else if (timeAgo.inDays < 30) {
                              relativeTime = AppLocalizations.of(context)!.dayAgo(timeAgo.inDays);
                            } else if (timeAgo.inDays < 365) {
                              relativeTime = AppLocalizations.of(context)!.monthAgo((timeAgo.inDays / 30).floor());
                            } else {
                              relativeTime = AppLocalizations.of(context)!.yearAgo((timeAgo.inDays / 365).floor());
                            }

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(comment.user.avatarUrl),
                                        radius: 12,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => UserInfoRoute(username: comment.user.login));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() => UserInfoRoute(username: comment.user.login));
                                                },
                                                child: Text(comment.user.login, style: const TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                              const SizedBox(width: 6,),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 4),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: BoxBorder.all(
                                                        color: Theme.of(context).colorScheme.secondary,
                                                        width: 1.5
                                                    )
                                                ),
                                                child: Text(
                                                  getAuthorAssociation(comment.authorAssociation),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context).colorScheme.secondary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                              AppLocalizations.of(context)!.commented(relativeTime),
                                              style: TextStyle(
                                                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
                                                  fontSize: 12
                                              )
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.only(left: 32),
                                    child: MarkdownBlock(
                                        data: comment.body
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 0,
                            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                          ),
                          itemCount: _comments.length
                      )
                      : Center(
                    child: CircularProgressIndicator(),
                  )
                ]
            )
        )
    );
  }

  String getAuthorAssociation(String association) {
    // todo: 国际化
    switch (association) {
      case 'COLLABORATOR':
        return '协作者';
      case 'CONTRIBUTOR':
        return '贡献者';
      case 'FIRST_TIMER':
        return '首次参与者';
      case 'FIRST_TIME_CONTRIBUTOR':
        return '首次贡献者';
      case 'MANNEQUIN':
        return '机器人';
      case 'MEMBER':
        return '成员';
      case 'NONE':
        return '无';
      case 'OWNER':
        return '所有者';
      default:
        return association;
    }
  }
}