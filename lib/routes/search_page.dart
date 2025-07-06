import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _controller = TextEditingController();
  String _searchText = '';

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
  Widget build(BuildContext context) {

    _controller.addListener(() {
      _searchText = _controller.text;

    });

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
      body: Column(
        children: [

        ],
      ),
    );
  }
}
