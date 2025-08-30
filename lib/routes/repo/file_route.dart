import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/html_markdown/custom_node.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/models/repository_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:biggertask/html_markdown/video.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FileRoute extends StatefulWidget {
  final String repoFullName;
  final String filePath;
  late final String fileType;

  FileRoute({
    super.key,
    required this.repoFullName,
    required this.filePath
  }) {
    fileType = filePath.split('.').last;
  }

  @override
  State<StatefulWidget> createState() => _FileRouteState();
}

class _FileRouteState extends State<FileRoute> {

  late final RepositoryContent file;
  bool _isLoading = true;
  bool _isChoosing = false;
  int _selectedStartLine = -1;
  int _selectedEndLine = -1;
  List<String> lines = [];
  final Map<int, GlobalKey> _lineKeys = {};

  Future<void> _loadFile() async {
    file = (await Methods.getRepoContent(
      token: Global.token,
      repoFullName: widget.repoFullName,
      path: widget.filePath
    ))[0];
    // print(file.encoding);
    // print(file.decodedContent);
    setState(() {
      _isLoading = false;
    });

    lines = file.decodedContent?.split('\n') ?? [];

  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _isChoosing
          ? AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                _isChoosing = false;
                _selectedStartLine = -1;
                _selectedEndLine = -1;
              });
            },
            icon: Icon(
                Icons.close,
              color: Theme.of(context).colorScheme.onSecondary,
            )
        ),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: Icon(
                  Icons.settings,
                color: Theme.of(context).colorScheme.onSecondary,
              )
          ),
          IconButton(
              onPressed: _copySelectedLines,
              icon: Icon(
                Icons.copy,
                color: Theme.of(context).colorScheme.onSecondary,
              )
          ),

        ],
        backgroundColor: Theme.of(context).colorScheme.secondary,
      )
          : AppBar(
        title: Text(widget.filePath.split('/').last),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _chooseBody(widget.fileType),
    );
  }

  Widget _chooseBody(String type) {
    switch(widget.fileType.toLowerCase()) {
      case 'md':
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: MarkdownWidget(
            data: file.decodedContent ?? 'Unable to decode content',
            markdownGenerator: MarkdownGenerator(
                generators: [
                  videoGeneratorWithTag
                ],
                textGenerator: (node, config, visitor) =>
                    CustomTextNode(node.textContent, config, visitor),
                richTextBuilder: (span) => Text.rich(span)
            ),
            config: MarkdownConfig(
              configs: [
                // 让表格可以横向滚动
                TableConfig(
                  wrapper: (child) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      case 'png' || 'jpg' || 'jpeg' || 'gif' || 'bmp' || 'webp':
        return Center(
          child: GestureDetector(
            onLongPress: () async {
              await showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            await Methods.saveImage(
                                context: context,
                                imageUrl: file.downloadUrl!,
                                imageName: 'github_image_${DateTime.now().millisecondsSinceEpoch}'
                            );
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(file.downloadUrl!, width: 40, height: 40,),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(AppLocalizations.of(context)!.saveImage),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
              );
            },
            child: PhotoView(
              imageProvider: NetworkImage(file.downloadUrl!),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2.0,
                loadingBuilder: (context, event) => Center(
                  child: CircularProgressIndicator(
                    value: event?.expectedTotalBytes != null
                        ? event!.cumulativeBytesLoaded / event.expectedTotalBytes!
                        : null,
                  ),
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 48, color: Colors.red),
                      SizedBox(height: 8),
                      Text('Failed to load image'),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // 触发重新构建来重试加载
                          });
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  );
                }
            ),
          ),
        );
      default:
        if (lines.isEmpty) {
          return const Center(child: Text('File is empty'));
        }
        for (int i = 0; i < lines.length; i++) {
          _lineKeys[i] ??= GlobalKey();
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: lines.length,
            itemBuilder: (context, index) {
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
                            Container(
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
                        if (_isChoosing && index >= _selectedStartLine && index <= _selectedEndLine)
                          IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
    }
  }

  void _copySelectedLines() async {
    if (_selectedStartLine == -1 || _selectedEndLine == -1) return;

    final selectedLines = lines.sublist(_selectedStartLine, _selectedEndLine + 1);
    final textToCopy = selectedLines.join('\n');

    await Clipboard.setData(ClipboardData(text: textToCopy));

    Fluttertoast.showToast(msg: AppLocalizations.of(context)!.copiedSuccessfully);
  }

}