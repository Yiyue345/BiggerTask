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
              title: Text(l10n.languageEnglish),
              onTap: () => controller.changeLocale('en'),
              trailing: !controller.isFollowingSystem.value &&
              controller.currentLocale.value!.languageCode == 'en'
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
            ListTile(
              title: Text(l10n.languageChinese),
              onTap: () => controller.changeLocale('zh'),
              trailing: !controller.isFollowingSystem.value &&
                  controller.currentLocale.value!.languageCode == 'zh'
                  ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                  : null,
            ),
          ],
        ),
      ),
    ));
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
      currentLocale.value = Locale(savedLanguage);
      Get.updateLocale(currentLocale.value!);
    }

  }

  void changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    var locale = Locale(languageCode);
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
