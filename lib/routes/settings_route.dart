import 'package:flutter/material.dart';

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
      body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text('ciallo'),
                )
              ],
            ),
          )
      ),
    );
  }
}

