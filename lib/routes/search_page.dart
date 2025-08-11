import 'dart:async';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/models/search.dart';
import 'package:biggertask/widgets/event_tile.dart';
import 'package:biggertask/widgets/github_namecard.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final Map<String, List> _items = {
    'repositories': <Repository>[],
    'users': <SimpleGitHubUser>[],
    'commits': [],
    'issues': [],
    'pull requests': [],
    'code': [],
    'topics': [],
  };
  String _selectedType = 'repositories';
  bool _isLoading = false; bool _hasMore = true;


  final Map<String, bool> _selectedOptions = {
    'commits': false,
    'issues': false,
    'pull requests': false,
    'repositories': true,
    'code': false,
    'topics': false,
    'users': false,
  };

  late Map<String, String> _typeLabels;

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
                              _typeLabels[entry.key]!,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                          value: entry.value,
                          onChanged: (bool? value) {
                            setStateInside(() {
                              _selectedType = entry.key;
                              print(_selectedType);
                              _selectedOptions.updateAll((key, value) => false);
                              _selectedOptions[entry.key] = true;
                              _items.map((key, value) => MapEntry(key, []));
                              _page = 1;
                              _hasMore = true;
                              _onSearchTextChanged();
                            });
                            setState(() {

                            });
                            Future.delayed(Duration(milliseconds: 200), () {
                              Get.back();
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
      _isLoading = true;
      if (currentText != _searchText) {
        setState(() {
          _searchText = currentText;
        });
      }

      if (currentText.isNotEmpty) {
        print(currentText);
        _page = 1;
        _items[_selectedType]!.clear();
        switch (_selectedType) {
          case 'repositories':
            Methods.searchRepositories(token: Global.token, query: currentText, page: _page).then((response) {
              setState(() {
                _items['repositories']!.addAll(response?.repositories ?? []);
                _isLoading = false;
                _hasMore = response?.repositories.length == 30; // 假设每页最多30个仓库
              });

            });
            break;
          case 'users':
            Methods.searchUsers(token: Global.token, query: currentText, page: _page).then((response) {
              setState(() {
                final users = response?.users ?? <SimpleGitHubUser>[];
                _items['users']!.addAll(users);
                _isLoading = false;
                _hasMore = response?.users.length == 30; // 假设每页最多30个用户
              });
            });
            break;
        }


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

    _typeLabels = {
      'commits': AppLocalizations.of(context)!.commits,
      'issues': AppLocalizations.of(context)!.issues,
      'pull requests': AppLocalizations.of(context)!.pullRequests,
      'repositories': AppLocalizations.of(context)!.repositories,
      'code': AppLocalizations.of(context)!.code,
      'topics': AppLocalizations.of(context)!.topics,
      'users': AppLocalizations.of(context)!.users,
    };

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchForSomething(_typeLabels[_selectedType]!),
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
          Padding(
              padding: EdgeInsets.only(right: 16),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    enabled: false,
                    child: CheckboxListTile(
                        title: Text(AppLocalizations.of(context)!.commits),
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
                child: Icon(
                    Icons.filter_alt,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _items[_selectedType]!.isEmpty
      ? SizedBox()
          : ListView.builder(
        itemCount: _items[_selectedType]!.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
          if (index == _items[_selectedType]!.length) {
            if (_isLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                child: CircularProgressIndicator(),
              ),
              );
            }
            else {
              // 加载更多
              _page++;
              _isLoading = true;
              switch (_selectedType) {
                case 'repositories':
                  Methods.searchRepositories(token: Global.token, query: _searchText, page: _page).then((response) {
                    setState(() {
                      _items[_selectedType]!.addAll(response?.repositories ?? []);
                      _hasMore = response?.repositories.length == 30; // 假设每页最多30个仓库
                      _isLoading = false;
                    });
                  }).catchError((e) {
                    setState(() {
                      _isLoading = false;
                    });
                    print('Error loading more repositories: $e');
                  });
                case 'users':
                  Methods.searchUsers(token: Global.token, query: _searchText, page: _page).then((response) {
                    setState(() {
                      final users = response?.users ?? <SimpleGitHubUser>[];
                      _items[_selectedType]!.addAll(users);
                      _hasMore = response?.users.length == 30; // 假设每页最多30个用户
                      _isLoading = false;
                    });
                  }).catchError((e) {
                    setState(() {
                      _isLoading = false;
                    });
                    print('Error loading more users: $e');
                  });
                  break;
                default:
                  return SizedBox();
              }

              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          switch (_selectedType) {
            case 'repositories':
              return KeepAliveWrapper(child: RepositoryEventTile(repoName: _items['repositories']![index].fullName));
            case 'users':
              return KeepAliveWrapper(child: GitHubUserTile(user: _items['users']![index]));
            default:
              return SizedBox(); // 其他类型暂不处理
          }
          }
      ),
    );
  }
}
