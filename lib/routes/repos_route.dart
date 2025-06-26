import 'package:flutter/material.dart';

class RepositoryRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RepositoryRouteState();
}

class _RepositoryRouteState extends State<RepositoryRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repositories'),
      ),
      body: Center(
        child: Text('Repository List will be displayed here.'),
      ),
    );
  }
}
