import 'package:biggertask/routes/change_theme_route.dart';
import 'package:biggertask/routes/homepage_base_route.dart';
import 'package:biggertask/routes/language_route.dart';
import 'package:biggertask/routes/settings_route.dart';
import 'package:biggertask/states/theme_controller.dart';
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
    final ThemeController c = Get.put(ThemeController());
    
    return Obx(() => GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: c.colorScheme,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: c.colorScheme.secondary,
          )
        ),
        iconTheme: IconThemeData(
          color: c.colorScheme.secondary
        ),
        listTileTheme: ListTileThemeData( // 副驾驶你坑的我好惨啊
          iconColor: c.colorScheme.secondary,
          textColor: c.colorScheme.onSurface,
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: c.colorScheme.onSurface
        )
      ),
      home: HomepageBaseRoute(),
      routes: {
        'homepage': (context) => HomepageBaseRoute(),
        'settings': (context) => SettingsRoute(),
        'language': (context) => LanguageRoute(),
        'theme': (context) => ThemeRoute(),
      },
    ));
  }
}


