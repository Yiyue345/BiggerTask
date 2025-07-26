import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/routes/repository_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:get/get.dart';

class ReleaseRoute extends StatefulWidget {
  final Release release;
  final String repositoryName;

  const ReleaseRoute({
    super.key,
    required this.release,
    required this.repositoryName
  });

  @override
  State<ReleaseRoute> createState() => _ReleaseRouteState();
}

class _ReleaseRouteState extends State<ReleaseRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // 头像，拥有者和仓库
              Row(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.release.author.avatarUrl),
                    ),
                    onTap: () {
                      Get.to(() => UserInfoRoute(username: widget.release.author.login));
                    },
                  ),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => UserInfoRoute(username: widget.release.author.login));
                    },
                    child: Text(
                      widget.release.author.login,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed
                      ),
                    ),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed
                    ),
                  ),
                  FutureBuilder(
                      future: Methods.getRepository(widget.repositoryName, Global.token),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done || snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => RepositoryRoute(repository: snapshot.data!));
                            },
                            child: Text(
                              widget.repositoryName,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primaryFixed
                              ),
                            ),
                          );
                        }
                        else {
                          return Text(
                            widget.repositoryName,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primaryFixed
                            ),
                          );
                        }
                      }
                  ),

                ],
              ),

              MarkdownWidget(
                data: widget.release.body,
                shrinkWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
