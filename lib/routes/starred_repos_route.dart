
import 'package:biggertask/common/methods.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';

import '../common/static.dart';

class StarredReposRoute extends StatefulWidget {

  const StarredReposRoute({super.key, required this.user});

  final GitHubUser user;

  @override
  State<StatefulWidget> createState() => _StarredReposRouteState();
}

class _StarredReposRouteState extends State<StarredReposRoute> {
  List<Repository> repositories = [];
  late GitHubUser _user;
  int _reposPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  // 缓存已标星状态
  final Map<String, Future<bool>> _starredCache = {};

  Future<bool> _getStarredStatus(String fullName) {
    return _starredCache.putIfAbsent(
        fullName,
        () => Methods.isStarred(repoFullName: fullName, token: Global.token)
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
      final newRepos = await Methods.getStarredRepositories(
          token: Global.token,
          username: _user.login,
        page: _reposPage
      );

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
      Fluttertoast.showToast(msg: '${AppLocalizations.of(context)!.loadFailed}: $e');
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
                AppLocalizations.of(context)!.whose(_user.login),
                style: TextStyle(fontSize: 12)
            ),
            Text(AppLocalizations.of(context)!.starRepositories, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                          subtitle: Text(repo.description ?? AppLocalizations.of(context)!.noDescription),
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
                        child: Text(AppLocalizations.of(context)!.noMoreRepos, style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }
                }
                
              }
          )

      ),
    );
  }

}

