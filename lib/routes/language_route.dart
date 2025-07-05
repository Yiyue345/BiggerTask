import 'package:flutter/material.dart';

class LanguageRoute extends StatefulWidget {
  const LanguageRoute({super.key});

  @override
  State<LanguageRoute> createState() => _LanguageRouteState();
}

class _LanguageRouteState extends State<LanguageRoute> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('语言'),
      ),
    );
  }
}

