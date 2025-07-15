import 'package:biggertask/common/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:biggertask/common/static.dart';


class ThemeController extends GetxController {
  var primary = Global.colorScheme.primary.obs;
  var onPrimary = Global.colorScheme.onPrimary.obs;
  var secondary = Global.colorScheme.secondary.obs;
  var onSecondary = Global.colorScheme.onSecondary.obs;
  var error = Global.colorScheme.error.obs;
  var onError = Global.colorScheme.onError.obs;
  var surface = Global.colorScheme.surface.obs;
  var onSurface = Global.colorScheme.onSurface.obs;

  var autoSelectTextColor = true.obs;
  var advancedTheme = false.obs;

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