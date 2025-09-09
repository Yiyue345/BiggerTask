import 'dart:convert';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/widgets/event_tile.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';

class MyEventsRoute extends StatefulWidget {
  @override
  _MyEventsRouteState createState() => _MyEventsRouteState();
}

class _MyEventsRouteState extends State<MyEventsRoute> with AutomaticKeepAliveClientMixin {
  final List<Event> _events = [];
  bool isLoaded = false;
  String rawJson = '';
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;

  Future<void> _fetchData() async {
    _isLoading = true;
    print('Fetching data from page $_page...');
    Methods.getMyEvents(token: Global.token, page: _page, perPage: 30).then((response) {
      _events.addAll(response);
      print('Data fetched: ${response.length} events');
      if (response.length < 30) {
        _hasMore = false; // 如果返回的数据少于每页数量，说明没有更多数据了
      }
      else {
        _page++;
      }
      setState(() {
        isLoaded = true;
        rawJson = jsonEncode(_events.map((e) => e.toJson()).toList());
        _isLoading = false;
      });
    });


  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 在页面加载后立即获取数据
      _fetchData();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    super.build(context);
    return RefreshIndicator(
        onRefresh: () async {
          _page = 1; // 重置页码
          _hasMore = true; // 重置是否有更多数据
          _events.clear(); // 清空当前数据
          await _fetchData(); // 重新获取数据
        },
        child: !Global.isLogin
            ? Center(
            child: Text(AppLocalizations.of(context)!.notLoginEventText),
        )
            :!isLoaded
            ? Center(
            child: CircularProgressIndicator()
        )
            : _events.isEmpty
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () async {
                      await _fetchData();
                    },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      minimumSize: WidgetStatePropertyAll(Size.zero), // 移除最小尺寸
                      overlayColor: WidgetStatePropertyAll(Colors.transparent)
                    ),
                    child: Text(l10n.noEventText)
                )
              ],
            )
        )
            :
        ListView.builder(
          shrinkWrap: true,
          itemCount: _events.length + (_hasMore ? 1 : 0), // 如果有更多数据，增加一个加载更多的占位
            itemBuilder: (context, index) {
            if (index == _events.length && _hasMore) {
              // 如果是最后一个，并且有更多数据，显示加载更多的指示器
              if (_isLoading) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                // 触发加载更多数据
                _fetchData();
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
              final event = _events[index];
              return KeepAliveWrapper(
                  child: EventTile(event: event)
              );
            }
        )

        // Scrollbar(
        //     child: SingleChildScrollView(
        //       padding: EdgeInsets.all(16.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             '解析后的数据:',
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(height: 8),
        //           Text(
        //             response.map((e) => '${e.actor.login ?? 'Unknown'} - ${e.type ?? 'Unknown'}').join('\n'),
        //             style: TextStyle(fontSize: 14),
        //           ),
        //           SizedBox(height: 24),
        //           Text(
        //             '原始JSON数据:',
        //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(height: 8),
        //           Container(
        //             padding: EdgeInsets.all(12),
        //             decoration: BoxDecoration(
        //               color: Colors.grey[100],
        //               borderRadius: BorderRadius.circular(8),
        //               border: Border.all(color: Colors.grey[300]!),
        //             ),
        //             child: SelectableText(
        //               _formatJson(rawJson),
        //               style: TextStyle(
        //                 fontFamily: 'monospace',
        //                 fontSize: 12,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        // )


    );
  }

  // String _formatJson(String json) {
  //   try {
  //     final jsonObject = jsonDecode(json);
  //     const encoder = JsonEncoder.withIndent('  ');
  //     return encoder.convert(jsonObject);
  //   } catch (e) {
  //     return json;
  //   }
  // }
}
