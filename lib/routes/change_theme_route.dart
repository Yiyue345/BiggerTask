import 'package:biggertask/l10n/app_localizations.dart';
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
  bool _isEdited = false;

  Map<int, int> _indexToDbId = {};

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
          themeController.colorSchemes.clear();
          _indexToDbId.clear();

          for (int i = 0; i < themes.length; i++) {
            final theme = themes[i];
            _indexToDbId[i] = theme['id'];

            final colorScheme = ColorScheme(
              brightness: Brightness.light,
              primary: Color(int.parse(theme['primaryColor'])),
              onPrimary: Color(int.parse(theme['onPrimaryColor'])),
              secondary: Color(int.parse(theme['secondaryColor'])),
              onSecondary: Color(int.parse(theme['onSecondaryColor'])),
              error: Color(int.parse(theme['errorColor'])),
              onError: Color(int.parse(theme['onErrorColor'])),
              surface: Color(int.parse(theme['surfaceColor'])),
              onSurface: Color(int.parse(theme['onSurfaceColor'])),
            );

            themeController.colorSchemes.add(colorScheme);
          }

          _colorSchemes = List.from(themeController.colorSchemes);
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
      _colorSchemes = List.from(themeController.colorSchemes);
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

      child: PopScope(
        canPop: !_isEdited,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {

            }
            else{
              bool shouldPop = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.unSavedThemeChangesTitle),
                    content: Text(AppLocalizations.of(context)!.unSavedThemeChangesMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back<bool>(result: true);
                        },
                        child: Text(AppLocalizations.of(context)!.confirm),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back<bool>(result: false);
                        },
                        child: Text(AppLocalizations.of(context)!.cancel),
                      )
                    ],
                  )
              );

              if (shouldPop) {
                Get.back();
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.theme),
              actions: [
                IconButton(
                  onLongPress: () async {
                    // final List<Map<String, dynamic>> themes = await themeDatabase.query('theme');
                    // for (int i = 0; i < themes.length; i++) {
                    //   final theme = themes[i];
                    //   _indexToDbId[i] = theme['id'];
                    // }
                    setState(() {
                      if (_colorSchemes.length <= 1) {
                        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.cannotDeleteLastTheme);
                        return;
                      }
                      if (themeController.selectedThemeIndex.value == _colorSchemes.length - 1) {
                        themeController.selectedThemeIndex.value = _colorSchemes.length - 2;
                        _colorSchemes.removeAt(themeController.selectedThemeIndex.value + 1);
                      }
                      else {
                        _colorSchemes.removeAt(themeController.selectedThemeIndex.value);
                      }
                      primary = _colorSchemes[themeController.selectedThemeIndex.value].primary;
                      onPrimary = _colorSchemes[themeController.selectedThemeIndex.value].onPrimary;
                      secondary = _colorSchemes[themeController.selectedThemeIndex.value].secondary;
                      onSecondary = _colorSchemes[themeController.selectedThemeIndex.value].onSecondary;
                      surface = _colorSchemes[themeController.selectedThemeIndex.value].surface;
                      onSurface = _colorSchemes[themeController.selectedThemeIndex.value].onSurface;
                      error = _colorSchemes[themeController.selectedThemeIndex.value].error;
                      onError = _colorSchemes[themeController.selectedThemeIndex.value].onError;
                    });
                    _isEdited = true;
                  },
                    onPressed: () async {
                      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.longPressToDeleteTheme);
                    },
                    icon: Icon(Icons.delete)
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.enableDarkMode),
                      trailing: Switch(
                          value: false,
                          onChanged: (v) {

                          }
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: _colorSchemes.isEmpty ? null :
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _colorSchemes.length + 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return SizedBox(width: 8,);
                            }
                            if (index == _colorSchemes.length + 1) {
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
                                      setState(() {
                                        _colorSchemes.add(ColorScheme.fromSeed(seedColor: Colors.blue));
                                        _isEdited = true;
                                      });
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
                              primaryColor: _colorSchemes[actualIndex].primary,
                              onPrimaryColor: _colorSchemes[actualIndex].onPrimary,
                              selected: themeController.selectedThemeIndex.value == actualIndex,
                              onTap: () {
                                setState(() {
                                  themeController.selectedThemeIndex.value = actualIndex;
                                  themeController.selectedTheme.value = _colorSchemes[actualIndex];
                                  primary = _colorSchemes[actualIndex].primary;
                                  onPrimary = _colorSchemes[actualIndex].onPrimary;
                                  secondary = _colorSchemes[actualIndex].secondary;
                                  onSecondary = _colorSchemes[actualIndex].onSecondary;
                                  surface = _colorSchemes[actualIndex].surface;
                                  onSurface = _colorSchemes[actualIndex].onSurface;
                                  error = _colorSchemes[actualIndex].error;
                                  onError = _colorSchemes[actualIndex].onError;
                                  print('selected $actualIndex');
                                  _isEdited = true;
                                });
                              },
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 4,),
                    ListTile(
                      leading: Icon(Icons.save),
                      title: Text(AppLocalizations.of(context)!.saveChangesOfTheme),
                      onTap: () async {
                        await _saveChanges();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_suggest),
                      title: Text(AppLocalizations.of(context)!.advancedThemeSettings),
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
                            title: Text(AppLocalizations.of(context)!.autoSelectOtherColors),
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
                            title: Text(AppLocalizations.of(context)!.autoSelectTextColors),
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
                                if (!themeController.autoSelectColor.value)
                                  ThemeColorsContainer(
                                    primaryColor: primary,
                                    secondaryColor: secondary,
                                    surfaceColor: surface,
                                    errorColor: error,
                                    primaryColorTitle: AppLocalizations.of(context)!.choosePrimaryColor,
                                    secondaryColorTitle: AppLocalizations.of(context)!.chooseSecondaryColor,
                                    surfaceColorTitle: AppLocalizations.of(context)!.chooseSurfaceColor,
                                    errorColorTitle: AppLocalizations.of(context)!.chooseErrorColor,
                                    onPrimaryColorChanged: (color) {
                                      setState(() {

                                        primary = color;
                                        if (themeController.autoSelectTextColor.value) {
                                          onPrimary = primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                        }
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, primary: color, onPrimary: onPrimary);
                                        _isEdited = true;
                                      });
                                    },
                                    onSecondaryColorChanged: (color) {
                                      setState(() {
                                        secondary = color;
                                        if (themeController.autoSelectTextColor.value) {
                                          onSecondary = secondary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                        }
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, secondary: color, onSecondary: onSecondary);
                                        _isEdited = true;
                                      });
                                    },
                                    onSurfaceColorChanged: (color) {
                                      setState(() {
                                        surface = color;
                                        if (themeController.autoSelectTextColor.value) {
                                          onSurface = surface.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                                        }
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, surface: color, onSurface: onSurface);
                                        _isEdited = true;
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
                                      _isEdited = true;

                                    },
                                  ),

                                // 选择 onPrimary, onSecondary, onSurface 和 onError 的颜色
                                if (!themeController.autoSelectTextColor.value)
                                  ThemeColorsContainer(
                                    primaryColor: onPrimary,
                                    secondaryColor: onSecondary,
                                    errorColor: onError,
                                    surfaceColor: onSurface,

                                    primaryColorTitle: AppLocalizations.of(context)!.chooseOnPrimaryColor,
                                    secondaryColorTitle: AppLocalizations.of(context)!.chooseOnSecondaryColor,
                                    surfaceColorTitle: AppLocalizations.of(context)!.chooseOnSurfaceColor,
                                    errorColorTitle: AppLocalizations.of(context)!.chooseOnErrorColor,

                                    onPrimaryColorChanged: (color) {
                                      setState(() {
                                        onPrimary = color;
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, onPrimary: color);
                                        _isEdited = true;
                                      });
                                    },
                                    onSecondaryColorChanged: (color) {
                                      setState(() {
                                        onSecondary = color;
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, onSecondary: color);
                                        _isEdited = true;
                                      });
                                    },
                                    onSurfaceColorChanged: (color) {
                                      setState(() {
                                        onSurface = color;
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, onSurface: color);
                                        _isEdited = true;
                                      });
                                    },
                                    onErrorColorChanged: (color) {
                                      setState(() {
                                        onError = color;
                                        _syncThemeList(index: themeController.selectedThemeIndex.value, onError: color);
                                        _isEdited = true;
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
                          subheading: Text(AppLocalizations.of(context)!.opacity),
                          showColorName: true,
                          showColorCode: true,
                          colorCodeHasColor: true,
                          pickersEnabled: {
                            ColorPickerType.primary: true,
                            ColorPickerType.accent: false,
                            ColorPickerType.wheel: true
                          },
                          pickerTypeLabels: {
                            ColorPickerType.primary: AppLocalizations.of(context)!.primaryColorLabel,
                            ColorPickerType.accent: AppLocalizations.of(context)!.accentColorLabel,
                            ColorPickerType.both: AppLocalizations.of(context)!.bothColorLabel,
                            ColorPickerType.custom: AppLocalizations.of(context)!.customColorLabel,
                            ColorPickerType.wheel : AppLocalizations.of(context)!.wheelColorLabel
                          },

                          onColorChanged: (color) {
                            setState(() {
                              _colorSchemes[themeController.selectedThemeIndex.value] =
                                  ColorScheme.fromSeed(seedColor: color);
                              primary = _colorSchemes[themeController.selectedThemeIndex.value].primary;
                              onPrimary = _colorSchemes[themeController.selectedThemeIndex.value].onPrimary;
                              secondary = _colorSchemes[themeController.selectedThemeIndex.value].secondary;
                              onSecondary = _colorSchemes[themeController.selectedThemeIndex.value].onSecondary;
                              surface = _colorSchemes[themeController.selectedThemeIndex.value].surface;
                              onSurface = _colorSchemes[themeController.selectedThemeIndex.value].onSurface;
                              error = _colorSchemes[themeController.selectedThemeIndex.value].error;
                              onError = _colorSchemes[themeController.selectedThemeIndex.value].onError;
                            });
                            _isEdited = true;
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
          )
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

    await themeDatabase.delete('theme');

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

    themeController.colorSchemes = List.from(_colorSchemes);

    for (int i = 0; i < _colorSchemes.length; i++) {
      await themeDatabase.insert('theme', {
        'primaryColor': '${_colorSchemes[i].primary.toARGB32()}',
        'onPrimaryColor': '${_colorSchemes[i].onPrimary.toARGB32()}',
        'secondaryColor': '${_colorSchemes[i].secondary.toARGB32()}',
        'onSecondaryColor': '${_colorSchemes[i].onSecondary.toARGB32()}',
        'errorColor': '${_colorSchemes[i].error.toARGB32()}',
        'onErrorColor': '${_colorSchemes[i].onError.toARGB32()}',
        'surfaceColor': '${_colorSchemes[i].surface.toARGB32()}',
        'onSurfaceColor': '${_colorSchemes[i].onSurface.toARGB32()}',
      });
    }

    final themes = await themeDatabase.query('theme', orderBy: 'id');
    _indexToDbId.clear();
    for (int i = 0; i < themes.length; i++) {
      _indexToDbId[i] = themes[i]['id'] as int;
    }

    await prefs.setInt('primary', primary.toARGB32());
    await prefs.setInt('onPrimary', onPrimary.toARGB32());
    await prefs.setInt('secondary', secondary.toARGB32());
    await prefs.setInt('onSecondary', onSecondary.toARGB32());
    await prefs.setInt('surface', surface.toARGB32());
    await prefs.setInt('onSurface', onSurface.toARGB32());
    await prefs.setInt('error', error.toARGB32());
    await prefs.setInt('onError', onError.toARGB32());

    Fluttertoast.showToast(msg: AppLocalizations.of(context)!.savedSuccessfully);

    _isEdited = false;
  }


  // 更新主题中的某个颜色
  void _syncThemeList(
      {required int index, Brightness? brightness, Color? primary, Color? onPrimary, Color? secondary, Color? onSecondary, Color? surface, Color? onSurface, Color? error, Color? onError}) {
    _colorSchemes[index] = ColorScheme(
      brightness: brightness ?? _colorSchemes[index].brightness,
      primary: primary ?? _colorSchemes[index].primary,
      onPrimary: onPrimary ?? _colorSchemes[index].onPrimary,
      secondary: secondary ?? _colorSchemes[index].secondary,
      onSecondary: onSecondary ?? _colorSchemes[index].onSecondary,
      surface: surface ?? _colorSchemes[index].surface,
      onSurface: onSurface ?? _colorSchemes[index].onSurface,
      error: error ?? _colorSchemes[index].error,
      onError: onError ?? _colorSchemes[index].onError
    );
  }

  List<ColorScheme> _colorSchemes = [];

}
