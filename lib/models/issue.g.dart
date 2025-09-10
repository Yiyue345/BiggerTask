// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Label _$LabelFromJson(Map<String, dynamic> json) => Label(
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  url: json['url'] as String,
  name: json['name'] as String,
  color: json['color'] as String,
  description: json['description'] as String?,
  default_: json['default_'] as bool?,
);

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
  'id': instance.id,
  'node_id': instance.nodeId,
  'url': instance.url,
  'name': instance.name,
  'color': instance.color,
  'description': instance.description,
  'default_': instance.default_,
};

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => Milestone(
  closedAt: json['closed_at'] as String?,
  closedIssues: (json['closed_issues'] as num).toInt(),
  createdAt: json['created_at'] as String,
  creator: SimpleGitHubUser.fromJson(json['creator'] as Map<String, dynamic>),
  description: json['description'] as String,
  dueOn: json['due_on'] as String?,
  htmlUrl: json['html_url'] as String,
  id: (json['id'] as num).toInt(),
  labelsUrl: json['labels_url'] as String,
  nodeId: json['node_id'] as String,
  number: (json['number'] as num).toInt(),
  openIssues: (json['open_issues'] as num).toInt(),
  state: json['state'] as String,
  title: json['title'] as String,
  updatedAt: json['updated_at'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$MilestoneToJson(Milestone instance) => <String, dynamic>{
  'closed_at': instance.closedAt,
  'closed_issues': instance.closedIssues,
  'created_at': instance.createdAt,
  'creator': instance.creator,
  'description': instance.description,
  'due_on': instance.dueOn,
  'html_url': instance.htmlUrl,
  'id': instance.id,
  'labels_url': instance.labelsUrl,
  'node_id': instance.nodeId,
  'number': instance.number,
  'open_issues': instance.openIssues,
  'state': instance.state,
  'title': instance.title,
  'updated_at': instance.updatedAt,
  'url': instance.url,
};

PullRequest _$PullRequestFromJson(Map<String, dynamic> json) => PullRequest(
  diffUrl: json['diff_url'] as String,
  htmlUrl: json['html_url'] as String,
  mergedAt: json['merged_at'] as String?,
  patchUrl: json['patch_url'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$PullRequestToJson(PullRequest instance) =>
    <String, dynamic>{
      'diff_url': instance.diffUrl,
      'html_url': instance.htmlUrl,
      'merged_at': instance.mergedAt,
      'patch_url': instance.patchUrl,
      'url': instance.url,
    };

Reactions _$ReactionsFromJson(Map<String, dynamic> json) => Reactions(
  plusOne: (json['+1'] as num).toInt(),
  minusOne: (json['-1'] as num).toInt(),
  confused: (json['confused'] as num).toInt(),
  eyes: (json['eyes'] as num).toInt(),
  heart: (json['heart'] as num).toInt(),
  hooray: (json['hooray'] as num).toInt(),
  laugh: (json['laugh'] as num).toInt(),
  rocket: (json['rocket'] as num).toInt(),
  totalCount: (json['total_count'] as num).toInt(),
  url: json['url'] as String,
);

Map<String, dynamic> _$ReactionsToJson(Reactions instance) => <String, dynamic>{
  '+1': instance.plusOne,
  '-1': instance.minusOne,
  'confused': instance.confused,
  'eyes': instance.eyes,
  'heart': instance.heart,
  'hooray': instance.hooray,
  'laugh': instance.laugh,
  'rocket': instance.rocket,
  'total_count': instance.totalCount,
  'url': instance.url,
};

GitHubAppPermissions _$GitHubAppPermissionsFromJson(
  Map<String, dynamic> json,
) => GitHubAppPermissions(
  deployments: json['deployments'] as String?,
  issues: json['issues'] as String?,
);

Map<String, dynamic> _$GitHubAppPermissionsToJson(
  GitHubAppPermissions instance,
) => <String, dynamic>{
  'deployments': instance.deployments,
  'issues': instance.issues,
};

GitHubApp _$GitHubAppFromJson(Map<String, dynamic> json) => GitHubApp(
  clientId: json['client_id'] as String?,
  clientSecret: json['client_secret'] as String?,
  createdAt: json['created_at'] as String,
  description: json['description'] as String,
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
  externalUrl: json['external_url'] as String,
  htmlUrl: json['html_url'] as String,
  id: (json['id'] as num).toInt(),
  installationsCount: (json['installations_count'] as num).toInt(),
  name: json['name'] as String,
  nodeId: json['node_id'] as String,
  owner: SimpleGitHubUser.fromJson(json['owner'] as Map<String, dynamic>),
  pem: json['pem'] as String,
  permissions: GitHubAppPermissions.fromJson(
    json['permissions'] as Map<String, dynamic>,
  ),
  slug: json['slug'] as String,
  updatedAt: json['updated_at'] as String,
  webhookSecret: json['webhook_secret'] as String,
);

Map<String, dynamic> _$GitHubAppToJson(GitHubApp instance) => <String, dynamic>{
  'client_id': instance.clientId,
  'client_secret': instance.clientSecret,
  'created_at': instance.createdAt,
  'description': instance.description,
  'events': instance.events,
  'external_url': instance.externalUrl,
  'html_url': instance.htmlUrl,
  'id': instance.id,
  'installations_count': instance.installationsCount,
  'name': instance.name,
  'node_id': instance.nodeId,
  'owner': instance.owner,
  'pem': instance.pem,
  'permissions': instance.permissions,
  'slug': instance.slug,
  'updated_at': instance.updatedAt,
  'webhook_secret': instance.webhookSecret,
};

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
  activeLockReason: json['active_lock_reason'] as String?,
  assignee: json['assignee'] == null
      ? null
      : SimpleGitHubUser.fromJson(json['assignee'] as Map<String, dynamic>),
  assignees: (json['assignees'] as List<dynamic>?)
      ?.map((e) => SimpleGitHubUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  authorAssociation: json['author_association'] as String,
  body: json['body'] as String?,
  bodyHtml: json['body_html'] as String?,
  bodyText: json['body_text'] as String?,
  closedAt: json['closed_at'] as String?,
  closedBy: json['closed_by'] == null
      ? null
      : SimpleGitHubUser.fromJson(json['closed_by'] as Map<String, dynamic>),
  comments: (json['comments'] as num).toInt(),
  commentsUrl: json['comments_url'] as String,
  createdAt: json['created_at'] as String,
  eventsUrl: json['events_url'] as String,
  htmlUrl: json['html_url'] as String,
  id: (json['id'] as num).toInt(),
  labels: (json['labels'] as List<dynamic>?)
      ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
      .toList(),
  labelsUrl: json['labels_url'] as String,
  locked: json['locked'] as bool,
  milestone: json['milestone'] == null
      ? null
      : Milestone.fromJson(json['milestone'] as Map<String, dynamic>),
  nodeId: json['node_id'] as String,
  number: (json['number'] as num).toInt(),
  performedViaGithubApp: json['performed_via_github_app'] == null
      ? null
      : GitHubApp.fromJson(
          json['performed_via_github_app'] as Map<String, dynamic>,
        ),
  pullRequest: json['pull_request'] == null
      ? null
      : PullRequest.fromJson(json['pull_request'] as Map<String, dynamic>),
  reactions: json['reactions'] == null
      ? null
      : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
  repository: json['repository'] == null
      ? null
      : Repository.fromJson(json['repository'] as Map<String, dynamic>),
  repositoryUrl: json['repository_url'] as String,
  state: json['state'] as String,
  timelineUrl: json['timeline_url'] as String,
  title: json['title'] as String,
  updatedAt: json['updated_at'] as String,
  url: json['url'] as String,
  user: SimpleGitHubUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
  'active_lock_reason': instance.activeLockReason,
  'assignee': instance.assignee,
  'assignees': instance.assignees,
  'author_association': instance.authorAssociation,
  'body': instance.body,
  'body_html': instance.bodyHtml,
  'body_text': instance.bodyText,
  'closed_at': instance.closedAt,
  'closed_by': instance.closedBy,
  'comments': instance.comments,
  'comments_url': instance.commentsUrl,
  'created_at': instance.createdAt,
  'events_url': instance.eventsUrl,
  'html_url': instance.htmlUrl,
  'id': instance.id,
  'labels': instance.labels,
  'labels_url': instance.labelsUrl,
  'locked': instance.locked,
  'milestone': instance.milestone,
  'node_id': instance.nodeId,
  'number': instance.number,
  'performed_via_github_app': instance.performedViaGithubApp,
  'pull_request': instance.pullRequest,
  'reactions': instance.reactions,
  'repository': instance.repository,
  'repository_url': instance.repositoryUrl,
  'state': instance.state,
  'timeline_url': instance.timelineUrl,
  'title': instance.title,
  'updated_at': instance.updatedAt,
  'url': instance.url,
  'user': instance.user,
};

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  authorAssociation: json['author_association'] as String,
  body: json['body'] as String,
  bodyHtml: json['body_html'] as String?,
  bodyText: json['body_text'] as String?,
  createdAt: json['created_at'] as String,
  htmlUrl: json['html_url'] as String,
  id: (json['id'] as num).toInt(),
  issueUrl: json['issue_url'] as String,
  nodeId: json['node_id'] as String,
  performedViaGithubApp: json['performed_via_github_app'] == null
      ? null
      : GitHubApp.fromJson(
          json['performed_via_github_app'] as Map<String, dynamic>,
        ),
  reactions: json['reactions'] == null
      ? null
      : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
  updatedAt: json['updated_at'] as String,
  url: json['url'] as String,
  user: SimpleGitHubUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'author_association': instance.authorAssociation,
  'body': instance.body,
  'body_html': instance.bodyHtml,
  'body_text': instance.bodyText,
  'created_at': instance.createdAt,
  'html_url': instance.htmlUrl,
  'id': instance.id,
  'issue_url': instance.issueUrl,
  'node_id': instance.nodeId,
  'performed_via_github_app': instance.performedViaGithubApp,
  'reactions': instance.reactions,
  'updated_at': instance.updatedAt,
  'url': instance.url,
  'user': instance.user,
};
