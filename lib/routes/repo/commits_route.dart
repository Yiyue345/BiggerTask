import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/commit.dart';
import 'package:flutter/material.dart';

class CommitsRoute extends StatefulWidget {
  final String repoFullName;
  const CommitsRoute({super.key, required this.repoFullName});

  @override
  State<StatefulWidget> createState() => _CommitsRouteState();
}

class _CommitsRouteState extends State<CommitsRoute> {
  int _page = 1;
  final List<Commit> _commits = [];
  bool _hasMore = true;
  bool _isLoaded = false;

  Future<void> _loadCommits({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _commits.clear();
      _hasMore = true;
      _isLoaded = false;
    }

    final newCommits = await Methods.getCommits(token: Global.token, repoFullName: widget.repoFullName, page: _page);

    setState(() {
      if (newCommits.length < 30) {
        _hasMore = false;
      }
      _isLoaded = true;
      _commits.addAll(newCommits);
      _page++;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCommits(refresh: true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
          child: _commits.isEmpty && !_isLoaded
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: _commits.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _commits.length) {
                  if (_hasMore) {
                    _loadCommits();
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
                final String relativeTime;
                final DateTime? createdAt = _commits[index].commit?.author?.date != null
                    ? DateTime.parse(_commits[index].commit!.author!.date!).toLocal()
                    : null;
                final Duration? timeAgo;
                if (createdAt != null) {
                  timeAgo = DateTime.now().difference(createdAt);
                }
                else {
                  timeAgo = null;
                }

                if (timeAgo == null) {
                  relativeTime = '';
                } else if (timeAgo.inSeconds < 60) {
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
                  title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          _commits[index].commit?.message ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        )),
                        if (_commits[index].commit?.author?.date != null)
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              relativeTime,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: _commits[index].author?.avatarUrl != null
                            ? NetworkImage(_commits[index].author!.avatarUrl)
                            : null,
                        radius: 10,
                      ),
                      SizedBox(width: 8,),
                      Text(_commits[index].author?.login ?? ''),
                    ],
                  ),
                  onTap: () {

                  },
                );
              }
          )
          ,
          onRefresh: () async {
            await _loadCommits(refresh: true);
          }
      ),
    );
  }
}