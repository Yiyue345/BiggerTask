import 'package:biggertask/l10n/app_localizations.dart';
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
    lines = code.split('\n');
    _maxLineWidth = null;
  }

  List<String> lines = [];
  bool _isChoosing = false;
  int _selectedStartLine = -1;
  int _selectedEndLine = -1;
  final Map<int, GlobalKey> _lineKeys = {};

  final String code = '''class GitHubLogin extends StatefulWidget {
  final Function(String token, Map<String, dynamic> userInfo) onLoginSuccess;
  final Function(String error) onLoginError;
  const GitHubLogin({
    super.key,
    required this.onLoginSuccess,
    required this.onLoginError,
  });

  @override
  _GitHubLoginState createState() => _GitHubLoginState();
}''';

  double? _maxLineWidth;
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  double _calculateMaxLineWidth() {
    if (_maxLineWidth != null) return _maxLineWidth!;

    double maxWidth = 0;
    final textStyle = TextStyle(
      fontFamily: 'monospace',
      fontSize: 12,
    );

    for (String line in lines) {
      _textPainter.text = TextSpan(
        text: line.isEmpty ? ' ' : line,
        style: textStyle,
      );
      _textPainter.layout();
      maxWidth = maxWidth < _textPainter.width ? _textPainter.width : maxWidth;
    }

    _maxLineWidth = maxWidth + (controller.showLineNumber.value ? 88 : 28); // 考虑行号和间距
    return _maxLineWidth!;
  }


  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < lines.length; i++) {
      _lineKeys[i] ??= GlobalKey();
    }


    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.codePreviewSettings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.showLineNumber),
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
            title: Text(AppLocalizations.of(context)!.lineWrap),
            trailing: Switch(
                value: controller.lineWrap.value,
                onChanged: (v) {
                  setState(() {
                    controller.lineWrap.value = v;
                    controller.sharedPreferences.setBool('lineWrap', v);
                  });
                }
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.preview,
            ),
            trailing: _isChoosing
                ? IconButton(
                onPressed: () {
                  setState(() {
                    _isChoosing = false;
                    _selectedStartLine = -1;
                    _selectedEndLine = -1;
                  });
                },
                icon: Icon(Icons.close)
            )
                : null,
          ),
        SizedBox(height: 4,),
          controller.lineWrap.value
              ? _buildWrappedListView()
              : _buildScrollableListView(),
        ],
      )
      ,
    ));

  }

  Widget _buildWrappedListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lines.length,
      itemBuilder: (context, index) => _buildCodeLine(index),
    );
  }

  Widget _buildScrollableListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: _calculateMaxLineWidth(),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: lines.length,
            itemBuilder: (context, index) => _buildCodeLine(index)
        ),

      ),
    );
  }

  Widget _buildCodeLine(int index) {
    final line = lines[index];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: _lineKeys[index],
        onLongPress: () {
          setState(() {
            _isChoosing = true;
            _selectedStartLine = index;
            _selectedEndLine = index;
          });
        },
        onTap: () {
          if (_isChoosing) {
            if (index < _selectedStartLine) {
              setState(() {
                _selectedStartLine = index;
              });
            }
            else if (index > _selectedEndLine) {
              setState(() {
                _selectedEndLine = index;
              });
            }
          }
        },
        child: IntrinsicHeight( // 高度一致
          child: Stack(
            children: [
              Row(
                children: [
                  AnimatedSize(
                      duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Obx(() => controller.showLineNumber.value
                        ? Container(
                      width: 30,
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border(
                              right: BorderSide(
                                  color: Colors.grey,
                                  width: 1
                              )
                          )
                      ),
                      child: Text(
                        '${index + 1} ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary.computeLuminance() > 0.5 ? Colors.black54 : Colors.white54,
                            fontSize: 12
                        ),
                      ),
                    )
                        : SizedBox(width: 0, height: double.infinity,)),
                  ),

                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      line.isEmpty ? ' ' : line,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        // color: Colors.black87,
                      ),
                    ),

                  ),

                ],
              ),
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: double.infinity,
                color: _isChoosing && index >= _selectedStartLine && index <= _selectedEndLine
                    ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2)
                    : Colors.transparent,
                child: IgnorePointer(child: SizedBox.expand(),),
              )
            ],
          ),
        ),
      ),
    );
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
