import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ThemeColorsContainer extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final Color errorColor;

  // 一堆用来回调(比如 setState)的函数
  final Function(Color color)? onPrimaryColorChanged;
  final Function(Color color)? onSecondaryColorChanged;
  final Function(Color color)? onSurfaceColorChanged;
  final Function(Color color)? onErrorColorChanged;

  final String primaryColorTitle;
  final String secondaryColorTitle;
  final String surfaceColorTitle;
  final String errorColorTitle;


  const ThemeColorsContainer({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.errorColor,
    required this.surfaceColor,
    this.onPrimaryColorChanged,
    this.onSecondaryColorChanged,
    this.onErrorColorChanged,
    this.onSurfaceColorChanged,
    this.primaryColorTitle = '选择主色',
    this.secondaryColorTitle = '选择强调色',
    this.surfaceColorTitle = '选择背景色',
    this.errorColorTitle = '选择错误提示颜色',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 580, // 对黄金分割的拙劣模仿
              child: Row(
                children: [
                  // 主色选择
                  Expanded(
                    flex: 580,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8))
                        ),
                        child: InkWell(
                          onTap: () async {
                            await ColorPicker(
                              color: primaryColor,
                              title: Text(primaryColorTitle),
                              // heading: Text('heading'),
                              subheading: Text('渐变色'),
                              opacitySubheading: Text('透明度'),
                              onColorChanged: (color) {
                                if (onPrimaryColorChanged != null) {
                                  onPrimaryColorChanged!(color);
                                }
                              },

                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.primary: true,
                                ColorPickerType.accent: false,
                                ColorPickerType.wheel : true
                              },
                              pickerTypeLabels: pickerTypeLabels,

                              enableOpacity: true, // 启用透明度选择
                              showColorName: true,
                              showMaterialName: true,
                              showColorCode: true,
                              colorCodeHasColor: true,
                              actionButtons: ColorPickerActionButtons( // 对话框按钮设置
                                dialogActionButtons: true,
                                dialogActionIcons: true,
                                // dialogOkButtonType: ColorPickerActionButtonType.outlined,
                                dialogOkButtonLabel: '确定',
                                dialogCancelButtonLabel: '取消',
                              ),
                            ).showPickerDialog(context);
                          },
                        ),
                      ),
                  ),
                  Spacer(
                    flex: 67,
                  ),
                  // 强调色选择
                  Expanded(
                    flex: 345,
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8))
                        ),
                        child: InkWell(
                          onTap: () async {
                            await ColorPicker(
                              color: secondaryColor,
                              title: Text(secondaryColorTitle),
                              // heading: Text('heading'),
                              subheading: Text('渐变色'),
                              opacitySubheading: Text('透明度'),
                              onColorChanged: (color) {
                                if (onSecondaryColorChanged != null) {
                                  onSecondaryColorChanged!(color);
                                }
                              },
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.primary: false,
                                ColorPickerType.accent: true,
                                ColorPickerType.wheel : true
                              },
                              pickerTypeLabels: pickerTypeLabels,

                              enableOpacity: true,
                              showColorName: true,
                              showMaterialName: true,
                              showColorCode: true,
                              colorCodeHasColor: true,
                              actionButtons: ColorPickerActionButtons(
                                dialogActionButtons: true,
                                dialogActionIcons: true,
                                // dialogOkButtonType: ColorPickerActionButtonType.outlined,
                                dialogOkButtonLabel: '确定',
                                dialogCancelButtonLabel: '取消',
                              ),
                            ).showPickerDialog(context);
                          },
                        ),
                      )
                  )
                ],
              )
          ),
          Spacer(
            flex: 67,
          ),
          Expanded(
              flex: 345,
              child: Row(
                children: [
                  // 背景色选择
                  Expanded(
                    flex: 580,
                    child: Container(
                      decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))
                      ),
                      child: InkWell(
                        onTap: () async {
                          await ColorPicker(
                            color: surfaceColor,
                            title: Text(surfaceColorTitle),
                            // heading: Text('heading'),
                            subheading: Text('渐变色'),
                            opacitySubheading: Text('透明度'),
                            onColorChanged: (color) {
                              if (onSurfaceColorChanged != null) {
                                onSurfaceColorChanged!(color);
                              }
                            },
                            pickersEnabled: const <ColorPickerType, bool>{
                              ColorPickerType.primary: false,
                              ColorPickerType.accent: false,
                              ColorPickerType.wheel : true
                            },
                            pickerTypeLabels: pickerTypeLabels,

                            enableOpacity: true,
                            showColorName: true,
                            showMaterialName: true,
                            showColorCode: true,
                            colorCodeHasColor: true,
                            actionButtons: ColorPickerActionButtons(
                              dialogActionButtons: true,
                              dialogActionIcons: true,
                              // dialogOkButtonType: ColorPickerActionButtonType.outlined,
                              dialogOkButtonLabel: '确定',
                              dialogCancelButtonLabel: '取消',
                            ),
                          ).showPickerDialog(context);
                        },
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 67,
                  ),
                  // 错误状态颜色选择
                  Expanded(
                      flex: 345,
                      child: Container(
                        decoration: BoxDecoration(
                            color: errorColor,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))
                        ),
                        child: InkWell(
                          onTap: () async {
                            await ColorPicker(
                              color: errorColor,
                              title: Text(errorColorTitle),
                              // heading: Text('heading'),
                              subheading: Text('渐变色'),
                              opacitySubheading: Text('透明度'),
                              onColorChanged: (color) {
                                if (onErrorColorChanged != null) {
                                  onErrorColorChanged!(color);
                                }
                              },
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.primary: false,
                                ColorPickerType.accent: false,
                                ColorPickerType.wheel : true
                              },
                              pickerTypeLabels: pickerTypeLabels,

                              enableOpacity: true,
                              showColorName: true,
                              showMaterialName: true,
                              showColorCode: true,
                              colorCodeHasColor: true,
                              actionButtons: ColorPickerActionButtons(
                                dialogActionButtons: true,
                                dialogActionIcons: true,
                                // dialogOkButtonType: ColorPickerActionButtonType.outlined,
                                dialogOkButtonLabel: '确定',
                                dialogCancelButtonLabel: '取消',
                              ),
                            ).showPickerDialog(context);
                          },
                        ),
                      )
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  Map<ColorPickerType, String> get pickerTypeLabels {
    return {
      ColorPickerType.primary: '主色',
      ColorPickerType.accent: '强调色',
      ColorPickerType.both: '主色与强调色',
      ColorPickerType.custom: '自定义',
      ColorPickerType.wheel : '轮盘'
    };
  }

}