
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
              ),
              SizedBox(height: 8,),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.repository.name,
                      style: TextStyle(
                          fontSize: 32,
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
                            }
                      ,
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
                            Text('Error: ${snapshot.error}'),
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

                          ),
                        );
                      }
                      else {
                        return Center(
                          child: Text('No README available'),
                        );
                      }
                    }
                    else {
                      return Center(
                        child: Text('No data found'),
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
    _isStarred = await Methods.isStarred(widget.repository.fullName, Global.token);
    setState(() {

    });
  }

  Future<void> _showStarDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_isStarred! ? '取消收藏' : '收藏'),
          content: Text(_isStarred! ? '确定取消收藏该仓库吗？' : '确定收藏该仓库吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (_isStarred!) {
                  await Methods.unstarRepository(widget.repository.fullName, Global.token);
                  widget.repository.stargazersCount--;
                } else {
                  await Methods.starRepository(widget.repository.fullName, Global.token);
                  widget.repository.stargazersCount++;
                }
                Navigator.of(context).pop();
                await _checkStarredStatus();

              },
              child: Text(_isStarred! ? '取消收藏' : '收藏'),
            ),
          ],
        );
      },
    );
  }

}
