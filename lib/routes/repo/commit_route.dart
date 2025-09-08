 import 'dart:math';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/commit.dart';
import 'package:biggertask/routes/code_settings_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommitRoute extends StatefulWidget {
  final String repoFullName;
  final String commitSha;
  final String relativeTime;

  const CommitRoute({
    super.key,
    required this.repoFullName,
    required this.commitSha,
    required this.relativeTime,
  });

  @override
  State<StatefulWidget> createState() => _CommitRouteState();
}

class _CommitRouteState extends State<CommitRoute> {
  bool _isLoading = true;
  late final Commit? _commit;
  
  final CodeSettingsController controller = Get.put(CodeSettingsController());

  @override
  void initState() {
    super.initState();
    _loadCommit();
  }

  Future<void> _loadCommit() async {
    try {
      final Commit? commit = await Methods.getCommit(
        token: Global.token,
        repoFullName: widget.repoFullName,
        commitSha: widget.commitSha,
      );

      setState(() {
        _commit = commit;
        _isLoading = false;
      });

      // 测试

      if (_commit != null && _commit.files != null) {
        for (CommitFile file in _commit.files!) {
          if (file.filename != null) {
            print('File: ${file.filename}');
          }
          if (file.patch != null) {
            List<String> lines = file.patch!.split('\n');
            for (String line in lines) {
              print(line);
            }
          }
        }
      }
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            if (_commit != null) ...[
              if (_commit.commit != null && _commit.commit!.message != null && _commit.author != null )
                CommitHeader(
                    avatarUrl: _commit.author!.avatarUrl,
                    authorName: _commit.author!.login,
                    commitMessage: _commit.commit!.message!,
                    relativeTime: widget.relativeTime
                ),
              SizedBox(
                height: 24,
              ),
              Divider(
                height: 0,
              ),
              if (_commit.stats != null || _commit.files != null)
                // todo: 替换硬编码文本
                ListTile(
                  tileColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                  title: Text('${_commit.files!.length} 个文件已更改'),
                  subtitle: Row(
                    children: [
                      if (_commit.stats!.additions != null)
                        Text(
                          '${_commit.stats!.additions} 个添加',
                          style: TextStyle(color: Colors.green),
                        ),
                      SizedBox(width: 8,),
                      if (_commit.stats!.deletions != null)
                        Text(
                          '${_commit.stats!.deletions} 个删除',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              if (_commit.files != null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // 禁止内部滚动
                  itemCount: _commit.files!.length,
                    itemBuilder: (context, index) {
                    return CommitFileWidget(file: _commit.files![index], context: context,);
                  }
                )
            ]

          ],
        ),
      )
      ,
    );
  }
}

class CommitHeader extends StatelessWidget {
  final String avatarUrl;
  final String authorName;
  final String commitMessage;
  final String relativeTime;

  const CommitHeader({
    super.key,
    required this.avatarUrl,
    required this.authorName,
    required this.commitMessage,
    required this.relativeTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                      radius: 12,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => UserInfoRoute(username: authorName));
                        },
                      ),
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => UserInfoRoute(username: authorName));
                      },
                      child: Text(
                        authorName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                        AppLocalizations.of(context)!.written,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      ),
                    ),
                    Spacer(),
                    Text(
                      relativeTime,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8,),
                Text(
                  commitMessage,
                  style: TextStyle(
                      fontSize: 14
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}

class CommitFileWidget extends StatelessWidget {
  final CommitFile file;
  final BuildContext context;

  CommitFileWidget({super.key, required this.file, required this.context});

  final CodeSettingsController controller = Get.find();

  late final List<String> lines;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  final List _maxLineWidthlist = [null];

  double _calculateMaxLineWidth() {
    if (_maxLineWidthlist[0] != null) return _maxLineWidthlist[0]!;

    double maxWidth = 0;
    final textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
    );

    for (String line in lines) {
      _textPainter.text = TextSpan(
        text: line.isEmpty ? ' ' : line,
        style: textStyle,
      );
      _textPainter.layout();
      maxWidth = maxWidth < _textPainter.width ? _textPainter.width : maxWidth;
    }

    _maxLineWidthlist[0] = maxWidth + (controller.showLineNumber.value ? 88 : 28); // 考虑行号和间距
    return _maxLineWidthlist[0]!;
  }
  @override
  Widget build(BuildContext context) {
    if (file.filename == null || file.patch == null || file.additions == null || file.deletions == null || file.changes == null) {
      return SizedBox.shrink();
    }
    lines = file.patch!.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 0,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(file.filename!),
          ),
        ),
        Divider(
          height: 0,
          color: Theme.of(context).colorScheme.secondary,
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  if (lines[index] == '\\ No newline at end of file') {
                    return SizedBox.shrink();
                  }
                  return IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lines[index].startsWith('+')
                                ? Colors.green.withValues(alpha: 0.2)
                                : lines[index].startsWith('-')
                                ? Colors.red.withValues(alpha: 0.2)
                                : Colors.transparent,
                          ),
                          child: _buildCodeLine(index),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
        ),

      ],
    );
  }


  Widget _buildCodeLine(int index) {
    final line = lines[index];
    return IntrinsicHeight( // 高度一致
      child: Container(
        width: max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
        color: lines[index].startsWith('+')
            ? Colors.green.withValues(alpha: 0.2)
            : lines[index].startsWith('-')
            ? Colors.red.withValues(alpha: 0.2)
            : Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(
            //   child: Obx(() => controller.showLineNumber.value
            //       ? Container(
            //     width: 30,
            //     alignment: Alignment.topRight,
            //     decoration: BoxDecoration(
            //         color: Theme.of(context).colorScheme.secondary,
            //         border: Border(
            //             right: BorderSide(
            //                 color: Colors.grey,
            //                 width: 1
            //             )
            //         )
            //     ),
            //     child: Text(
            //       '${index + 1} ',
            //       style: TextStyle(
            //           color: Theme.of(context).colorScheme.secondary.computeLuminance() > 0.5 ? Colors.black54 : Colors.white54,
            //           fontSize: 12
            //       ),
            //     ),
            //   )
            //       : SizedBox(width: 0, height: double.infinity,)),
            // ),

            SizedBox(width: 8),
            Text(
              line.isEmpty ? ' ' : line,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                // color: Colors.black87,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
