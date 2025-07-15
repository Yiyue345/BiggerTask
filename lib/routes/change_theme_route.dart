import 'package:biggertask/common/static.dart';
import 'package:biggertask/main.dart';
import 'package:biggertask/states/theme_controller.dart';
import 'package:biggertask/widgets/theme_colors_container.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void initState() {
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Theme(
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
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('主题'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ThemeColorsContainer(
                  primaryColor: primary,
                  secondaryColor: secondary,
                  surfaceColor: surface,
                  errorColor: error,
                  onPrimaryColorChanged: (color) {
                    setState(() {


                      primary = color;
                      onPrimary = primary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                      // 临时测试
                      Global.primaryColor = primary;
                      themeController.updateTheme(primary: primary, onPrimary: onPrimary);
                      print(color.toARGB32());
                    });
                  },
                  onSecondaryColorChanged: (color) {
                    setState(() {
                      secondary = color;
                      onSecondary = secondary.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                      // 临时测试
                      Global.secondaryColor = secondary;
                      themeController.updateTheme(secondary: secondary, onSecondary: onSecondary);
                    });
                  },
                  onSurfaceColorChanged: (color) {
                    setState(() {
                      surface = color;
                      onSurface = surface.computeLuminance() > 0.5 ? Colors.black : Colors.white;
                      // 临时测试
                      Global.surfaceColor = surface;
                      themeController.updateTheme(surface: surface, onSurface: onSurface);
                    });
                  },
                ),
                ListTile(
                  title: Text('高级主题设置'),
                  trailing: Switch(
                      value: themeController.advancedTheme.value,
                      onChanged: (v) {
                        setState(() {
                          themeController.advancedTheme.value = v;
                        });
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
                        title: Text('自动选择文字颜色'),
                        trailing: Switch(
                            value: themeController.autoSelectTextColor.value,
                            onChanged: (v) {
                              setState(() {
                                themeController.autoSelectTextColor.value = v;
                              });
                            }
                        ),
                      ),

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
                        ),
                    ],
                  )
                  : SizedBox.shrink(),
                ),
                // if (themeController.advancedTheme.value)...[
                //
                // ],


                ColorPicker(
                  onColorChanged: (color) {

                  },
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: true,
                    ColorPickerType.both: false,
                    ColorPickerType.custom: true,
                    ColorPickerType.wheel : true
                  },
                )
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
    );
  }
}
