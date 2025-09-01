import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrganizationsRoute extends StatefulWidget{
  final String username;

  const OrganizationsRoute({super.key, required this.username});

  @override
  State<StatefulWidget> createState() => _OrganizationsRouteState();
}

class _OrganizationsRouteState extends State<OrganizationsRoute> {
  List<SimpleOrganization> _organizations = [];
  bool _isLoading = true;
  int _page = 1;
  bool _hasMore = true;

  Future<void> _loadOrganizations({bool refresh = false}) async {

    setState(() {
      _isLoading = true;
      if (refresh) {
        _page = 1;
        _organizations.clear();
      }
    });

    try {
      final newOrganizations = await _getOrganizations(_page);

      setState(() {
        if (refresh) {
          _organizations = newOrganizations;
        }
        else {
          _organizations.addAll(newOrganizations);
        }
        _page++;
        _hasMore = newOrganizations.length >= 30; // 假设每页最多30个仓库
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: '${AppLocalizations.of(context)!.loadFailed}: $e');
      print('Error loading organzation organizations: $e');
    }

  }

  @override
  void initState() {
    _loadOrganizations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  AppLocalizations.of(context)!.whose(widget.username),
                  style: TextStyle(fontSize: 12)
              ),
              Text(
                  AppLocalizations.of(context)!.organizations,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              )
            ],
          )

      ),
      body: RefreshIndicator(
          child: _organizations.isEmpty && _isLoading
              ? Center(child: CircularProgressIndicator(),)
              :
          ListView.builder(
              itemCount: _organizations.length + 1,
              itemBuilder: (context, index) {
                if (index < _organizations.length) {
                  return KeepAliveWrapper(
                      child: GitHubUserTile.fromOrganization(organization: _organizations[index],)
                  );
                }
                else {
                  if (_hasMore && !_isLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _loadOrganizations();
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
                        child: Text(AppLocalizations.of(context)!.noMore, style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }
                }

              }
          ),
          onRefresh: () => _loadOrganizations(refresh: true)
      ),
    );
  }

  Future<List<SimpleOrganization>> _getOrganizations(int page) async {
    if (widget.username == Global.gitHubUser!.login) {
      return await Methods.getMyOrganizations(token: Global.token, page: page);
    } else {
      return await Methods.getUserOrganizations(username: widget.username, token: Global.token, page: page);
    }
  }
}

class OrganizationMembersRoute extends StatefulWidget{
  final String organization;

  const OrganizationMembersRoute({super.key, required this.organization});

  @override
  State<StatefulWidget> createState() => _OrganizationMembersRouteState();
}

class _OrganizationMembersRouteState extends State<OrganizationMembersRoute> {
  List<SimpleGitHubUser> _members = [];
  bool _isLoading = true;
  int _page = 1;
  bool _hasMore = true;

  Future<void> _loadMembers({bool refresh = false}) async {

    setState(() {
      _isLoading = true;
      if (refresh) {
        _page = 1;
        _members.clear();
      }
    });

    try {
      final newMembers = await Methods.getOrganizationMembers(
          token: Global.token,
          orgName: widget.organization,
          page: _page
      );

      setState(() {
        if (refresh) {
          _members = newMembers;
        }
        else {
          _members.addAll(newMembers);
        }
        _page++;
        _hasMore = newMembers.length >= 30; // 假设每页最多30个仓库
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: '${AppLocalizations.of(context)!.loadFailed}: $e');
      print('Error loading organzation members: $e');
    }

  }

  @override
  void initState() {
    _loadMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  AppLocalizations.of(context)!.whose(widget.organization),
                  style: TextStyle(fontSize: 12)
              ),
              Text(
                  AppLocalizations.of(context)!.members,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
              )
            ],
          )

      ),
      body: RefreshIndicator(
          child: _members.isEmpty && _isLoading
              ? Center(child: CircularProgressIndicator(),)
              :
          ListView.builder(
              itemCount: _members.length + 1,
              itemBuilder: (context, index) {
                if (index < _members.length) {
                  return KeepAliveWrapper(
                      child: GitHubUserTile(user: _members[index],)
                  );
                }
                else {
                  if (_hasMore && !_isLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _loadMembers();
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
                        child: Text(AppLocalizations.of(context)!.noMore, style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }
                }

              }
          ),
          onRefresh: () => _loadMembers(refresh: true)
      ),
    );
  }
}