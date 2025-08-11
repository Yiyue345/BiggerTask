import 'package:biggertask/l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            onTap: () {
              Get.toNamed('language');
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text(AppLocalizations.of(context)!.theme),
            onTap: () {
              Get.toNamed('theme');
            },
          ),
        ],
      ),
    );
  }
}

