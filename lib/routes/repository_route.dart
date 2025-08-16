import 'package:biggertask/html_markdown/custom_node.dart';
import 'package:biggertask/html_markdown/video.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/routes/release_list_route.dart';
import 'package:biggertask/routes/repo_files_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/repo_readme.dart';
import 'package:biggertask/models/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:markdown_widget/markdown_widget.dart';

class RepositoryRoute extends StatefulWidget {
  const RepositoryRoute({super.key, required this.repository});
  final Repository repository;

  @override
  State<RepositoryRoute> createState() => _RepositoryRouteState();
}

class _RepositoryRouteState extends State<RepositoryRoute> {

  bool? _isStarred;
  late final Future<RepositoryReadme?> _readmeFuture;

  @override
  void initState() {
    super.initState();
    _checkStarredStatus();
    _readmeFuture = _getReadme(); // 防止 futureBuilder 重复调用
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: RefreshIndicator(
          child: ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.repository.owner.avatarUrl),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.repository.owner.login)
                  ],
                ),
                onTap: () {
                  Get.to(() => UserInfoRoute(username: widget.repository.owner.login));
                },
              ),
              SizedBox(height: 8,),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.repository.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4,),
                        if (widget.repository.private)...[
                          Icon(OctIcons.lock, size: 17,),
                          SizedBox(width: 4),
                          Text('Private', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                        ]
                        else...[
                          Icon(OctIcons.repo, size: 17,),
                          SizedBox(width: 4),
                          Text('Public', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                        ],
                        SizedBox(width: 8,),
                        Icon(OctIcons.repo_forked, size: 17,),
                        SizedBox(width: 4,),
                        Text(
                          widget.repository.forksCount.toString(),
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),

                      ],
                    ),

                  ],
                ),

              ),
              if (widget.repository.fork)
                Padding(
                    padding: EdgeInsets.only(left: 20),
                  child: FutureBuilder(
                      future: Methods.getRepository(
                          fullName: widget.repository.fullName,
                          token: Global.token
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError && snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              if (snapshot.data!.parent != null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RepositoryRoute(repository: snapshot.data!.parent!)));
                                // Get.to(() => RepositoryRoute(repository: snapshot.data!.parent!)); // Get 在这里用不了！！！
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                    OctIcons.repo_forked,
                                  size: 17,
                                ),
                                SizedBox(width: 4,),
                                Text(
                                    AppLocalizations.of(context)!.forkedFrom(snapshot.data!.parent!.fullName),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationStyle: TextDecorationStyle.solid,
                                        decorationColor: Theme.of(context).colorScheme.secondary,
                                        color: Theme.of(context).colorScheme.secondary
                                    )
                                ),

                              ],
                            ),
                          );
                        }
                        return Text('');
                      }
                  ),
                )
              ,
              // 标星按钮
              SizedBox(
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 8,),
                    TextButton.icon(
                        onPressed: _isStarred == null
                            ? null
                            : () async {
                              await _showStarDialog();
                              await _checkStarredStatus();
                              setState(() {

                              });
                            },
                        icon: Icon(
                          OctIcons.star,
                          size: 16,
                        ),
                      label: Text('${widget.repository.stargazersCount}'),
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                            _isStarred == null
                                ? Colors.grey
                                : _isStarred!
                                ? Colors.white : Colors.grey
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                            _isStarred == null
                                ? Colors.transparent
                                : _isStarred!
                                ? Colors.yellow[700] : Colors.transparent
                        ),
                        minimumSize: WidgetStatePropertyAll(Size(0, 0)),
                        side: WidgetStatePropertyAll(
                            BorderSide(
                              color: _isStarred == null
                                  ? Colors.transparent
                                  : _isStarred!
                                  ? Colors.orange[500]!
                                  : Colors.transparent,
                              width: 3.0,
                            )
                        )


                      ),
                    ),

                  ],
                ),

              ),
              ListTile(
                leading: Icon(OctIcons.tag),
                title: Text(AppLocalizations.of(context)!.release),
                trailing: FutureBuilder(
                    future: Methods.getReleaseCount(token: Global.token, repoFullName: widget.repository.fullName),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                        return Text(snapshot.data.toString());
                      }
                      else {
                        return SizedBox();
                      }
                    }
                ),
                onTap: () {
                  Get.to(() => ReleaseListRoute(repoFullName: widget.repository.fullName));
                },
              ),
              ListTile(
                leading: Icon(OctIcons.code),
                title: Text(AppLocalizations.of(context)!.code),
                onTap: () {
                  Get.to(() => RepoFilesRoute(repoFullName: widget.repository.fullName));
                },
              ),

              FutureBuilder(
                  future: _readmeFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                            padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 48),
                            SizedBox(height: 16),
                            Text(AppLocalizations.of(context)!.readmeLoadFailed + snapshot.error.toString()),
                          ],
                        ),
                      );
                    }
                    else if (snapshot.hasData) {
                      RepositoryReadme? readme = snapshot.data;
                      if (readme != null) {

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MarkdownWidget(
                              data: utf8.decode(base64.decode(readme.content.replaceAll('\n', ''))),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            markdownGenerator: MarkdownGenerator(
                              generators: [
                                videoGeneratorWithTag
                              ],
                              textGenerator: (node, config, visitor) =>
                                  CustomTextNode(node.textContent, config, visitor),
                              richTextBuilder: (span) => Text.rich(span)
                            ),
                          ),
                        );
                      }
                      else {
                        return Center(
                          child: Text(AppLocalizations.of(context)!.noReadme),
                        );
                      }
                    }
                    else {
                      return Center(
                        child: Text(AppLocalizations.of(context)!.noReadme),
                      );
                    }
                  }
              )
            ],
          ),
          onRefresh: () async {
            await _checkStarredStatus();
      }),
    );
  }

  Future<RepositoryReadme?> _getReadme() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/repos/${widget.repository.fullName}/readme',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
            'Authorization': 'Bearer ${Global.token}', // Replace with your token
          },
        ),
      );

      if (response.statusCode == 200) {
        return RepositoryReadme.fromJson(response.data);
      } else {
        throw Exception('Failed to load readme: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching readme: $e');
      return null;
    }
  }

  Future<void> _checkStarredStatus() async {
    _isStarred = await Methods.isStarred(repoFullName: widget.repository.fullName, token: Global.token);
    setState(() {

    });
  }

  Future<void> _showStarDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_isStarred! ? AppLocalizations.of(context)!.unStar : AppLocalizations.of(context)!.star),
          content: Text(_isStarred! ? AppLocalizations.of(context)!.unStarMessage : AppLocalizations.of(context)!.starMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (_isStarred!) {
                  await Methods.unstarRepository(repoFullName: widget.repository.fullName, token: Global.token);
                  widget.repository.stargazersCount--;
                } else {
                  await Methods.starRepository(repoFullName: widget.repository.fullName, token: Global.token);
                  widget.repository.stargazersCount++;
                }
                Navigator.of(context).pop();
                await _checkStarredStatus();

              },
              child: Text(_isStarred! ? AppLocalizations.of(context)!.unStar : AppLocalizations.of(context)!.star),
            ),
          ],
        );
      },
    );
  }

}
