import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FollowersRoute extends StatefulWidget {
  const FollowersRoute({super.key, required this.login, required this.followersCount});
  final String login;
  final int followersCount;


  @override
  State<FollowersRoute> createState() => _FollowersRouteState();
}

class _FollowersRouteState extends State<FollowersRoute> {
  int _page = 1;
  late final _maxPage;
  bool _isLoading = false;

  List<SimpleGitHubUser> _followers = [];



  @override
  initState() {
    super.initState();
    _maxPage = (widget.followersCount / 50).ceil();
    _getFollowers(_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.login,
              style: TextStyle(
                fontSize: 12
              ),
            ),
            Text(
                AppLocalizations.of(context)!.followers,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
        child: RefreshIndicator(
            onRefresh: () => _getFollowers(_page),
            child: ListView.builder(
                itemCount: _followers.length + (widget.followersCount > 50 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _followers.length && widget.followersCount > 50) { // 数量大于 50 就显示翻页按钮
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: _page > 1 ? () {
                                _page--;
                                _getFollowers(_page);
                              } : null,
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                  shadowColor: WidgetStatePropertyAll(Colors.transparent)
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.previousPage,
                                style: TextStyle(
                                  color: _page > 1
                                      ? Colors.black
                                      : Colors.grey
                                ),
                              ),
                          ),
                          Text('$_page / $_maxPage'),
                          ElevatedButton(
                            onPressed: _page < _maxPage ? () {
                              _page++;
                              _getFollowers(_page);
                            } : null,
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                shadowColor: WidgetStatePropertyAll(Colors.transparent)
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.nextPage,
                              style: TextStyle(
                                  color: _page < _maxPage
                                      ? Colors.black
                                      : Colors.grey
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (index < _followers.length) {
                    return GitHubUserTile(
                        key: ValueKey(_followers[index].id),
                        user: _followers[index]
                    );
                  }

                  return SizedBox.shrink(); // 如果 index 超出范围，返回一个空的 Widget

                }
            )),
      ),
    );
  }

  Future<void> _getFollowers(int page) async {

    _isLoading = true;

    Dio dio = Dio();
    final response = await dio.get(
      'https://api.github.com/users/${widget.login}/followers',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${Global.token}',
        }
      ),
      queryParameters: {
        'page': page,
        'per_page': 50,
      },
    );

    List<SimpleGitHubUser> followers = [];

    if (response.statusCode == 200) {
      final data = response.data as List;
      followers = data.map((item) => SimpleGitHubUser.fromJson(item)).toList();

    }

    _followers = followers;
    _isLoading = false;
    setState(() {

    });

  }

}

class FollowingRoute extends StatefulWidget {
  const FollowingRoute({super.key, required this.login, required this.followingCount});
  final String login;
  final int followingCount;


  @override
  State<FollowingRoute> createState() => _FollowingRouteState();
}

class _FollowingRouteState extends State<FollowingRoute> with AutomaticKeepAliveClientMixin {
  int _page = 1;
  late final _maxPage;
  bool _isLoading = false;

  List<SimpleGitHubUser> _followings = [];

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    _maxPage = (widget.followingCount / 50).ceil();
    _getFollowings(_page);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.login,
              style: TextStyle(
                  fontSize: 12
              ),
            ),
            Text(
              AppLocalizations.of(context)!.followings,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Center(
        child: RefreshIndicator(
            onRefresh: () => _getFollowings(_page),
            child: ListView.builder(
                itemCount: _followings.length + (widget.followingCount > 50 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _followings.length && widget.followingCount > 50) { // 数量大于 50 就显示翻页按钮
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _page > 1 ? () {
                              _page--;
                              _getFollowings(_page);
                            } : null,
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                shadowColor: WidgetStatePropertyAll(Colors.transparent)
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.previousPage,
                              style: TextStyle(
                                  color: _page > 1
                                      ? Colors.black
                                      : Colors.grey
                              ),
                            ),
                          ),
                          Text('$_page / $_maxPage'),
                          ElevatedButton(
                            onPressed: _page < _maxPage ? () {
                              _page++;
                              _getFollowings(_page);
                            } : null,
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                                shadowColor: WidgetStatePropertyAll(Colors.transparent)
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.nextPage,
                              style: TextStyle(
                                  color: _page < _maxPage
                                      ? Colors.black
                                      : Colors.grey
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (index < _followings.length) {
                    // 如果 index 在 _followings 的范围内，返回对应的 GitHubUserTile
                    return GitHubUserTile(
                        key: ValueKey(_followings[index].id),
                        user: _followings[index]
                    );
                  }

                  return SizedBox.shrink(); // 如果 index 超出范围，返回一个空的 Widget

                }
            )),
      ),
    );
  }

  Future<void> _getFollowings(int page) async {

    _isLoading = true;

    Dio dio = Dio();
    final response = await dio.get(
      'https://api.github.com/users/${widget.login}/following',
      options: Options(
          headers: {
            'Authorization': 'Bearer ${Global.token}',
          }
      ),
      queryParameters: {
        'page': page,
        'per_page': 50,
      },
    );

    List<SimpleGitHubUser> followings = [];

    if (response.statusCode == 200) {
      final data = response.data as List;
      followings = data.map((item) => SimpleGitHubUser.fromJson(item)).toList();

    }

    _followings = followings;
    _isLoading = false;

    setState(() {

    });

  }

}
