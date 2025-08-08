import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
class Repository {
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final String name;
  @JsonKey(name: 'full_name')
  final String fullName;
  final Owner owner;
  final bool private;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? description;
  final bool fork;
  final String url;
  @JsonKey(name: 'forks_url')
  final String forksUrl;
  @JsonKey(name: 'keys_url')
  final String keysUrl;
  @JsonKey(name: 'collaborators_url')
  final String collaboratorsUrl;
  @JsonKey(name: 'teams_url')
  final String teamsUrl;
  @JsonKey(name: 'hooks_url')
  final String hooksUrl;
  @JsonKey(name: 'issue_events_url')
  final String issueEventsUrl;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'assignees_url')
  final String assigneesUrl;
  @JsonKey(name: 'branches_url')
  final String branchesUrl;
  @JsonKey(name: 'tags_url')
  final String tagsUrl;
  @JsonKey(name: 'blobs_url')
  final String blobsUrl;
  @JsonKey(name: 'git_tags_url')
  final String gitTagsUrl;
  @JsonKey(name: 'git_refs_url')
  final String gitRefsUrl;
  @JsonKey(name: 'trees_url')
  final String treesUrl;
  @JsonKey(name: 'statuses_url')
  final String statusesUrl;
  @JsonKey(name: 'languages_url')
  final String languagesUrl;
  @JsonKey(name: 'stargazers_url')
  final String stargazersUrl;
  @JsonKey(name: 'contributors_url')
  final String contributorsUrl;
  @JsonKey(name: 'subscribers_url')
  final String subscribersUrl;
  @JsonKey(name: 'subscription_url')
  final String subscriptionUrl;
  @JsonKey(name: 'commits_url')
  final String commitsUrl;
  @JsonKey(name: 'git_commits_url')
  final String gitCommitsUrl;
  @JsonKey(name: 'comments_url')
  final String commentsUrl;
  @JsonKey(name: 'issue_comment_url')
  final String issueCommentUrl;
  @JsonKey(name: 'contents_url')
  final String contentsUrl;
  @JsonKey(name: 'compare_url')
  final String compareUrl;
  @JsonKey(name: 'merges_url')
  final String mergesUrl;
  @JsonKey(name: 'archive_url')
  final String archiveUrl;
  @JsonKey(name: 'downloads_url')
  final String downloadsUrl;
  @JsonKey(name: 'issues_url')
  final String issuesUrl;
  @JsonKey(name: 'pulls_url')
  final String pullsUrl;
  @JsonKey(name: 'milestones_url')
  final String milestonesUrl;
  @JsonKey(name: 'notifications_url')
  final String notificationsUrl;
  @JsonKey(name: 'labels_url')
  final String labelsUrl;
  @JsonKey(name: 'releases_url')
  final String releasesUrl;
  @JsonKey(name: 'deployments_url')
  final String deploymentsUrl;
  @JsonKey(name: 'git_url')
  final String gitUrl;
  @JsonKey(name: 'ssh_url')
  final String sshUrl;
  @JsonKey(name: 'clone_url')
  final String cloneUrl;
  @JsonKey(name: 'svn_url')
  final String svnUrl;
  final String? homepage;
  final String? language;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @JsonKey(name: 'stargazers_count')
  int stargazersCount;
  @JsonKey(name: 'watchers_count')
  final int watchersCount;
  final int size;
  @JsonKey(name: 'default_branch')
  final String defaultBranch;
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;
  @JsonKey(name: 'is_template')
  final bool isTemplate;
  final List<String>? topics;
  @JsonKey(name: 'has_issues')
  final bool hasIssues;
  @JsonKey(name: 'has_projects')
  final bool hasProjects;
  @JsonKey(name: 'has_wiki')
  final bool hasWiki;
  @JsonKey(name: 'has_pages')
  final bool hasPages;
  @JsonKey(name: 'has_downloads')
  final bool hasDownloads;
  @JsonKey(name: 'has_discussions')
  final bool hasDiscussions;
  final bool archived;
  final bool disabled;
  final String visibility;
  @JsonKey(name: 'pushed_at')
  final String pushedAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final Permissions? permissions;
  @JsonKey(name: 'security_and_analysis')
  final SecurityAndAnalysis? securityAndAnalysis;

  final Repository? parent;
  final Repository? source;

  Repository({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.private,
    required this.htmlUrl,
    this.description,
    required this.fork,
    required this.url,
    required this.forksUrl,
    required this.keysUrl,
    required this.collaboratorsUrl,
    required this.teamsUrl,
    required this.hooksUrl,
    required this.issueEventsUrl,
    required this.eventsUrl,
    required this.assigneesUrl,
    required this.branchesUrl,
    required this.tagsUrl,
    required this.blobsUrl,
    required this.gitTagsUrl,
    required this.gitRefsUrl,
    required this.treesUrl,
    required this.statusesUrl,
    required this.languagesUrl,
    required this.stargazersUrl,
    required this.contributorsUrl,
    required this.subscribersUrl,
    required this.subscriptionUrl,
    required this.commitsUrl,
    required this.gitCommitsUrl,
    required this.commentsUrl,
    required this.issueCommentUrl,
    required this.contentsUrl,
    required this.compareUrl,
    required this.mergesUrl,
    required this.archiveUrl,
    required this.downloadsUrl,
    required this.issuesUrl,
    required this.pullsUrl,
    required this.milestonesUrl,
    required this.notificationsUrl,
    required this.labelsUrl,
    required this.releasesUrl,
    required this.deploymentsUrl,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    this.homepage,
    this.language,
    required this.forksCount,
    required this.stargazersCount,
    required this.watchersCount,
    required this.size,
    required this.defaultBranch,
    required this.openIssuesCount,
    required this.isTemplate,
    this.topics,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasWiki,
    required this.hasPages,
    required this.hasDownloads,
    required this.hasDiscussions,
    required this.archived,
    required this.disabled,
    required this.visibility,
    required this.pushedAt,
    required this.createdAt,
    required this.updatedAt,
    this.permissions,
    this.securityAndAnalysis,
    this.parent,
    this.source
  });

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}

@JsonSerializable()
class Owner {
  final String login;
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'gravatar_id')
  final String gravatarId;
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  @JsonKey(name: 'followers_url')
  final String followersUrl;
  @JsonKey(name: 'following_url')
  final String followingUrl;
  @JsonKey(name: 'gists_url')
  final String gistsUrl;
  @JsonKey(name: 'starred_url')
  final String starredUrl;
  @JsonKey(name: 'subscriptions_url')
  final String subscriptionsUrl;
  @JsonKey(name: 'organizations_url')
  final String organizationsUrl;
  @JsonKey(name: 'repos_url')
  final String reposUrl;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'received_events_url')
  final String receivedEventsUrl;
  final String type;
  @JsonKey(name: 'site_admin')
  final bool siteAdmin;

  Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}

@JsonSerializable()
class Permissions {
  final bool admin;
  final bool push;
  final bool pull;

  Permissions({
    required this.admin,
    required this.push,
    required this.pull,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) => _$PermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}

@JsonSerializable()
class SecurityAndAnalysis {
  @JsonKey(name: 'advanced_security')
  final SecurityFeature? advancedSecurity;
  @JsonKey(name: 'secret_scanning')
  final SecurityFeature? secretScanning;
  @JsonKey(name: 'secret_scanning_push_protection')
  final SecurityFeature? secretScanningPushProtection;
  @JsonKey(name: 'secret_scanning_non_provider_patterns')
  final SecurityFeature? secretScanningNonProviderPatterns;

  SecurityAndAnalysis({
    this.advancedSecurity,
    this.secretScanning,
    this.secretScanningPushProtection,
    this.secretScanningNonProviderPatterns,
  });

  factory SecurityAndAnalysis.fromJson(Map<String, dynamic> json) => _$SecurityAndAnalysisFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityAndAnalysisToJson(this);
}

@JsonSerializable()
class SecurityFeature {
  final String status;

  SecurityFeature({
    required this.status,
  });

  factory SecurityFeature.fromJson(Map<String, dynamic> json) => _$SecurityFeatureFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityFeatureToJson(this);
}