 import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/commit.dart';
import 'package:flutter/material.dart';

class CommitRoute extends StatefulWidget {
  final String repoFullName;
  final String commitSha;

  const CommitRoute({
    super.key,
    required this.repoFullName,
    required this.commitSha,
  });

  @override
  State<StatefulWidget> createState() => _CommitRouteState();
}

class _CommitRouteState extends State<CommitRoute> {
  bool _isLoading = true;
  late final Commit? _commit;

  @override
  void initState() {
    super.initState();
    _loadCommit();
  }

  Future<void> _loadCommit() async {
    try {
      final commit = await Methods.getCommit(
        token: Global.token,
        repoFullName: widget.repoFullName,
        commitSha: widget.commitSha,
      );

      setState(() {
        _commit = commit;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading commit: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(),
    );
  }
}
