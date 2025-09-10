import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/issue.dart';
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
  bool _commentsLoaded = false;

  Future<void> _loadIssue() async {
    final issue = await Methods.getIssue(
        token: Global.token,
        repoFullName: widget.repoFullName,
        issueNumber: widget.issueNumber
    );

    setState(() {
      _issue = issue;
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      children: [
                        CircleAvatar(
                        backgroundImage: NetworkImage(_issue!.user.avatarUrl),
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
                                        getAutherAssociation(_issue!.authorAssociation),
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
                                      const SizedBox(width: 8),
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
                                          getAutherAssociation(comment.authorAssociation),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('commented on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(comment.createdAt))}'),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: EdgeInsets.only(left: 32),
                                    child: MarkdownBlock(
                                        data: comment.body ?? ''
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

  String getAutherAssociation(String association) {
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