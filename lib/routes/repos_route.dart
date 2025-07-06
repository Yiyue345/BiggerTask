
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';

import '../common/static.dart';

class RepositoriesRoute extends StatefulWidget {

  const RepositoriesRoute({super.key, required this.user});

  final GitHubUser user;

  @override
  State<StatefulWidget> createState() => _RepositoriesRouteState();
}

class _RepositoriesRouteState extends State<RepositoriesRoute> {
  Dio dio = Dio();
  List<Repository> repositories = [];
  late GitHubUser _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${_user.login} 的',
                style: TextStyle(fontSize: 12)
            ),
            Text('仓库列表', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await _initRepositories();
          },
          child: FutureBuilder<List<Repository>>(
              future: _user.login == Global.gitHubUser?.login // 如果是登录用户的仓库
                  ? _getOwnRepositories()
                  : _getRepositories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text('加载失败: ${snapshot.error}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }
                else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, color: Colors.grey, size: 48),
                        SizedBox(height: 16),
                        Text('没有仓库', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final repo = snapshot.data![index];
                        return ListTile(
                          title: Text(repo.name),
                          subtitle: Text(repo.description ?? '无描述'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(OctIcons.star, size: 16,),
                              Text(' ${repo.stargazersCount}'),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => RepositoryRoute(repository: repo));
                          }
                        );
                      }
                  );
                }
              }
          )
      ),
    );
  }

  Future<List<Repository>> _getOwnRepositories() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/user/repos',
        options: Options(
          headers: {
            'Authorization' : 'Bearer ${Global.token}',
          }
        )
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data; // 已经是List<dynamic>了
        // print(response.data);
        return jsonList.map((json) => Repository.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching repositories: $e');
      print('Error fetching repositories: $e');
      return [];
    }
  }

  Future<List<Repository>> _getRepositories() async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
          'https://api.github.com/users/${_user.login}/repos',
          options: Options(
              headers: {
                'Authorization' : 'Bearer ${Global.token}',
              }
          )
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data; // 已经是 List<dynamic> 了
        // print(response.data);
        return jsonList.map((json) => Repository.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching repositories: $e');
      print('Error fetching repositories: $e');
      return [];
    }
  }


  Future<void> _initRepositories() async {
    try {
      repositories = _user.login == Global.gitHubUser?.login
          ? await _getOwnRepositories()
          : await _getRepositories();
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error initializing repositories: $e');
      print('Error initializing repositories: $e');
    }
  }

}
