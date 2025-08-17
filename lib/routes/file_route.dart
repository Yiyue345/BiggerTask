import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/html_markdown/custom_node.dart';
import 'package:biggertask/models/repository_content.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:biggertask/html_markdown/video.dart';

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


  Future<void> _loadFile() async {
    file = (await Methods.getRepoContent(
      token: Global.token,
      repoFullName: widget.repoFullName,
      path: widget.filePath
    ))[0];
    print(file.encoding);
    print(file.decodedContent);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = _isLoading ? SizedBox() : _chooseBody(widget.fileType);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filePath.split('/').last),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : bodyContent,
    );
  }

  Widget _chooseBody(String type) {
    switch(widget.fileType) {
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
      default:
        final List<String> lines = file.decodedContent?.split('\n') ?? [];
        if (lines.isEmpty) {
          return const Center(child: Text('File is empty'));
        }
        return ListView.builder(
          shrinkWrap: true,
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onLongPress: () {

                  },
                  onTap: () {

                  },
                  child: IntrinsicHeight( // 高度一致
                    child: Row(
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
                  ),
                ),
              );
            }
        );
    }
  }
}