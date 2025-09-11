import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/issue.dart';
import 'package:biggertask/routes/repo/issue_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class IssuesRoute extends StatefulWidget {
  const IssuesRoute({super.key, required this.repoFullName});
  final String repoFullName;


  @override
  State<StatefulWidget> createState() => _IssuesRouteState();
}

class _IssuesRouteState extends State<IssuesRoute> {
  int _page = 1;
  final List<Issue> _issues = [];
  bool _hasMore = true;
  bool _isLoaded = false;
  String state = 'open';

  Future<void> _loadIssues({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _issues.clear();
      _hasMore = true;
      _isLoaded = false;
    }

    final newIssues = await Methods.getRepoIssues(
        token: Global.token,
        repoFullName: widget.repoFullName,
        page: _page,
        state: state
    );

    setState(() {
      if (newIssues.length < 30) {
        _hasMore = false;
      }
      _isLoaded = true;
      _issues.addAll(newIssues);
      _page++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadIssues(refresh: true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.issues),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  state = state == 'open' ? 'closed' : 'open';
                  _loadIssues(refresh: true);
                });
              },
              icon: state == 'open'
                ? Icon(OctIcons.issue_opened, color: Colors.green,)
                : Icon(OctIcons.issue_closed, color: Colors.purple,)
          )
        ],
      ),
      body: RefreshIndicator(
          child: _issues.isEmpty && !_isLoaded
              ? Center(child: CircularProgressIndicator())
              : _issues.isEmpty
              ? Center(
            child: Text(AppLocalizations.of(context)!.noIssues),
          )
              : ListView.separated(
              itemBuilder: (context, index) {
                if (index == _issues.length) {
                  if (_hasMore) {
                    _loadIssues();
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // todo: 修改文本
                        child: Text(AppLocalizations.of(context)!.noMore),
                      ),
                    );
                  }
                }
                final issue = _issues[index];
                return IssueItem(issue: issue);
              },
              separatorBuilder: (context, index) => Divider(
                height: 0,
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
              ),
              itemCount: _issues.length + (_hasMore ? 1 : 0)
          )
          ,
          onRefresh: () async {
            await _loadIssues(refresh: true);
          }
      ),
    );
  }
}

class IssueItem extends StatelessWidget {
  const IssueItem({super.key, required this.issue});
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    final String relativeTime;
    final DateTime createdAt = DateTime.parse(issue.createdAt);
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


    return ListTile(
      leading: issue.state == 'open'
          ? Icon(
        OctIcons.issue_opened,
        color: Colors.green,
        size: 20,
      )
          : Icon(
        OctIcons.issue_closed,
        color: Colors.purple,
        size: 20,
      )
      ,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text.rich(
              TextSpan(
                  children:[
                    TextSpan(
                        text: issue.title,
                      style: TextStyle(
                        fontSize: 14
                      )
                    ),
                    TextSpan(
                        text: ' #${issue.number}',
                        style: TextStyle(
                            color: Colors.grey,
                          fontSize: 14
                        )
                    ),
                  ]
              )
          )),
          Text(
              relativeTime,
              style: TextStyle(
                  color: Colors.grey,
                fontSize: 14
              )
          ),
        ],
      ),
      subtitle: issue.comments > 0
          ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5
                  )
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(OctIcons.comment, size: 12, color: Theme.of(context).colorScheme.primary,),
                  SizedBox(width: 4,),
                  Text('${issue.comments}', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                ],
              )
          ),
          Spacer()
        ],
      )
          : null
      ,
      onTap: () {
        Get.to(() => IssueRoute(issueNumber: issue.number, repoFullName: issue.repositoryUrl.split('/').sublist(4).join('/')));
      },
    );
  }
}