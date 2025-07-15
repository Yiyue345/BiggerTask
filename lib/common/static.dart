import 'package:biggertask/models/github_user.dart';
import 'package:flutter/material.dart';

class Global {
  static String? token;
  static String? userId;
  static String? userName;
  static String? userEmail;
  static String? userPhone;
  static String? userAvatar;
  static String? userBio;
  static String? userLocation;
  static String? userWebsite;

  static GitHubUser? gitHubUser;

  static bool isLogin = false;

  static Color? primaryColor;
  static Color? secondaryColor;
  static Color? surfaceColor;
  static Color? errorColor;

  static Color? onPrimaryColor;
  static Color? onSecondaryColor;
  static Color? onSurfaceColor;
  static Color? onErrorColor;

  static ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
    primary: primaryColor,
    secondary: secondaryColor,
    surface: surfaceColor,
    error: errorColor,
    onPrimary: onPrimaryColor,
    onSecondary: onSecondaryColor,
    onSurface: onSurfaceColor,
    onError: onErrorColor
  );

}