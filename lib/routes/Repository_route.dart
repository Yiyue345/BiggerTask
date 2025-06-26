import 'dart:convert';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/repo_readme.dart';
import 'package:biggertask/models/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' hide Text;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepositoryRoute extends StatefulWidget {
  const RepositoryRoute({super.key, required this.repository});
  final Repository repository;

  @override
  State<RepositoryRoute> createState() => _RepositoryRouteState();
}

class _RepositoryRouteState extends State<RepositoryRoute> {


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
                title: Text(widget.repository.owner.login),
              ),
              SizedBox(height: 8,),
              ListTile(
                title: Text(
                    widget.repository.name,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onTap: () {},
              ),
              FutureBuilder(
                  future: _getReadme(),
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
                            markdownGenerator: MarkdownGenerator(

                            ),
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

}
