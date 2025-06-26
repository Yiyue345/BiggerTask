// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) => Repository(
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  name: json['name'] as String,
  fullName: json['full_name'] as String,
  owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
  private: json['private'] as bool,
  htmlUrl: json['html_url'] as String,
  description: json['description'] as String?,
  fork: json['fork'] as bool,
  url: json['url'] as String,
  forksUrl: json['forks_url'] as String,
  keysUrl: json['keys_url'] as String,
  collaboratorsUrl: json['collaborators_url'] as String,
  teamsUrl: json['teams_url'] as String,
  hooksUrl: json['hooks_url'] as String,
  issueEventsUrl: json['issue_events_url'] as String,
  eventsUrl: json['events_url'] as String,
  assigneesUrl: json['assignees_url'] as String,
  branchesUrl: json['branches_url'] as String,
  tagsUrl: json['tags_url'] as String,
  blobsUrl: json['blobs_url'] as String,
  gitTagsUrl: json['git_tags_url'] as String,
  gitRefsUrl: json['git_refs_url'] as String,
  treesUrl: json['trees_url'] as String,
  statusesUrl: json['statuses_url'] as String,
  languagesUrl: json['languages_url'] as String,
  stargazersUrl: json['stargazers_url'] as String,
  contributorsUrl: json['contributors_url'] as String,
  subscribersUrl: json['subscribers_url'] as String,
  subscriptionUrl: json['subscription_url'] as String,
  commitsUrl: json['commits_url'] as String,
  gitCommitsUrl: json['git_commits_url'] as String,
  commentsUrl: json['comments_url'] as String,
  issueCommentUrl: json['issue_comment_url'] as String,
  contentsUrl: json['contents_url'] as String,
  compareUrl: json['compare_url'] as String,
  mergesUrl: json['merges_url'] as String,
  archiveUrl: json['archive_url'] as String,
  downloadsUrl: json['downloads_url'] as String,
  issuesUrl: json['issues_url'] as String,
  pullsUrl: json['pulls_url'] as String,
  milestonesUrl: json['milestones_url'] as String,
  notificationsUrl: json['notifications_url'] as String,
  labelsUrl: json['labels_url'] as String,
  releasesUrl: json['releases_url'] as String,
  deploymentsUrl: json['deployments_url'] as String,
  gitUrl: json['git_url'] as String,
  sshUrl: json['ssh_url'] as String,
  cloneUrl: json['clone_url'] as String,
  svnUrl: json['svn_url'] as String,
  homepage: json['homepage'] as String?,
  language: json['language'] as String?,
  forksCount: (json['forks_count'] as num).toInt(),
  stargazersCount: (json['stargazers_count'] as num).toInt(),
  watchersCount: (json['watchers_count'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  defaultBranch: json['default_branch'] as String,
  openIssuesCount: (json['open_issues_count'] as num).toInt(),
  isTemplate: json['is_template'] as bool,
  topics: (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList(),
  hasIssues: json['has_issues'] as bool,
  hasProjects: json['has_projects'] as bool,
  hasWiki: json['has_wiki'] as bool,
  hasPages: json['has_pages'] as bool,
  hasDownloads: json['has_downloads'] as bool,
  hasDiscussions: json['has_discussions'] as bool,
  archived: json['archived'] as bool,
  disabled: json['disabled'] as bool,
  visibility: json['visibility'] as String,
  pushedAt: json['pushed_at'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  permissions:
      json['permissions'] == null
          ? null
          : Permissions.fromJson(json['permissions'] as Map<String, dynamic>),
  securityAndAnalysis:
      json['security_and_analysis'] == null
          ? null
          : SecurityAndAnalysis.fromJson(
            json['security_and_analysis'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$RepositoryToJson(Repository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.nodeId,
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'private': instance.private,
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'fork': instance.fork,
      'url': instance.url,
      'forks_url': instance.forksUrl,
      'keys_url': instance.keysUrl,
      'collaborators_url': instance.collaboratorsUrl,
      'teams_url': instance.teamsUrl,
      'hooks_url': instance.hooksUrl,
      'issue_events_url': instance.issueEventsUrl,
      'events_url': instance.eventsUrl,
      'assignees_url': instance.assigneesUrl,
      'branches_url': instance.branchesUrl,
      'tags_url': instance.tagsUrl,
      'blobs_url': instance.blobsUrl,
      'git_tags_url': instance.gitTagsUrl,
      'git_refs_url': instance.gitRefsUrl,
      'trees_url': instance.treesUrl,
      'statuses_url': instance.statusesUrl,
      'languages_url': instance.languagesUrl,
      'stargazers_url': instance.stargazersUrl,
      'contributors_url': instance.contributorsUrl,
      'subscribers_url': instance.subscribersUrl,
      'subscription_url': instance.subscriptionUrl,
      'commits_url': instance.commitsUrl,
      'git_commits_url': instance.gitCommitsUrl,
      'comments_url': instance.commentsUrl,
      'issue_comment_url': instance.issueCommentUrl,
      'contents_url': instance.contentsUrl,
      'compare_url': instance.compareUrl,
      'merges_url': instance.mergesUrl,
      'archive_url': instance.archiveUrl,
      'downloads_url': instance.downloadsUrl,
      'issues_url': instance.issuesUrl,
      'pulls_url': instance.pullsUrl,
      'milestones_url': instance.milestonesUrl,
      'notifications_url': instance.notificationsUrl,
      'labels_url': instance.labelsUrl,
      'releases_url': instance.releasesUrl,
      'deployments_url': instance.deploymentsUrl,
      'git_url': instance.gitUrl,
      'ssh_url': instance.sshUrl,
      'clone_url': instance.cloneUrl,
      'svn_url': instance.svnUrl,
      'homepage': instance.homepage,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'size': instance.size,
      'default_branch': instance.defaultBranch,
      'open_issues_count': instance.openIssuesCount,
      'is_template': instance.isTemplate,
      'topics': instance.topics,
      'has_issues': instance.hasIssues,
      'has_projects': instance.hasProjects,
      'has_wiki': instance.hasWiki,
      'has_pages': instance.hasPages,
      'has_downloads': instance.hasDownloads,
      'has_discussions': instance.hasDiscussions,
      'archived': instance.archived,
      'disabled': instance.disabled,
      'visibility': instance.visibility,
      'pushed_at': instance.pushedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'permissions': instance.permissions,
      'security_and_analysis': instance.securityAndAnalysis,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
  login: json['login'] as String,
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  avatarUrl: json['avatar_url'] as String,
  gravatarId: json['gravatar_id'] as String,
  url: json['url'] as String,
  htmlUrl: json['html_url'] as String,
  followersUrl: json['followers_url'] as String,
  followingUrl: json['following_url'] as String,
  gistsUrl: json['gists_url'] as String,
  starredUrl: json['starred_url'] as String,
  subscriptionsUrl: json['subscriptions_url'] as String,
  organizationsUrl: json['organizations_url'] as String,
  reposUrl: json['repos_url'] as String,
  eventsUrl: json['events_url'] as String,
  receivedEventsUrl: json['received_events_url'] as String,
  type: json['type'] as String,
  siteAdmin: json['site_admin'] as bool,
);

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
  'login': instance.login,
  'id': instance.id,
  'node_id': instance.nodeId,
  'avatar_url': instance.avatarUrl,
  'gravatar_id': instance.gravatarId,
  'url': instance.url,
  'html_url': instance.htmlUrl,
  'followers_url': instance.followersUrl,
  'following_url': instance.followingUrl,
  'gists_url': instance.gistsUrl,
  'starred_url': instance.starredUrl,
  'subscriptions_url': instance.subscriptionsUrl,
  'organizations_url': instance.organizationsUrl,
  'repos_url': instance.reposUrl,
  'events_url': instance.eventsUrl,
  'received_events_url': instance.receivedEventsUrl,
  'type': instance.type,
  'site_admin': instance.siteAdmin,
};

Permissions _$PermissionsFromJson(Map<String, dynamic> json) => Permissions(
  admin: json['admin'] as bool,
  push: json['push'] as bool,
  pull: json['pull'] as bool,
);

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{
      'admin': instance.admin,
      'push': instance.push,
      'pull': instance.pull,
    };

SecurityAndAnalysis _$SecurityAndAnalysisFromJson(Map<String, dynamic> json) =>
    SecurityAndAnalysis(
      advancedSecurity:
          json['advanced_security'] == null
              ? null
              : SecurityFeature.fromJson(
                json['advanced_security'] as Map<String, dynamic>,
              ),
      secretScanning:
          json['secret_scanning'] == null
              ? null
              : SecurityFeature.fromJson(
                json['secret_scanning'] as Map<String, dynamic>,
              ),
      secretScanningPushProtection:
          json['secret_scanning_push_protection'] == null
              ? null
              : SecurityFeature.fromJson(
                json['secret_scanning_push_protection'] as Map<String, dynamic>,
              ),
      secretScanningNonProviderPatterns:
          json['secret_scanning_non_provider_patterns'] == null
              ? null
              : SecurityFeature.fromJson(
                json['secret_scanning_non_provider_patterns']
                    as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$SecurityAndAnalysisToJson(
  SecurityAndAnalysis instance,
) => <String, dynamic>{
  'advanced_security': instance.advancedSecurity,
  'secret_scanning': instance.secretScanning,
  'secret_scanning_push_protection': instance.secretScanningPushProtection,
  'secret_scanning_non_provider_patterns':
      instance.secretScanningNonProviderPatterns,
};

SecurityFeature _$SecurityFeatureFromJson(Map<String, dynamic> json) =>
    SecurityFeature(status: json['status'] as String);

Map<String, dynamic> _$SecurityFeatureToJson(SecurityFeature instance) =>
    <String, dynamic>{'status': instance.status};
