import 'package:biggertask/widgets/theme_colors_container.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ThemeRoute extends StatefulWidget {
  const ThemeRoute({super.key});

  @override
  State<ThemeRoute> createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题'),
      ),
      body: Center(
        child: Column(
          children: [
            ThemeColorsContainer(
                primaryColor: Theme.of(context).colorScheme.primary,
                secondaryColor: Theme.of(context).colorScheme.secondary,
                onSurfaceColor: Theme.of(context).colorScheme.onSurface,
                surfaceColor: Theme.of(context).colorScheme.surface,
              onPrimaryColorChanged: (color) {

              },
            ),
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
    );
  }
}
