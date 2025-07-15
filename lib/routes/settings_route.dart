import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({super.key});

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text('语言'),
            onTap: () {
              Get.toNamed('language');
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('主题'),
            onTap: () {
              Get.toNamed('theme');
            },
          ),
        ],
      ),
    );
  }
}

