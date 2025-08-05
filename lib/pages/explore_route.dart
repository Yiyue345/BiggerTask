import 'dart:convert';

import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/widgets/event_tile.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';

class ExploreRoute extends StatefulWidget {
  @override
  _ExploreRouteState createState() => _ExploreRouteState();
}

class _ExploreRouteState extends State<ExploreRoute> with AutomaticKeepAliveClientMixin {
  List<Event> response = [];
  bool isLoaded = false;
  String rawJson = '';

  Future<void> _fetchData() async {
    print('Fetching data...');
    response = await Methods.getMyEvents(Global.token, page: 1, perPage: 30);

    print('Data fetched: ${response.length} events');
    setState(() {
      isLoaded = true;
      rawJson = jsonEncode(response.map((e) => e.toJson()).toList());
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
    super.build(context);
    return RefreshIndicator(onRefresh: _fetchData,
        child: !isLoaded
            ? Center(
            child: CircularProgressIndicator()
        )
            : response.isEmpty 
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
                    child: Text('暂时还没有事件哦~')
                )
              ],
            )
        )
            :
        ListView.builder(
          itemCount: response.length,
            itemBuilder: (context, index) {
              final event = response[index];
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

  String _formatJson(String json) {
    try {
      final jsonObject = jsonDecode(json);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      return json;
    }
  }
}
