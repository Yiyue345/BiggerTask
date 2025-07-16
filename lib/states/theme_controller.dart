import 'package:biggertask/common/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biggertask/common/static.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController {
  var primary = Global.colorScheme.primary.obs;
  var onPrimary = Global.colorScheme.onPrimary.obs;
  var secondary = Global.colorScheme.secondary.obs;
  var onSecondary = Global.colorScheme.onSecondary.obs;
  var error = Global.colorScheme.error.obs;
  var onError = Global.colorScheme.onError.obs;
  var surface = Global.colorScheme.surface.obs;
  var onSurface = Global.colorScheme.onSurface.obs;

  var autoSelectColor = true.obs; // 使用 fromSeed 自动生成
  var autoSelectTextColor = true.obs;
  var advancedTheme = false.obs;

  var selectedThemeIndex = 0.obs;
  var selectedTheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple).obs;

  List<ColorScheme> colorSchemes = [];

  Future<void> _initTheme() async {
    final pref = await SharedPreferences.getInstance();

    primary.value = Color(pref.getInt('primary') ?? Global.colorScheme.primary.toARGB32());
    onPrimary.value = Color(pref.getInt('onPrimary') ?? Global.colorScheme.onPrimary.toARGB32());
    secondary.value = Color(pref.getInt('secondary') ?? Global.colorScheme.secondary.toARGB32());
    onSecondary.value = Color(pref.getInt('onSecondary') ?? Global.colorScheme.onSecondary.toARGB32());
    surface.value = Color(pref.getInt('surface') ?? Global.colorScheme.surface.toARGB32());
    onSurface.value = Color(pref.getInt('onSurface') ?? Global.colorScheme.onSurface.toARGB32());
    error.value = Color(pref.getInt('error') ?? Global.colorScheme.error.toARGB32());
    onError.value = Color(pref.getInt('onError') ?? Global.colorScheme.onError.toARGB32());

    advancedTheme.value = pref.getBool('advancedTheme') ?? false;
    autoSelectColor.value = pref.getBool('autoSelectColor') ?? true;
    autoSelectTextColor.value = pref.getBool('autoSelectTextColor') ?? true;

  }

  @override
  void onInit() async {
    super.onInit();
   _initTheme();
  }

  ColorScheme get colorScheme => ColorScheme.fromSeed(
    seedColor: primary.value,
    primary: primary.value,
    onPrimary: onPrimary.value,
    secondary: secondary.value,
    onSecondary: onSecondary.value,
    error: error.value,
    onError: onError.value,
    surface: surface.value,
    onSurface: onSurface.value,

  );

  void updateTheme({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? error,
    Color? onError,
    Color? surface,
    Color? onSurface,
  }) {
    if (primary != null) this.primary.value = primary;
    if (onPrimary != null) this.onPrimary.value = onPrimary;
    if (secondary != null) this.secondary.value = secondary;
    if (onSecondary != null) this.onSecondary.value = onSecondary;
    if (error != null) this.error.value = error;
    if (onError != null) this.onError.value = onError;
    if (surface != null) this.surface.value = surface;
    if (onSurface != null) this.onSurface.value = onSurface;


    // 更新全局主题颜色
    Global.colorScheme = colorScheme;
  }

}