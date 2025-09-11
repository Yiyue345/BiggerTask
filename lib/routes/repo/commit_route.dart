 import 'dart:math';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/commit.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/code_settings_route.dart';
import 'package:biggertask/routes/repo/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

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

class _CommitRouteState extends State<CommitRoute>
with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String relativeTime = '';
  late final Commit? _commit;
  late Repository? _repository;
  
  final CodeSettingsController controller = Get.put(CodeSettingsController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCommit();
  }

  Future<void> _loadCommit() async {
    try {
      final futures = [
        Methods.getRepository(
            fullName: widget.repoFullName,
            token: Global.token
        ),
        Methods.getCommit(
          token: Global.token,
          repoFullName: widget.repoFullName,
          commitSha: widget.commitSha,
        )
      ];

      final results = await Future.wait(futures);

      _repository = results[0] as Repository?;
      _commit = results[1] as Commit?;
      setState(() {
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading commit: $e');
    }

    final DateTime? createdAt = _commit?.commit?.author?.date != null
        ? DateTime.parse(_commit!.commit!.author!.date!).toLocal()
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
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.commit),
        actions: [
          IconButton(onPressed: () {
            Get.to(() => CodeSettingsRoute(
                showLineNumber: controller.showLineNumber.value,
                lineWrap: controller.lineWrap.value
            )
            );
          },
              icon: Icon(Icons.settings)
          )
        ],
        bottom: TabBar(
          controller: _tabController,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.changes,
              ),
              Tab(
                text: AppLocalizations.of(context)!.details,
              )
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          KeepAliveWrapper(
            child: _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      if (_commit != null && _commit.author != null) ...[
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(_commit.author!.avatarUrl),
                            radius: 12,
                          ),
                          onTap: () {
                            Get.to(() => UserInfoRoute(username: _commit.author!.login));
                          },
                        ),
                        SizedBox(width: 4,),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => UserInfoRoute(username: _commit.author!.login));
                          },
                          child: Text(
                            _commit.author!.login, // 仓库拥有者
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
                            if (_repository != null) {
                              Get.to(() => RepositoryRoute(repository: _repository!));
                            }
                          },
                          child: Text(
                            widget.repoFullName.split('/')[1], // 仓库名称
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primaryFixedDim,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ]

                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                ),
                if (_commit != null) ...[
                  if (_commit.commit != null && _commit.commit!.message != null && _commit.author != null )
                    CommitHeader(
                        avatarUrl: _commit.author!.avatarUrl,
                        authorName: _commit.author!.login,
                        commitMessage: _commit.commit!.message!,
                        relativeTime: relativeTime
                    ),
                  SizedBox(
                    height: 24,
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                  ),
                  if (_commit.stats != null || _commit.files != null)
                    ListTile(
                      tileColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                      title: Text(AppLocalizations.of(context)!.howManyFilesChanged(_commit.files!.length)),
                      subtitle: Row(
                        children: [
                          if (_commit.stats!.additions != null)
                            Text(
                              AppLocalizations.of(context)!.howManyAdditions(_commit.stats!.additions!),
                              style: TextStyle(color: Colors.green),
                            ),
                          SizedBox(width: 8,),
                          if (_commit.stats!.deletions != null)
                            Text(
                              AppLocalizations.of(context)!.howManyDeletions(_commit.stats!.deletions!),
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
          ),
          ),

          KeepAliveWrapper(child: _isLoading ? Center(
            child: CircularProgressIndicator(),
          )
              :
          Column(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.commits),
              ),
              ListTile(
                leading: Icon(OctIcons.git_commit),
                title: Text(widget.commitSha.substring(0, 7)),
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: widget.commitSha));

                  Fluttertoast.showToast(msg: AppLocalizations.of(context)!.copiedSuccessfully);
                },
              ),
              Divider(
                height: 0,
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.contributors),
              ),
              ListTile(
                leading: _commit != null && _commit.author != null
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(_commit.author!.avatarUrl),
                )
                    : Icon(Icons.person),
                title: Text(_commit != null && _commit.committer != null
                    ? _commit.committer!.login
                    : '未知',
                ),
                onTap: () {
                  if (_commit != null && _commit.author != null) {
                    Get.to(() => UserInfoRoute(username: _commit.committer!.login));
                  }
                },
              ),
              if (_commit != null && _commit.parents != null) ...[
                Divider(
                  height: 0,
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.parents),
                ),
                ..._commit.parents!.map((parent) => ListTile(
                  leading: Icon(OctIcons.git_commit),
                  title: Text(parent.sha!.substring(0, 7)),
                  onTap: () {
                    Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => CommitRoute(
                          repoFullName: widget.repoFullName,
                          commitSha: parent.sha!,
                        ))
                    );
                  },
                ))
              ]


            ],
          )
          )



        ],
      )

      ,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
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
  final List _maxLineWidthList = [null];

  double _calculateMaxLineWidth() {
    if (_maxLineWidthList[0] != null) return _maxLineWidthList[0]!;

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

    _maxLineWidthList[0] = maxWidth + (controller.showLineNumber.value ? 88 : 28); // 考虑行号和间距
    return _maxLineWidthList[0]!;
  }
  @override
  Widget build(BuildContext context) {
    if (file.filename == null || file.patch == null || file.additions == null || file.deletions == null || file.changes == null) {
      return SizedBox.shrink();
    }
    lines = file.patch!.split('\n');
    int additionIndex = 0;
    int deletionIndex = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

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
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
        ),

        Obx(() => controller.lineWrap.value
            ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              if (lines[index] == '\\ No newline at end of file') {
                return SizedBox.shrink();
              }
              final HunkHeader? hunkHeader = HunkHeader.parse(lines[index]);
              if (hunkHeader != null) {
                additionIndex = hunkHeader.newStart - 1;
                deletionIndex = hunkHeader.oldStart - 1;
                return Container(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  width: controller.lineWrap.value
                      ? MediaQuery.of(context).size.width
                      : max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 0.5
                                )
                            )
                        ),
                        width: 30,
                      ),
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        child: Text(
                          lines[index],
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),

                        ),
                      ))
                    ],
                  ),
                );
              }
              if (lines[index].startsWith('+')) {
                additionIndex += 1;
              } else if (lines[index].startsWith('-')) {
                deletionIndex += 1;
              } else {
                additionIndex += 1;
                deletionIndex += 1;
              }
              return IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: lines[index].startsWith('+')
                          ? Colors.green.withValues(alpha: 0.1)
                          : lines[index].startsWith('-')
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    child: _buildCodeLine(
                      index: index,
                      lineNumber: lines[index].startsWith('-') ? deletionIndex : additionIndex,
                    ),
                  )
              );
            }
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: controller.lineWrap.value
                ? MediaQuery.of(context).size.width
                : max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  if (lines[index] == '\\ No newline at end of file') {
                    return SizedBox.shrink();
                  }
                  final HunkHeader? hunkHeader = HunkHeader.parse(lines[index]);
                  if (hunkHeader != null) {
                    additionIndex = hunkHeader.newStart - 1;
                    deletionIndex = hunkHeader.oldStart - 1;
                    return Container(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      width: controller.lineWrap.value
                          ? MediaQuery.of(context).size.width
                          : max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 0.5
                                    )
                                )
                            ),
                            width: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: Text(
                              lines[index],
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (lines[index].startsWith('+')) {
                    additionIndex += 1;
                  } else if (lines[index].startsWith('-')) {
                    deletionIndex += 1;
                  } else {
                    additionIndex += 1;
                    deletionIndex += 1;
                  }
                  return IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          color: lines[index].startsWith('+')
                              ? Colors.green.withValues(alpha: 0.1)
                              : lines[index].startsWith('-')
                              ? Colors.red.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: _buildCodeLine(
                          index: index,
                          lineNumber: lines[index].startsWith('-') ? deletionIndex : additionIndex,
                        ),
                      )
                  );
                }
            ),
          ),
        )
        ),

        Container(
          height: 16,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        )
      ],
    );
  }


  Widget _buildCodeLine({required int index, required int lineNumber}) {
    final line = lines[index];
    return Obx(() => IntrinsicHeight( // 高度一致
      child: Container(
        width: controller.lineWrap.value
            ? MediaQuery.of(context).size.width
            : max(_calculateMaxLineWidth(), MediaQuery.of(context).size.width), // 色块要填满屏幕
        color: lines[index].startsWith('+')
            ? Colors.green.withValues(alpha: 0.08)
            : lines[index].startsWith('-')
            ? Colors.red.withValues(alpha: 0.08)
            : Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.showLineNumber.value
                ? Container(
              width: 30,
              color: lines[index].startsWith('+')
                  ? Colors.green.withValues(alpha: 0.12)
                  : lines[index].startsWith('-')
                  ? Colors.red.withValues(alpha: 0.12)
                  : Colors.transparent,
              child: Row(
                children: [
                  Container(
                      width: 30,
                      padding: EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: lines[index].startsWith('+')
                                      ? Colors.green.withValues(alpha: 0.6)
                                      : lines[index].startsWith('-')
                                      ? Colors.red.withValues(alpha: 0.6)
                                      : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
                                  width: 0.5
                              )
                          )
                      ),
                      alignment: Alignment.topRight,
                      child: Text(
                        lineNumber.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                  ),

                ],
              ),
            )
                : SizedBox.shrink(),

            SizedBox(width: 8),
            Flexible(
                child: Text(
              line.isEmpty ? ' ' : line,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                // color: Colors.black87,
              ),
            )),

          ],
        ),
      ),
    ));
  }
}

 class HunkHeader {
   final int oldStart;
   final int oldCount;
   final int newStart;
   final int newCount;
   final String? functionContext;

   HunkHeader({
     required this.oldStart,
     required this.oldCount,
     required this.newStart,
     required this.newCount,
     this.functionContext,
   });

   static HunkHeader? parse(String line) {
     if (!line.startsWith('@@')) return null;

     // 使用正则表达式解析
     final regex = RegExp(r'^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@(.*)$');
     final match = regex.firstMatch(line);

     if (match == null) return null;

     return HunkHeader(
       oldStart: int.parse(match.group(1)!),
       oldCount: int.tryParse(match.group(2) ?? '') ?? 1,
       newStart: int.parse(match.group(3)!),
       newCount: int.tryParse(match.group(4) ?? '') ?? 1,
       functionContext: match.group(5)?.trim().isEmpty == true
           ? null
           : match.group(5)?.trim(),
     );
   }
 }

