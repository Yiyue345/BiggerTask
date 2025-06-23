import 'package:flutter/material.dart';

class UserInfoRoute extends StatefulWidget {
  const UserInfoRoute({super.key});

  @override
  State<UserInfoRoute> createState() => _UserInfoRouteState();
}

class _UserInfoRouteState extends State<UserInfoRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('这是用户信息页'),
    );
  }
}

