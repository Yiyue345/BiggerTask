import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';

class ContributorsRoute extends StatefulWidget {
  final String repoFullName;

  const ContributorsRoute({super.key, required this.repoFullName});

  @override
  State<ContributorsRoute> createState() => _ContributorsRouteState();
}

class _ContributorsRouteState extends State<ContributorsRoute> {
  bool _isLoading = true;
  bool _hasMore = true;
  final List<ContributorUser> _contributors = [];
  int page = 1;

  Future<void> _getContributors() async {
    List<ContributorUser> contributors = await Methods.getRepositoryContributors(
      token: Global.token,
      repoFullName: widget.repoFullName,
      page: page,
    );
    if (contributors.length < 30) {
      _hasMore = false;
    }

    _contributors.addAll(contributors);
    page++;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getContributors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
          child: ListView.builder(
            itemCount: _contributors.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _contributors.length) {
                  _getContributors();
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return KeepAliveWrapper(
                    child: GitHubUserTile(
                      user: _contributors[index],
                    )
                );
              }
          ),
          onRefresh: () async {
            setState(() {
              _isLoading = true;
              _hasMore = true;
              _contributors.clear();
              page = 1;
            });
            await _getContributors();
          }
      )
      ,
    );
  }
}