import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/tree_item.dart';
import 'package:flutter/material.dart';

class RepoFilesRoute extends StatefulWidget {
  final String repoFullName;

  const RepoFilesRoute({
    super.key,
    required this.repoFullName
  });

  @override
  State<StatefulWidget> createState() => _RepoFilesRouteState();
}

class _RepoFilesRouteState extends State<RepoFilesRoute> {
  bool _isLoading = true;
  List<TreeItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    try {
      final response = await Methods.getRepoTree(
        repoFullName: widget.repoFullName,
        token: Global.token,
        recursive: true
      );

      final List<dynamic> tree = response['tree'];
      setState(() {
        _items = tree.map((item) => TreeItem.fromJson(item)).toList();
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
              title: Text(item.path),
              onTap: () {

              },
            );
          }
      )
      ,
    );
  }
}
