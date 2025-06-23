import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';

@JsonSerializable()
class GitHubUser {
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
  @JsonKey(name: 'private_gists')
  final int privateGists;
  @JsonKey(name: 'total_private_repos')
  final int totalPrivateRepos;
  @JsonKey(name: 'owned_private_repos')
  final int ownedPrivateRepos;
  @JsonKey(name: 'disk_usage')
  final int diskUsage;
  final int collaborators;
  @JsonKey(name: 'two_factor_authentication')
  final bool twoFactorAuthentication;
  final GithubPlan? plan;

  GitHubUser({
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
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
    required this.privateGists,
    required this.totalPrivateRepos,
    required this.ownedPrivateRepos,
    required this.diskUsage,
    required this.collaborators,
    required this.twoFactorAuthentication,
    this.plan,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) => _$GitHubUserFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserToJson(this);
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

  factory GithubPlan.fromJson(Map<String, dynamic> json) => _$GithubPlanFromJson(json);
  Map<String, dynamic> toJson() => _$GithubPlanToJson(this);
}