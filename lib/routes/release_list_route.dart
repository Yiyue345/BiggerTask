import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/routes/release_route.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReleaseListRoute extends StatefulWidget {
  final String repoFullName;
  ReleaseListRoute({
    super.key,
    required this.repoFullName,
  });

  @override
  State<StatefulWidget> createState() => _ReleaseListRouteState();
}

class _ReleaseListRouteState extends State<ReleaseListRoute> {
  List<Release> _releases = [];
  int _page = 1;
  bool _isLoaded = false;
  bool _isLoading = false;
  bool _hasMore = true;
  
  @override
  void initState() {
    super.initState();
    _loadReleases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
          onRefresh: () async {
            _page = 1;
            _releases.clear();
            _hasMore = true;
            await _loadReleases();
          },
          child: _isLoaded 
              ? _releases.isEmpty 
                ? Center(
                    child: Text('暂无发行版'),
                  )
                : ListView.builder(
              itemCount: _releases.length + (_hasMore ? 1 : 0) ,
              itemBuilder: (context, index) {
                if (index == _releases.length) {
                  if (!_isLoading) {
                    _loadReleases();
                  }
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return KeepAliveWrapper(
                    child: ListTile(
                      title: Text(
                        _releases[index].name.isEmpty ? '未命名' : _releases[index].name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _formatDateTime(_releases[index].createdDateTime),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => ReleaseRoute(release: _releases[index], repositoryName: widget.repoFullName));
                      },
                    )
                );
              }
          )
              : Center(
                child: CircularProgressIndicator(),
              )
      ),
    );
  }

  Future<void> _loadReleases() async {
    _isLoading = true;
    Methods.getReleases(token: Global.token, repoFullName: widget.repoFullName, page: _page).then((response) {
      setState(() {
        _releases.addAll(response);
        _hasMore = response.length == 30; // 假设每页最多30个发布
        _isLoading = false;
        _isLoaded = true;
        _page++;
      });
    });
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} 分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} 小时前';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} 天前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} 个月前';
    } else {
      return '${(difference.inDays / 365).floor()} 年前';
    }
  }
}
