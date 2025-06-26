import 'package:biggertask/routes/homepage_base_route.dart';
import 'package:biggertask/routes/repos_route.dart';
import 'package:biggertask/routes/settings_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env'); // 加载环境变量
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomepageBaseRoute(),
      routes: {
        'homepage': (context) => HomepageBaseRoute(),
        'settings': (context) => SettingsRoute(),
        'my_repos': (context) => RepositoriesRoute()

      },
    );
  }
}


