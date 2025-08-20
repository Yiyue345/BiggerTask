import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/repository_content.dart';
import 'package:biggertask/routes/repo/file_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepoFilesRoute extends StatefulWidget {
  final String repoFullName;
  final String? currentPath;

  const RepoFilesRoute({
    super.key,
    required this.repoFullName,
    this.currentPath
  });

  @override
  State<StatefulWidget> createState() => _RepoFilesRouteState();
}

class _RepoFilesRouteState extends State<RepoFilesRoute> {
  bool _isLoading = true;
  List<RepositoryContent> _items = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    try {
      _items = await Methods.getRepoContent(
          token: Global.token,
          repoFullName: widget.repoFullName,
        path: widget.currentPath
      );

      _items.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.path.compareTo(b.path);
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading files: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currentPath != null
            ? widget.currentPath!
            : ''
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              leading: Icon(
                item.isFile ? Icons.insert_drive_file : Icons.folder,
              ),
              title: Text(item.name),
              subtitle: item.isFile && item.size != null
                  ? Text(item.sizeFormatted)
                  : null,
              onTap: () {
                if (item.isDirectory) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RepoFilesRoute(
                          repoFullName: widget.repoFullName,
                        currentPath: item.path,
                      ))
                  );
                }
                else if (item.isFile) {
                  Get.to(() => FileRoute(
                      repoFullName: widget.repoFullName,
                      filePath: item.path
                  ));
                }
              },
            );
          }
      )
      ,
    );
  }
}
