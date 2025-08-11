import 'package:biggertask/common/methods.dart';
import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Get.to(() => UserInfoRoute(username: widget.repositoryName.split('/')[0]));
                    },
                    child: Text(
                      widget.repositoryName.split('/')[0], // 仓库拥有者
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixedDim,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixedDim
                    ),
                  ),
                  FutureBuilder(
                      future: Methods.getRepository(fullName: widget.repositoryName, token: Global.token),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done || snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => RepositoryRoute(repository: snapshot.data!));
                            },
                            child: Text(
                              widget.repositoryName.split('/')[1], // 仓库名称
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primaryFixedDim,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          );
                        }
                        else {
                          return Text(
                            widget.repositoryName.split('/')[1],
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primaryFixedDim,
                                fontWeight: FontWeight.bold
                            ),
                          );
                        }
                      }
                  ),
                ],
              ),
              Text(
                widget.release.name.isEmpty ? AppLocalizations.of(context)!.unNamed : widget.release.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(),
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
