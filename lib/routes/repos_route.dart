
import 'package:biggertask/common/methods.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
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
  List<Repository> repositories = [];
  late GitHubUser _user;
  int _reposPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  // 缓存已标星状态
  final Map<String, Future<bool>> _starredCache = {};

  Future<bool> _getStarredStatus(String fullname) {
    return _starredCache.putIfAbsent(
        fullname,
            () => Methods.isStarred(fullname, Global.token)
    );
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _loadRepositories();
  }

  Future<void> _loadRepositories({bool refresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (refresh) {
        _reposPage = 1;
        repositories.clear();
      }
    });

    try {
      late final newRepos;
      if (_user.login == Global.gitHubUser!.login) {
        newRepos = await Methods.getOwnRepositories(
            Global.token,
            page: _reposPage
        );
      }
      else {
        newRepos = await Methods.getRepositories(
            Global.token,
            _user.login,
            page: _reposPage
        );
      }


      setState(() {
        if (refresh) {
          repositories = newRepos;
        }
        else {
          repositories.addAll(newRepos);
        }
        _reposPage++;
        _hasMore = newRepos.length >= 30; // 假设每页最多30个仓库
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: '加载失败: $e');
      print('Error loading repositories: $e');
    }

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
            Text('仓库', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () => _loadRepositories(refresh: true),
          child: repositories.isEmpty && _isLoading
              ? Center(child: CircularProgressIndicator(),)
              :
          ListView.builder(
              itemCount: repositories.length + 1,
              itemBuilder: (context, index) {
                if (index < repositories.length) {
                  final repo = repositories[index];
                  return KeepAliveWrapper(
                      child: ListTile(
                          title: Text(repo.name),
                          subtitle: Text(repo.description ?? '无描述'),
                          trailing: FutureBuilder(
                              future: _getStarredStatus(repo.fullName),
                              builder: (context, starSnapshot) {
                                if (starSnapshot.connectionState == ConnectionState.done) {
                                  bool isStarred = starSnapshot.data ?? false;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(OctIcons.star, size: 16, color: isStarred ? Colors.amber : null),
                                      Text(' ${repo.stargazersCount}',
                                          style: TextStyle(
                                            color: isStarred ? Colors.amber : null,
                                          )
                                      ),

                                    ],
                                  );
                                }
                                else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(OctIcons.star, size: 16,),
                                      Text(' ${repo.stargazersCount}'),

                                    ],
                                  );
                                }
                              }
                          ),
                          onTap: () {
                            Get.to(() => RepositoryRoute(repository: repo));
                          }
                      )
                  );
                }
                else {
                  if (_hasMore && !_isLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _loadRepositories();
                    });
                  }

                  if (_isLoading && _hasMore) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text('没有更多仓库了', style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }
                }

              }
          )

      ),
    );
  }

  // Future<void> _initRepositories({int page = 1, int perPage = 30}) async {
  //   try {
  //     repositories = _user.login == Global.gitHubUser?.login
  //         ? await
  //         : await _getRepositories();
  //     setState(() {});
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Error initializing repositories: $e');
  //     print('Error initializing repositories: $e');
  //   }
  // }

}

