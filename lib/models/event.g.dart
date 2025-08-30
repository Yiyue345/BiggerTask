// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  actor: Actor.fromJson(json['actor'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String,
  id: json['id'] as String?,
  org: json['org'] == null
      ? null
      : Organization.fromJson(json['org'] as Map<String, dynamic>),
  payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
  public: json['public'] as bool?,
  repo: EventRepository.fromJson(json['repo'] as Map<String, dynamic>),
  type: json['type'] as String?,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'actor': instance.actor,
  'created_at': instance.createdAt,
  'id': instance.id,
  'org': instance.org,
  'payload': instance.payload,
  'public': instance.public,
  'repo': instance.repo,
  'type': instance.type,
};

Actor _$ActorFromJson(Map<String, dynamic> json) => Actor(
  avatarUrl: json['avatar_url'] as String,
  displayLogin: json['display_login'] as String?,
  gravatarId: json['gravatar_id'] as String,
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
  'avatar_url': instance.avatarUrl,
  'display_login': instance.displayLogin,
  'gravatar_id': instance.gravatarId,
  'id': instance.id,
  'login': instance.login,
  'url': instance.url,
};

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
  avatarUrl: json['avatar_url'] as String?,
  displayLogin: json['display_login'] as String?,
  gravatarId: json['gravatar_id'] as String?,
  id: (json['id'] as num?)?.toInt(),
  login: json['login'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'avatar_url': instance.avatarUrl,
      'display_login': instance.displayLogin,
      'gravatar_id': instance.gravatarId,
      'id': instance.id,
      'login': instance.login,
      'url': instance.url,
    };

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
  action: json['action'] as String?,
  comment: json['comment'] == null
      ? null
      : Comment.fromJson(json['comment'] as Map<String, dynamic>),
  issue: json['issue'] == null
      ? null
      : Issue.fromJson(json['issue'] as Map<String, dynamic>),
  pages: (json['pages'] as List<dynamic>?)
      ?.map((e) => Page.fromJson(e as Map<String, dynamic>))
      .toList(),
  forkee: json['forkee'] == null
      ? null
      : EventRepository.fromJson(json['forkee'] as Map<String, dynamic>),
  ref: json['ref'] as String?,
  refType: json['ref_type'] as String?,
  masterBranch: json['master_branch'] as String?,
  description: json['description'] as String?,
  pusherType: json['pusher_type'] as String?,
  release: json['release'] == null
      ? null
      : Release.fromJson(json['release'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'action': instance.action,
  'comment': instance.comment,
  'issue': instance.issue,
  'pages': instance.pages,
  'forkee': instance.forkee,
  'ref': instance.ref,
  'ref_type': instance.refType,
  'master_branch': instance.masterBranch,
  'description': instance.description,
  'pusher_type': instance.pusherType,
  'release': instance.release,
};

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  authorAssociation: json['author_association'] as String?,
  body: json['body'] as String?,
  bodyHtml: json['body_html'] as String?,
  bodyText: json['body_text'] as String?,
  createdAt: json['created_at'] as String?,
  htmlUrl: json['html_url'] as String?,
  id: (json['id'] as num?)?.toInt(),
  issueUrl: json['issue_url'] as String?,
  nodeId: json['node_id'] as String?,
  performedViaGithubApp: json['performed_via_github_app'] == null
      ? null
      : GitHubApp.fromJson(
          json['performed_via_github_app'] as Map<String, dynamic>,
        ),
  reactions: json['reactions'] == null
      ? null
      : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
  updatedAt: json['updated_at'] as String?,
  url: json['url'] as String?,
  user: json['user'] == null
      ? null
      : EventUser.fromJson(json['user'] as Map<String, dynamic>),
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

EventRepository _$EventRepositoryFromJson(Map<String, dynamic> json) =>
    EventRepository(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$EventRepositoryToJson(EventRepository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };

GitHubApp _$GitHubAppFromJson(Map<String, dynamic> json) => GitHubApp(
  clientId: json['client_id'] as String?,
  clientSecret: json['client_secret'] as String?,
  createdAt: json['created_at'] as String?,
  description: json['description'] as String?,
  events: (json['events'] as List<dynamic>?)?.map((e) => e as String).toList(),
  externalUrl: json['external_url'] as String?,
  htmlUrl: json['html_url'] as String?,
  id: (json['id'] as num?)?.toInt(),
  installationsCount: (json['installations_count'] as num?)?.toInt(),
  name: json['name'] as String?,
  nodeId: json['node_id'] as String?,
  owner: json['owner'] == null
      ? null
      : EventUser.fromJson(json['owner'] as Map<String, dynamic>),
  pem: json['pem'] as String?,
  permissions: (json['permissions'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  slug: json['slug'] as String?,
  updatedAt: json['updated_at'] as String?,
  webhookSecret: json['webhook_secret'] as String?,
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

Reactions _$ReactionsFromJson(Map<String, dynamic> json) => Reactions(
  plusOne: (json['+1'] as num?)?.toInt(),
  minusOne: (json['-1'] as num?)?.toInt(),
  confused: (json['confused'] as num?)?.toInt(),
  eyes: (json['eyes'] as num?)?.toInt(),
  heart: (json['heart'] as num?)?.toInt(),
  hooray: (json['hooray'] as num?)?.toInt(),
  laugh: (json['laugh'] as num?)?.toInt(),
  rocket: (json['rocket'] as num?)?.toInt(),
  totalCount: (json['total_count'] as num?)?.toInt(),
  url: json['url'] as String?,
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

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
  activeLockReason: json['active_lock_reason'] as String?,
  assignee: json['assignee'] == null
      ? null
      : EventUser.fromJson(json['assignee'] as Map<String, dynamic>),
  assignees: (json['assignees'] as List<dynamic>?)
      ?.map((e) => EventUser.fromJson(e as Map<String, dynamic>))
      .toList(),
  authorAssociation: json['author_association'] as String?,
  body: json['body'] as String?,
  bodyHtml: json['body_html'] as String?,
  bodyText: json['body_text'] as String?,
  closedAt: json['closed_at'] as String?,
  comments: (json['comments'] as num?)?.toInt(),
  commentsUrl: json['comments_url'] as String?,
  createdAt: json['created_at'] as String?,
  eventsUrl: json['events_url'] as String?,
  htmlUrl: json['html_url'] as String?,
  id: (json['id'] as num?)?.toInt(),
  labels: (json['labels'] as List<dynamic>?)
      ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
      .toList(),
  labelsUrl: json['labels_url'] as String?,
  locked: json['locked'] as bool?,
  milestone: json['milestone'] == null
      ? null
      : Milestone.fromJson(json['milestone'] as Map<String, dynamic>),
  nodeId: json['node_id'] as String?,
  number: (json['number'] as num?)?.toInt(),
  performedViaGithubApp: json['performed_via_github_app'] == null
      ? null
      : GitHubApp.fromJson(
          json['performed_via_github_app'] as Map<String, dynamic>,
        ),
  pullRequest: json['pull_request'] == null
      ? null
      : PullRequest.fromJson(json['pull_request'] as Map<String, dynamic>),
  state: json['state'] as String?,
  timelineUrl: json['timeline_url'] as String?,
  title: json['title'] as String?,
  updatedAt: json['updated_at'] as String?,
  url: json['url'] as String?,
  user: json['user'] == null
      ? null
      : EventUser.fromJson(json['user'] as Map<String, dynamic>),
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
  'state': instance.state,
  'timeline_url': instance.timelineUrl,
  'title': instance.title,
  'updated_at': instance.updatedAt,
  'url': instance.url,
  'user': instance.user,
};

EventUser _$EventUserFromJson(Map<String, dynamic> json) => EventUser(
  avatarUrl: json['avatar_url'] as String,
  eventsUrl: json['events_url'] as String,
  followersUrl: json['followers_url'] as String,
  followingUrl: json['following_url'] as String,
  gistsUrl: json['gists_url'] as String,
  gravatarId: json['gravatar_id'] as String?,
  htmlUrl: json['html_url'] as String,
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  nodeId: json['node_id'] as String,
  organizationsUrl: json['organizations_url'] as String,
  receivedEventsUrl: json['received_events_url'] as String,
  reposUrl: json['repos_url'] as String,
  siteAdmin: json['site_admin'] as bool,
  starredAt: json['starred_at'] as String?,
  starredUrl: json['starred_url'] as String,
  subscriptionsUrl: json['subscriptions_url'] as String,
  type: json['type'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$EventUserToJson(EventUser instance) => <String, dynamic>{
  'avatar_url': instance.avatarUrl,
  'events_url': instance.eventsUrl,
  'followers_url': instance.followersUrl,
  'following_url': instance.followingUrl,
  'gists_url': instance.gistsUrl,
  'gravatar_id': instance.gravatarId,
  'html_url': instance.htmlUrl,
  'id': instance.id,
  'login': instance.login,
  'node_id': instance.nodeId,
  'organizations_url': instance.organizationsUrl,
  'received_events_url': instance.receivedEventsUrl,
  'repos_url': instance.reposUrl,
  'site_admin': instance.siteAdmin,
  'starred_at': instance.starredAt,
  'starred_url': instance.starredUrl,
  'subscriptions_url': instance.subscriptionsUrl,
  'type': instance.type,
  'url': instance.url,
};

Page _$PageFromJson(Map<String, dynamic> json) => Page(
  action: json['action'] as String?,
  htmlUrl: json['html_url'] as String?,
  pageName: json['page_name'] as String?,
  sha: json['sha'] as String?,
  summary: json['summary'] as String?,
  title: json['title'] as String?,
);

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
  'action': instance.action,
  'html_url': instance.htmlUrl,
  'page_name': instance.pageName,
  'sha': instance.sha,
  'summary': instance.summary,
  'title': instance.title,
};

Label _$LabelFromJson(Map<String, dynamic> json) => Label(
  color: json['color'] as String?,
  default_: json['default_'] as bool?,
  description: json['description'] as String?,
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nodeId: json['node_id'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
  'color': instance.color,
  'default_': instance.default_,
  'description': instance.description,
  'id': instance.id,
  'name': instance.name,
  'node_id': instance.nodeId,
  'url': instance.url,
};

Milestone _$MilestoneFromJson(Map<String, dynamic> json) => Milestone(
  closedAt: json['closed_at'] as String?,
  closedIssues: (json['closed_issues'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  creator: json['creator'] == null
      ? null
      : EventUser.fromJson(json['creator'] as Map<String, dynamic>),
  description: json['description'] as String?,
  dueOn: json['due_on'] as String?,
  htmlUrl: json['html_url'] as String?,
  id: (json['id'] as num?)?.toInt(),
  labelsUrl: json['labels_url'] as String?,
  nodeId: json['node_id'] as String?,
  number: (json['number'] as num?)?.toInt(),
  openIssues: (json['open_issues'] as num?)?.toInt(),
  state: json['state'] as String?,
  title: json['title'] as String?,
  updatedAt: json['updated_at'] as String?,
  url: json['url'] as String?,
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
  diffUrl: json['diff_url'] as String?,
  htmlUrl: json['html_url'] as String?,
  mergedAt: json['merged_at'] as String?,
  patchUrl: json['patch_url'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$PullRequestToJson(PullRequest instance) =>
    <String, dynamic>{
      'diff_url': instance.diffUrl,
      'html_url': instance.htmlUrl,
      'merged_at': instance.mergedAt,
      'patch_url': instance.patchUrl,
      'url': instance.url,
    };

Release _$ReleaseFromJson(Map<String, dynamic> json) => Release(
  url: json['url'] as String,
  htmlUrl: json['html_url'] as String,
  assetsUrl: json['assets_url'] as String,
  uploadUrl: json['upload_url'] as String,
  tarballUrl: json['tarball_url'] as String,
  zipballUrl: json['zipball_url'] as String,
  discussionUrl: json['discussion_url'] as String?,
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  tagName: json['tag_name'] as String,
  targetCommitish: json['target_commitish'] as String,
  name: json['name'] as String,
  body: json['body'] as String,
  draft: json['draft'] as bool,
  prerelease: json['prerelease'] as bool,
  immutable: json['immutable'] as bool,
  createdAt: json['created_at'] as String,
  publishedAt: json['published_at'] as String?,
  author: EventUser.fromJson(json['author'] as Map<String, dynamic>),
  assets: (json['assets'] as List<dynamic>)
      .map((e) => ReleaseAsset.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
  'url': instance.url,
  'html_url': instance.htmlUrl,
  'assets_url': instance.assetsUrl,
  'upload_url': instance.uploadUrl,
  'tarball_url': instance.tarballUrl,
  'zipball_url': instance.zipballUrl,
  'discussion_url': instance.discussionUrl,
  'id': instance.id,
  'node_id': instance.nodeId,
  'tag_name': instance.tagName,
  'target_commitish': instance.targetCommitish,
  'name': instance.name,
  'body': instance.body,
  'draft': instance.draft,
  'prerelease': instance.prerelease,
  'immutable': instance.immutable,
  'created_at': instance.createdAt,
  'published_at': instance.publishedAt,
  'author': instance.author,
  'assets': instance.assets,
};

ReleaseAsset _$ReleaseAssetFromJson(Map<String, dynamic> json) => ReleaseAsset(
  url: json['url'] as String,
  browserDownloadUrl: json['browser_download_url'] as String,
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  name: json['name'] as String,
  label: json['label'] as String?,
  state: json['state'] as String,
  contentType: json['content_type'] as String,
  size: (json['size'] as num).toInt(),
  digest: json['digest'] as String?,
  downloadCount: (json['download_count'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  uploader: EventUser.fromJson(json['uploader'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReleaseAssetToJson(ReleaseAsset instance) =>
    <String, dynamic>{
      'url': instance.url,
      'browser_download_url': instance.browserDownloadUrl,
      'id': instance.id,
      'node_id': instance.nodeId,
      'name': instance.name,
      'label': instance.label,
      'state': instance.state,
      'content_type': instance.contentType,
      'size': instance.size,
      'digest': instance.digest,
      'download_count': instance.downloadCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'uploader': instance.uploader,
    };
