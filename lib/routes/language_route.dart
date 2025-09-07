import 'package:biggertask/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageRoute extends StatelessWidget {

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(l10n.languageSystem),
              onTap: () => controller.followSystemLanguage(),
              trailing: controller.isFollowingSystem.value
              ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary,)
              : null,
            ),
            ListTile(
              title: Text(l10n.languageGerman),
              onTap: () => controller.changeLocale('de'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('de')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageEnglish),
              onTap: () => controller.changeLocale('en'),
              trailing: !controller.isFollowingSystem.value && 
                  _isCurrentLocale('en')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageFrench),
              onTap: () => controller.changeLocale('fr'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('fr')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageJapanese),
              onTap: () => controller.changeLocale('ja'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('ja')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageRussian),
              onTap: () => controller.changeLocale('ru'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('ru')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageChinese),
              onTap: () => controller.changeLocale('zh'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('zh')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageChineseMicrosoft),
              onTap: () => controller.changeLocale('zh_MS'),
              trailing: !controller.isFollowingSystem.value &&
                  _isCurrentLocale('zh_MS')
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            )
          ],
        ),
      ),
    ));
  }

  bool _isCurrentLocale(String languageCode) {
    final current = controller.currentLocale.value;
    if (current == null) return false;

    if (languageCode.contains('_')) {
      final parts = languageCode.split('_');
      return current.languageCode == parts[0] && current.countryCode == parts[1];
    } else {
      return current.languageCode == languageCode && current.countryCode == null;
    }
  }

}


class LanguageController extends GetxController {
  var currentLocale = Get.deviceLocale.obs;
  var isFollowingSystem = true.obs;

  @override
  void onInit() {
    super.onInit();
    _roadSavedLanguage();
  }

  void _roadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('language');
    final followSystem = prefs.getBool('follow_system') ?? true;

    isFollowingSystem.value = followSystem;

    if (followSystem) {
      currentLocale.value = Get.deviceLocale!;
    }
    else if (savedLanguage != null) {
      Locale locale;
      if (savedLanguage.contains('_')) {
        final parts = savedLanguage.split('_');
        locale = Locale(parts[0], parts[1]);
      } else {
        locale = Locale(savedLanguage);
      }
      currentLocale.value = locale;
      Get.updateLocale(locale);
    }

  }

  void changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    Locale locale;
    if (languageCode.contains('_')) {
      var parts = languageCode.split('_');
      locale = Locale(parts[0], parts[1]);
    } else {
      locale = Locale(languageCode);
    }
    Get.updateLocale(locale);
    currentLocale.value = locale;
    isFollowingSystem.value = false;

    await prefs.setString('language', languageCode);
    await prefs.setBool('follow_system', false);
  }

  void followSystemLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    var locale = Get.deviceLocale!;
    Get.updateLocale(locale);
    currentLocale.value = locale;
    isFollowingSystem.value = true;

    await prefs.setBool('follow_system', true);
    await prefs.remove('language');
  }

}
