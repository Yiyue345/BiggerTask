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
  String rawJson = '';

  Future<void> _fetchData() async {
    response = await Methods.getMyEvents(Global.token, page: 2, perPage: 30);
    rawJson = jsonEncode(response.map((e) => e.toJson()).toList());
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(onRefresh: _fetchData,
        child: response.isEmpty
        ? Center(
          child: ElevatedButton(
              onPressed: () async {
                await _fetchData();
              },
              child: Text('点我')
          ),
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

    //     SingleChildScrollView(
    //   padding: EdgeInsets.all(16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         '解析后的数据:',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(height: 8),
    //       Text(
    //         response.map((e) => '${e.actor.login ?? 'Unknown'} - ${e.type ?? 'Unknown'}').join('\n'),
    //         style: TextStyle(fontSize: 14),
    //       ),
    //       SizedBox(height: 24),
    //       Text(
    //         '原始JSON数据:',
    //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //       SizedBox(height: 8),
    //       Container(
    //         padding: EdgeInsets.all(12),
    //         decoration: BoxDecoration(
    //           color: Colors.grey[100],
    //           borderRadius: BorderRadius.circular(8),
    //           border: Border.all(color: Colors.grey[300]!),
    //         ),
    //         child: SelectableText(
    //           _formatJson(rawJson),
    //           style: TextStyle(
    //             fontFamily: 'monospace',
    //             fontSize: 12,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
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
