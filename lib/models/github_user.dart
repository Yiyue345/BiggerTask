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

@JsonSerializable()
class SimpleOrganization {
  final String login;
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final String url;
  @JsonKey(name: 'repos_url')
  final String reposUrl;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'hooks_url')
  final String hooksUrl;
  @JsonKey(name: 'issues_url')
  final String issuesUrl;
  @JsonKey(name: 'members_url')
  final String membersUrl;
  @JsonKey(name: 'public_members_url')
  final String publicMembersUrl;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final String? description;

  SimpleOrganization({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.url,
    required this.reposUrl,
    required this.eventsUrl,
    required this.hooksUrl,
    required this.issuesUrl,
    required this.membersUrl,
    required this.publicMembersUrl,
    required this.avatarUrl,
    this.description,
  });

  factory SimpleOrganization.fromJson(Map<String, dynamic> json) =>
      _$SimpleOrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleOrganizationToJson(this);
}

@JsonSerializable()
class Organization extends SimpleOrganization {
  @JsonKey(name: 'billing_email')
  final String? billingEmail;
  final String? blog;
  final int? collaborators;
  final String? company;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'default_repository_permission')
  final String? defaultRepositoryPermission;
  @JsonKey(name: 'disk_usage')
  final int? diskUsage;
  final String? email;
  final int? followers;
  final int? following;
  @JsonKey(name: 'has_organization_projects')
  final bool? hasOrganizationProjects;
  @JsonKey(name: 'has_repository_projects')
  final bool? hasRepositoryProjects;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  final String? location;
  @JsonKey(name: 'members_allowed_repository_creation_type')
  final String? membersAllowedRepositoryCreationType;
  @JsonKey(name: 'members_can_create_internal_repositories')
  final bool? membersCanCreateInternalRepositories;
  @JsonKey(name: 'members_can_create_pages')
  final bool? membersCanCreatePages;
  @JsonKey(name: 'members_can_create_private_pages')
  final bool? membersCanCreatePrivatePages;
  @JsonKey(name: 'members_can_create_private_repositories')
  final bool? membersCanCreatePrivateRepositories;
  @JsonKey(name: 'members_can_create_public_pages')
  final bool? membersCanCreatePublicPages;
  @JsonKey(name: 'members_can_create_public_repositories')
  final bool? membersCanCreatePublicRepositories;
  @JsonKey(name: 'members_can_create_repositories')
  final bool? membersCanCreateRepositories;
  final String? name;
  @JsonKey(name: 'owned_private_repos')
  final int? ownedPrivateRepos;
  final OrganizationPlan? plan;
  @JsonKey(name: 'private_gists')
  final int? privateGists;
  @JsonKey(name: 'public_gists')
  final int? publicGists;
  @JsonKey(name: 'public_repos')
  final int? publicRepos;
  @JsonKey(name: 'total_private_repos')
  final int? totalPrivateRepos;
  @JsonKey(name: 'twitter_username')
  final String? twitterUsername;
  @JsonKey(name: 'two_factor_requirement_enabled')
  final bool? twoFactorRequirementEnabled;
  final String type;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Organization({
    required super.login,
    required super.id,
    required super.nodeId,
    required super.url,
    required super.reposUrl,
    required super.eventsUrl,
    required super.hooksUrl,
    required super.issuesUrl,
    required super.membersUrl,
    required super.publicMembersUrl,
    required super.avatarUrl,
    super.description,
    this.billingEmail,
    this.blog,
    this.collaborators,
    this.company,
    required this.createdAt,
    this.defaultRepositoryPermission,
    this.diskUsage,
    this.email,
    this.followers,
    this.following,
    this.hasOrganizationProjects,
    this.hasRepositoryProjects,
    this.isVerified,
    this.location,
    this.membersAllowedRepositoryCreationType,
    this.membersCanCreateInternalRepositories,
    this.membersCanCreatePages,
    this.membersCanCreatePrivatePages,
    this.membersCanCreatePrivateRepositories,
    this.membersCanCreatePublicPages,
    this.membersCanCreatePublicRepositories,
    this.membersCanCreateRepositories,
    this.name,
    this.ownedPrivateRepos,
    this.plan,
    this.privateGists,
    this.publicGists,
    this.publicRepos,
    this.totalPrivateRepos,
    this.twitterUsername,
    this.twoFactorRequirementEnabled,
    required this.type,
    this.updatedAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class OrganizationPlan {
  @JsonKey(name: 'filled_seats')
  final int filledSeats;
  final String name;
  @JsonKey(name: 'private_repos')
  final int privateRepos;
  final int seats;
  final int space;

  OrganizationPlan({
    required this.filledSeats,
    required this.name,
    required this.privateRepos,
    required this.seats,
    required this.space,
  });

  factory OrganizationPlan.fromJson(Map<String, dynamic> json) =>
      _$OrganizationPlanFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationPlanToJson(this);
}