import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';


@JsonSerializable()
class SimpleGitHubUser {
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'followers_url')
  final String followersUrl;
  @JsonKey(name: 'following_url')
  final String followingUrl;
  @JsonKey(name: 'gists_url')
  final String gistsUrl;
  @JsonKey(name: 'gravatar_id')
  final String? gravatarId;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  final String login;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'organizations_url')
  final String organizationsUrl;
  @JsonKey(name: 'received_events_url')
  final String receivedEventsUrl;
  @JsonKey(name: 'repos_url')
  final String reposUrl;
  @JsonKey(name: 'site_admin')
  final bool siteAdmin;
  @JsonKey(name: 'starred_url')
  final String starredUrl;
  @JsonKey(name: 'subscriptions_url')
  final String subscriptionsUrl;
  final String type;
  final String url;
  @JsonKey(name: 'starred_at')
  final String? starredAt;
  @JsonKey(name: 'score')
  final double? score;

  SimpleGitHubUser({
    required this.avatarUrl,
    required this.eventsUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    this.gravatarId,
    required this.htmlUrl,
    required this.id,
    required this.login,
    required this.nodeId,
    required this.organizationsUrl,
    required this.receivedEventsUrl,
    required this.reposUrl,
    required this.siteAdmin,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.type,
    required this.url,
    this.starredAt,
    this.score,
  });

  factory SimpleGitHubUser.fromJson(Map<String, dynamic> json) =>
      _$SimpleGitHubUserFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleGitHubUserToJson(this);
}


@JsonSerializable()
class GitHubUser extends SimpleGitHubUser {
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final bool? hireable;
  final String? bio;
  @JsonKey(name: 'twitter_username')
  final String? twitterUsername;
  @JsonKey(name: 'public_repos')
  final int publicRepos;
  @JsonKey(name: 'public_gists')
  final int publicGists;
  final int followers;
  final int following;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'owned_private_repos')
  final int? privateRepos;

  GitHubUser({
    required super.avatarUrl,
    required super.eventsUrl,
    required super.followersUrl,
    required super.followingUrl,
    required super.gistsUrl,
    required super.gravatarId,
    required super.htmlUrl,
    required super.id,
    required super.login,
    required super.nodeId,
    required super.organizationsUrl,
    required super.receivedEventsUrl,
    required super.reposUrl,
    required super.siteAdmin,
    required super.starredUrl,
    required super.subscriptionsUrl,
    required super.type,
    required super.url,
    super.starredAt,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    this.privateRepos,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) =>
      _$GitHubUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GitHubUserToJson(this);
}

@JsonSerializable()
class ContributorUser extends SimpleGitHubUser {
  final int contributions;

  ContributorUser({
    required super.avatarUrl,
    required super.eventsUrl,
    required super.followersUrl,
    required super.followingUrl,
    required super.gistsUrl,
    super.gravatarId,
    required super.htmlUrl,
    required super.id,
    required super.login,
    required super.nodeId,
    required super.organizationsUrl,
    required super.receivedEventsUrl,
    required super.reposUrl,
    required super.siteAdmin,
    required super.starredUrl,
    required super.subscriptionsUrl,
    required super.type,
    required super.url,
    super.starredAt,
    super.score,
    required this.contributions,
  });

  factory ContributorUser.fromJson(Map<String, dynamic> json) =>
      _$ContributorUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContributorUserToJson(this);
}

@JsonSerializable()
class GithubPlan {
  final String name;
  final int space;
  @JsonKey(name: 'private_repos')
  final int privateRepos;
  final int collaborators;

  GithubPlan({
    required this.name,
    required this.space,
    required this.privateRepos,
    required this.collaborators,
  });

  factory GithubPlan.fromJson(Map<String, dynamic> json) =>
      _$GithubPlanFromJson(json);

  Map<String, dynamic> toJson() => _$GithubPlanToJson(this);
}