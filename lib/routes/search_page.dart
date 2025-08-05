import 'dart:async';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/models/search.dart';
import 'package:biggertask/widgets/event_tile.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _controller = TextEditingController();
  String _searchText = '';
  Timer? _debounceTimer;
  int _page = 1;
  List<Repository> _repositories = [];

  // final List _options = ['commits', 'issues', 'pull requests', 'repositories', 'code', 'topics', 'users'];
  // final List<bool> _selectedOptions = [false, false, false, false, false, false, false];

  // todo: 打补丁支持多语言
  final Map<String, bool> _selectedOptions = {
    'commits': true,
    'issues': true,
    'pull requests': true,
    'repositories': true,
    'code': true,
    'topics': true,
    'users': true,
  };

  void _showCustomMenu(TapDownDetails details) {
    final position = RelativeRect.fromLTRB
      (
        details.globalPosition.dx,
        details.globalPosition.dy,
        0,
        0);

    showMenu(
      position: position,
        context: context,
        items: [
          PopupMenuItem(
            enabled: false,
              child: StatefulBuilder(
                  builder: (context, setStateInside) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _selectedOptions.entries.map((entry) {
                        return CheckboxListTile(
                          title: Text(
                              entry.key,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                          value: entry.value,
                          onChanged: (bool? value) {
                            setStateInside(() {
                              _selectedOptions[entry.key] = value!;
                            });
                          },
                        );
                      }).toList(),
                    );
                  }
              )
          )
        ]
    );

  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {

    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(seconds: 1), () async {
      String currentText = _controller.text.trim();

      if (currentText != _searchText) {
        setState(() {
          _searchText = currentText;
        });
      }

      if (currentText.isNotEmpty) {
        print(currentText);
        _page = 1;
        _repositories.clear();
        SearchReposResponse? response = await Methods.searchRepositories(Global.token, currentText, page: _page);
        setState(() {
          _repositories.addAll(response?.repositories ?? []);
        });
        // 搜索
      }

    });

  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.removeListener(_onSearchTextChanged);
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: '搜索',
            // border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _controller.clear();
              },
            ),
          ),
          controller: _controller,
        ),
        actions: [
          PopupMenuButton(

            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                  child: CheckboxListTile(
                    title: Text('提交'),
                      value: _selectedOptions['commits'],
                      onChanged: (v) {
                        setState(() {
                          _selectedOptions['commits'] = !_selectedOptions['commits']!;
                        });
                      }

                  )
              ),

            ],
            // icon: Icon(Icons.more_vert),
            child: GestureDetector(
              onTapDown: _showCustomMenu,
              child: Icon(Icons.filter_alt),
            ),
          ),
        ],
      ),
      body: _repositories.isEmpty
      ? SizedBox()
          : ListView.builder(
        itemCount: _repositories.length,
          itemBuilder: (context, index) {

          return KeepAliveWrapper(child: RepositoryEventTile(repoName: _repositories[index].fullName));
          }
      ),
    );
  }
}
