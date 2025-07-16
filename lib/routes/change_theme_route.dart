import 'package:biggertask/common/static.dart';
import 'package:biggertask/main.dart';
import 'package:biggertask/states/theme_controller.dart';
import 'package:biggertask/widgets/theme_colors_container.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ThemeRoute extends StatefulWidget {
  const ThemeRoute({super.key});

  @override
  State<ThemeRoute> createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {

  Brightness brightness = Brightness.light;
  Color primary = Colors.blue;
  Color onPrimary = Colors.white;
  Color secondary = Colors.green;
  Color onSecondary = Colors.white;
  Color error = Colors.red;
  Color onError = Colors.white;
  Color surface = Colors.white;
  Color onSurface = Colors.black;
  Color background = Colors.white;

  late final ThemeController themeController;

  late Database themeDatabase;
  late final SharedPreferences prefs;

  Future<void> _initThemeDatabase() async {
    var databasesPath = await getDatabasesPath();
    prefs = await SharedPreferences.getInstance();
    String path = '$databasesPath/theme.db';


    themeDatabase = await openDatabase(
        path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE theme (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            primaryColor TEXT,
            onPrimaryColor TEXT,
            secondaryColor TEXT,
            onSecondaryColor TEXT,
            errorColor TEXT,
            onErrorColor TEXT,
            surfaceColor TEXT,
            onSurfaceColor TEXT
          );
        ''');


        for (ColorScheme colorScheme in _defaultColorSchemes) {
          db.execute('''
            INSERT INTO theme (
            primaryColor, 
            onPrimaryColor, 
            secondaryColor, 
            onSecondaryColor, 
            errorColor, 
            onErrorColor, 
            surfaceColor, 
            onSurfaceColor
            ) VALUES (
              '${colorScheme.primary.toARGB32()}',
              '${colorScheme.onPrimary.toARGB32()}',
              '${colorScheme.secondary.toARGB32()}',
              '${colorScheme.onSecondary.toARGB32()}',
              '${colorScheme.error.toARGB32()}',
              '${colorScheme.onError.toARGB32()}',
              '${colorScheme.surface.toARGB32()}',
              '${colorScheme.onSurface.toARGB32()}'
              );
            ''');
        }
      },
      onOpen: (Database db) async {
        // 读取已有的主题数据
        final List<Map<String, dynamic>> themes = await db.query('theme');
        if (themes.isNotEmpty) {
          themeController.colorSchemes = themes.map((theme) {
            return ColorScheme(
              brightness: Brightness.light,
              primary: Color(int.parse(theme['primaryColor'])),
              onPrimary: Color(int.parse(theme['onPrimaryColor'])),
              secondary: Color(int.parse(theme['secondaryColor'])),
              onSecondary: Color(int.parse(theme['onSecondaryColor'])),
              error: Color(int.parse(theme['errorColor'])),
              onError: Color(int.parse(theme['onErrorColor'])),
              surface: Color(int.parse(theme['surfaceColor'])),
              onSurface: Color(int.parse(theme['onSurfaceColor']))
            );
          }).toList();
        }

        setState(() {

        });
      }
    );

    themeController.selectedThemeIndex.value = themeController.colorSchemes.indexWhere((colorScheme) =>
        colorScheme.primary == themeController.primary.value &&
        colorScheme.onPrimary == themeController.onPrimary.value &&
        colorScheme.secondary == themeController.secondary.value &&
        colorScheme.onSecondary == themeController.onSecondary.value &&
        colorScheme.surface == themeController.surface.value &&
        colorScheme.onSurface == themeController.onSurface.value &&
        colorScheme.error == themeController.error.value &&
        colorScheme.onError == themeController.onError.value
    );
  }

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    _initThemeDatabase();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    brightness = Theme.of(context).brightness;
    primary = Theme.of(context).colorScheme.primary;
    onPrimary = Theme.of(context).colorScheme.onPrimary;
    secondary = Theme.of(context).colorScheme.secondary;
    onSecondary = Theme.of(context).colorScheme.onSecondary;
    error = Theme.of(context).colorScheme.error;
    onError = Theme.of(context).colorScheme.onError;
    surface = Theme.of(context).colorScheme.surface;
    onSurface = Theme.of(context).colorScheme.onSurface;

    // todo 写个临时列表来避免索引为 -1 的情况
    if (themeController.colorSchemes.isNotEmpty) {
      themeController.selectedThemeIndex.value = themeController.colorSchemes.indexWhere((colorScheme) =>
      colorScheme.primary == themeController.primary.value &&
          colorScheme.onPrimary == themeController.onPrimary.value &&
          colorScheme.secondary == themeController.secondary.value &&
          colorScheme.onSecondary == themeController.onSecondary.value &&
          colorScheme.surface == themeController.surface.value &&
          colorScheme.onSurface == themeController.onSurface.value &&
          colorScheme.error == themeController.error.value &&
          colorScheme.onError == themeController.onError.value
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Obx(() => Theme(
      // 用于预览
      data: ThemeData(
          colorScheme: ColorScheme(
              brightness: brightness,
              primary: primary,
              onPrimary: onPrimary,
              secondary: secondary,
              onSecondary: onSecondary,
              error: error,
              onError: onError,
              surface: surface,
              onSurface: onSurface
          ),
          iconTheme: IconThemeData(
              color: secondary
          ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: secondary
          )
        ),
        listTileTheme: ListTileThemeData(
          iconColor: secondary,
          textColor: onSurface,
        ),
      ),

      child: Scaffold(
        appBar: AppBar(
          title: Text('主题'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                  child: themeController.colorSchemes.isEmpty ? null :
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: themeController.colorSchemes.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return SizedBox(width: 8,);
                        }
                        if (index == themeController.colorSchemes.length + 1) {
                          return Padding(
                              padding: EdgeInsets.only(left: 4),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                    width: 1.6
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(8))
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print('ciallo~');
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ),
                          );
                        }
                        int actualIndex = index - 1;
                        return SmallThemeColorsContainer(
                          primaryColor: themeController.colorSchemes[actualIndex].primary,
                          onPrimaryColor: themeController.colorSchemes[actualIndex].onPrimary,
                          selected: themeController.selectedThemeIndex.value == actualIndex,
                          onTap: () {
                            setState(() {
                              themeController.selectedThemeIndex.value = actualIndex;
                              themeController.selectedTheme.value = themeController.colorSchemes[actualIndex];
                              primary = themeController.colorSchemes[actualIndex].primary;
                              onPrimary = themeController.colorSchemes[actualIndex].onPrimary;
                              secondary = themeController.colorSchemes[actualIndex].secondary;
                              onSecondary = themeController.colorSchemes[actualIndex].onSecondary;
                              surface = themeController.colorSchemes[actualIndex].surface;
                              onSurface = themeController.colorSchemes[actualIndex].onSurface;
                              error = themeController.colorSchemes[actualIndex].error;
                              onError = themeController.colorSchemes[actualIndex].onError;
                              print('selected $actualIndex');
                            });
                          },
                        );
                      }
                  ),
                ),
                SizedBox(height: 4,),
                ListTile(
                  leading: Icon(Icons.save),
                  title: Text('保存对当前主题的修改'),
                  onTap: () async {
                    await _saveChanges();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings_suggest),
                  title: Text('高级主题设置'),
                  trailing: Switch(
                      value: themeController.advancedTheme.value,
                      onChanged: (v) async {
                        setState(() {
                          themeController.advancedTheme.value = v;
                        });
                        await prefs.setBool('advancedTheme', v);
                      }
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutQuart,
                  child: themeController.advancedTheme.value
                      ? Column(
                    children: [
                      ListTile(
                        title: Text('自动设置次要颜色'),
                        trailing: Switch(
                            value: themeController.autoSelectColor.value,
                            onChanged: (v) async {
                              setState(() {
                                themeController.autoSelectColor.value = v;
                              });
                              await prefs.setBool('autoSelectColor', v);
                            }
                        ),
                      ),

                      ListTile(
                        title: Text('自动设置文字颜色'),
                        trailing: Switch(
                            value: themeController.autoSelectTextColor.value,
                            onChanged: (v) async {
                              setState(() {
                                themeController.autoSelectTextColor.value = v;
                              });
                              await prefs.setBool('autoSelectTextColor', v);
                            }
                        ),
                      ),
                      AnimatedSize(
                          duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutQuart,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // todo 还没做
                            // 选择 secondary, surface 和 error 的颜色
                            if (!themeController.autoSelectColor.value)
                              ThemeColorsContainer(
                                primaryColor: primary,
                                secondaryColor: secondary,
                                surfaceColor: surface,
                                errorColor: error,
                                onPrimaryColorChanged: (color) {
                                  setState(() {

                                    primary = color;
                                    if (themeController.autoSelectTextColor.value) {
                                      onPrimary = primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                    }
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, primary: color, onPrimary: onPrimary);

                                  });
                                },
                                onSecondaryColorChanged: (color) {
                                  setState(() {
                                    secondary = color;
                                    if (themeController.autoSelectTextColor.value) {
                                      onSecondary = secondary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                    }
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, secondary: color, onSecondary: onSecondary);

                                  });
                                },
                                onSurfaceColorChanged: (color) {
                                  setState(() {
                                    surface = color;
                                    if (themeController.autoSelectTextColor.value) {
                                      onSurface = surface.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                    }
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, surface: color, onSurface: onSurface);

                                  });
                                },
                                onErrorColorChanged: (color) {
                                  setState(() {
                                    error = color;
                                    if (themeController.autoSelectTextColor.value) {
                                      onError = error.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                    }
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, error: color, onError: onError);
                                  });


                                },
                              ),

                            // 选择 onPrimary, onSecondary, onSurface 和 onError 的颜色
                            if (!themeController.autoSelectTextColor.value)
                              ThemeColorsContainer(
                                primaryColor: onPrimary,
                                secondaryColor: onSecondary,
                                errorColor: onError,
                                surfaceColor: onSurface,

                                primaryColorTitle: '主色之上的文字颜色',
                                secondaryColorTitle: '强调色之上的文字颜色',
                                surfaceColorTitle: '背景之上的文字颜色',
                                errorColorTitle: '错误色之上的文字颜色',

                                onPrimaryColorChanged: (color) {
                                  setState(() {
                                    onPrimary = color;
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, onPrimary: color);

                                  });
                                },
                                onSecondaryColorChanged: (color) {
                                  setState(() {
                                    onSecondary = color;
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, onSecondary: color);
                                  });
                                },
                                onSurfaceColorChanged: (color) {
                                  setState(() {
                                    onSurface = color;
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, onSurface: color);
                                  });
                                },
                                onErrorColorChanged: (color) {
                                  setState(() {
                                    onError = color;
                                    _syncThemeList(index: themeController.selectedThemeIndex.value, onError: color);
                                  });
                                },
                              ),
                          ],
                        ),
                      ),


                    ],
                  )
                      : ColorPicker(
                    color: primary,
                      subheading: Text('渐变色'),
                      showColorName: true,
                      showColorCode: true,
                      colorCodeHasColor: true,
                    pickersEnabled: {
                      ColorPickerType.primary: true,
                      ColorPickerType.accent: false,
                      ColorPickerType.wheel: true
                    },
                      pickerTypeLabels: {
                        ColorPickerType.primary: '主色',
                        ColorPickerType.accent: '强调色',
                        ColorPickerType.both: '主色与强调色',
                        ColorPickerType.custom: '自定义',
                        ColorPickerType.wheel : '轮盘'
                      },

                      onColorChanged: (color) {
                        setState(() {
                          themeController.colorSchemes[themeController.selectedThemeIndex.value] =
                              ColorScheme.fromSeed(seedColor: color);
                          primary = themeController.colorSchemes[themeController.selectedThemeIndex.value].primary;
                          onPrimary = themeController.colorSchemes[themeController.selectedThemeIndex.value].onPrimary;
                          secondary = themeController.colorSchemes[themeController.selectedThemeIndex.value].secondary;
                          onSecondary = themeController.colorSchemes[themeController.selectedThemeIndex.value].onSecondary;
                          surface = themeController.colorSchemes[themeController.selectedThemeIndex.value].surface;
                          onSurface = themeController.colorSchemes[themeController.selectedThemeIndex.value].onSurface;
                          error = themeController.colorSchemes[themeController.selectedThemeIndex.value].error;
                          onError = themeController.colorSchemes[themeController.selectedThemeIndex.value].onError;
                        });
                      }
                  ),
                ),


              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Primary Color: $primary');
          },
          child: Icon(Icons.cached),
        ),
      ),
    ));
  }

  final List<ColorScheme> _defaultColorSchemes = [
    ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ColorScheme.fromSeed(seedColor: Colors.blue),
    ColorScheme.fromSeed(seedColor: Colors.green),
    ColorScheme.fromSeed(seedColor: Colors.red),
    ColorScheme.fromSeed(seedColor: Colors.orange),
    ColorScheme.fromSeed(seedColor: Colors.pink),
    ColorScheme.fromSeed(seedColor: Colors.teal),
  ];

  Future<void> _saveChanges() async {
    themeController.updateTheme(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface
    );

    await themeDatabase.execute('''
                      UPDATE theme SET 
                        primaryColor = '${primary.toARGB32()}',
                        onPrimaryColor = '${onPrimary.toARGB32()}',
                        secondaryColor = '${secondary.toARGB32()}',
                        onSecondaryColor = '${onSecondary.toARGB32()}',
                        errorColor = '${error.toARGB32()}',
                        onErrorColor = '${onError.toARGB32()}',
                        surfaceColor = '${surface.toARGB32()}',
                        onSurfaceColor = '${onSurface.toARGB32()}'
                      WHERE id = ${themeController.selectedThemeIndex.value + 1}
                    ''');

    await prefs.setInt('primary', primary.toARGB32());
    await prefs.setInt('onPrimary', onPrimary.toARGB32());
    await prefs.setInt('secondary', secondary.toARGB32());
    await prefs.setInt('onSecondary', onSecondary.toARGB32());
    await prefs.setInt('surface', surface.toARGB32());
    await prefs.setInt('onSurface', onSurface.toARGB32());
    await prefs.setInt('error', error.toARGB32());
    await prefs.setInt('onError', onError.toARGB32());

    Fluttertoast.showToast(msg: '保存成功！');
  }

  void _syncThemeList(
      {required int index, Brightness? brightness, Color? primary, Color? onPrimary, Color? secondary, Color? onSecondary, Color? surface, Color? onSurface, Color? error, Color? onError}) {
    themeController.colorSchemes[index] = ColorScheme(
      brightness: brightness ?? themeController.colorSchemes[index].brightness,
      primary: primary ?? themeController.colorSchemes[index].primary,
      onPrimary: onPrimary ?? themeController.colorSchemes[index].onPrimary,
      secondary: secondary ?? themeController.colorSchemes[index].secondary,
      onSecondary: onSecondary ?? themeController.colorSchemes[index].onSecondary,
      surface: surface ?? themeController.colorSchemes[index].surface,
      onSurface: onSurface ?? themeController.colorSchemes[index].onSurface,
      error: error ?? themeController.colorSchemes[index].error,
      onError: onError ?? themeController.colorSchemes[index].onError
    );
  }

}
