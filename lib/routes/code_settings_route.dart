import 'package:flutter/material.dart';

class CodeSettingsRoute extends StatefulWidget {
  const CodeSettingsRoute({super.key});

  @override
  State<StatefulWidget> createState() => _CodeSettingsRouteState();
}

class _CodeSettingsRouteState extends State<CodeSettingsRoute> {
  bool showLineNumber = true;
  bool lineWrap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('显示行号'),
            trailing: Switch(
                value: showLineNumber,
                onChanged: (v) {
                  setState(() {
                    showLineNumber = v;
                  });
                }
            ),
          ),
          ListTile(
            title: Text('换行'),
            trailing: Switch(
                value: lineWrap,
                onChanged: (v) {
                  setState(() {
                    lineWrap = v;
                  });
                }
            ),
          )
        ],
      ),
    );
  }
}
