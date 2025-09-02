import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeSettingsRoute extends StatefulWidget {

  final bool showLineNumber;
  final bool lineWrap;

  const CodeSettingsRoute({super.key, required this.showLineNumber, required this.lineWrap});

  @override
  State<StatefulWidget> createState() => _CodeSettingsRouteState();
}

class _CodeSettingsRouteState extends State<CodeSettingsRoute> {
  bool showLineNumber = true;
  bool lineWrap = false;

  final CodeSettingsController controller = Get.put(CodeSettingsController());

  @override
  void initState() {
    super.initState();
    showLineNumber = widget.showLineNumber;
    lineWrap = widget.lineWrap;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text('Code Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('显示行号'),
            trailing: Switch(
                value: controller.showLineNumber.value,
                onChanged: (v) {
                  setState(() {
                    controller.showLineNumber.value = v;
                    controller.sharedPreferences.setBool('showLineNumber', v);
                  });
                }
            ),
          ),
          ListTile(
            title: Text('换行'),
            trailing: Switch(
                value: controller.lineWrap.value,
                onChanged: (v) {
                  setState(() {
                    controller.lineWrap.value = v;
                    controller.sharedPreferences.setBool('lineWrap', v);
                  });
                }
            ),
          )
        ],
      )
      ,
    ));
  }
}

class CodeSettingsController extends GetxController {
  var showLineNumber = true.obs;
  var lineWrap = false.obs;

  late final SharedPreferences sharedPreferences;

  @override
  onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    sharedPreferences = await SharedPreferences.getInstance();
    showLineNumber.value = sharedPreferences.getBool('showLineNumber') ?? true;
    lineWrap.value = sharedPreferences.getBool('lineWrap') ?? false;
  }

  void setShowLineNumber(bool value) {
    showLineNumber.value = value;
    sharedPreferences.setBool('showLineNumber', value);
  }

  void setLineWrap(bool value) {
    lineWrap.value = value;
    sharedPreferences.setBool('lineWrap', value);
  }
}
