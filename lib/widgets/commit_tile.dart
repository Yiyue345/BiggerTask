import 'package:biggertask/models/search.dart';
import 'package:biggertask/routes/repo/commit_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class CommitTile extends StatelessWidget {

  final CommitSearchItem commit; // 可以是 Commit 或 CommitSearchItem
  const CommitTile({super.key, required this.commit});

  @override
  Widget build(BuildContext context) {
    String? message;
    String? authorName;
    String? sha;

    message = commit.commit?.message;
    authorName = commit.commit?.author?.name;
    sha = commit.sha;

    return ListTile(
      leading: Icon(OctIcons.git_commit),
      title: Text(
          message ?? 'No commit message',
      maxLines: 1, overflow: TextOverflow.ellipsis
      ),
      subtitle: Text(authorName ?? 'Unknown author'),
      trailing: Text(sha?.substring(0, 7) ?? 'No SHA'),
      onTap: () {
        Get.to(() => CommitRoute(repoFullName: commit.repository!.fullName, commitSha: sha!));
      },
    );
  }
}