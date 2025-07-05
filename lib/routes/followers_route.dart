import 'package:biggertask/common/static.dart';
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
        title: const Text('粉丝'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
        child: RefreshIndicator(
            onRefresh: () => _getFollowers(_page),
            child: ListView.builder(
                itemCount: widget.followersCount > 50
                    ? 51
                    : widget.followersCount,
                itemBuilder: (context, index) {
                  if (index == 50 && widget.followersCount > 50) {
                    return ListTile(
                      // todo 换页
                    );
                  }

                  return GitHubUserTile(user: _followers[index]);

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

    _isLoading = false;

    _followers = followers;

    setState(() {

    });

  }

}
