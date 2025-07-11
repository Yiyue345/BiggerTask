import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const KeepAliveWrapper({super.key, required this.child, this.keepAlive = true});

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void didUpdateWidget(KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态发生变化时更新
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }
}
