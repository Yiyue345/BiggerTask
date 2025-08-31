// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleGitHubUser _$SimpleGitHubUserFromJson(Map<String, dynamic> json) =>
    SimpleGitHubUser(
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
      starredUrl: json['starred_url'] as String,
      subscriptionsUrl: json['subscriptions_url'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      starredAt: json['starred_at'] as String?,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SimpleGitHubUserToJson(SimpleGitHubUser instance) =>
    <String, dynamic>{
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
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'type': instance.type,
      'url': instance.url,
      'starred_at': instance.starredAt,
      'score': instance.score,
    };

GitHubUser _$GitHubUserFromJson(Map<String, dynamic> json) => GitHubUser(
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
  starredUrl: json['starred_url'] as String,
  subscriptionsUrl: json['subscriptions_url'] as String,
  type: json['type'] as String,
  url: json['url'] as String,
  starredAt: json['starred_at'] as String?,
  name: json['name'] as String?,
  company: json['company'] as String?,
  blog: json['blog'] as String?,
  location: json['location'] as String?,
  email: json['email'] as String?,
  hireable: json['hireable'] as bool?,
  bio: json['bio'] as String?,
  twitterUsername: json['twitter_username'] as String?,
  privateRepos: (json['owned_private_repos'] as num?)?.toInt(),
  publicRepos: (json['public_repos'] as num).toInt(),
  publicGists: (json['public_gists'] as num).toInt(),
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$GitHubUserToJson(GitHubUser instance) =>
    <String, dynamic>{
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
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'type': instance.type,
      'url': instance.url,
      'starred_at': instance.starredAt,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'twitter_username': instance.twitterUsername,
      'public_repos': instance.publicRepos,
      'public_gists': instance.publicGists,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'owned_private_repos': instance.privateRepos,
    };

ContributorUser _$ContributorUserFromJson(Map<String, dynamic> json) =>
    ContributorUser(
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
      starredUrl: json['starred_url'] as String,
      subscriptionsUrl: json['subscriptions_url'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      starredAt: json['starred_at'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      contributions: (json['contributions'] as num).toInt(),
    );

Map<String, dynamic> _$ContributorUserToJson(ContributorUser instance) =>
    <String, dynamic>{
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
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'type': instance.type,
      'url': instance.url,
      'starred_at': instance.starredAt,
      'score': instance.score,
      'contributions': instance.contributions,
    };

GithubPlan _$GithubPlanFromJson(Map<String, dynamic> json) => GithubPlan(
  name: json['name'] as String,
  space: (json['space'] as num).toInt(),
  privateRepos: (json['private_repos'] as num).toInt(),
  collaborators: (json['collaborators'] as num).toInt(),
);

Map<String, dynamic> _$GithubPlanToJson(GithubPlan instance) =>
    <String, dynamic>{
      'name': instance.name,
      'space': instance.space,
      'private_repos': instance.privateRepos,
      'collaborators': instance.collaborators,
    };

SimpleOrganization _$SimpleOrganizationFromJson(Map<String, dynamic> json) =>
    SimpleOrganization(
      login: json['login'] as String,
      id: (json['id'] as num).toInt(),
      nodeId: json['node_id'] as String,
      url: json['url'] as String,
      reposUrl: json['repos_url'] as String,
      eventsUrl: json['events_url'] as String,
      hooksUrl: json['hooks_url'] as String,
      issuesUrl: json['issues_url'] as String,
      membersUrl: json['members_url'] as String,
      publicMembersUrl: json['public_members_url'] as String,
      avatarUrl: json['avatar_url'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SimpleOrganizationToJson(SimpleOrganization instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'url': instance.url,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'hooks_url': instance.hooksUrl,
      'issues_url': instance.issuesUrl,
      'members_url': instance.membersUrl,
      'public_members_url': instance.publicMembersUrl,
      'avatar_url': instance.avatarUrl,
      'description': instance.description,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
  login: json['login'] as String,
  id: (json['id'] as num).toInt(),
  nodeId: json['node_id'] as String,
  url: json['url'] as String,
  reposUrl: json['repos_url'] as String,
  eventsUrl: json['events_url'] as String,
  hooksUrl: json['hooks_url'] as String,
  issuesUrl: json['issues_url'] as String,
  membersUrl: json['members_url'] as String,
  publicMembersUrl: json['public_members_url'] as String,
  avatarUrl: json['avatar_url'] as String,
  description: json['description'] as String?,
  billingEmail: json['billing_email'] as String?,
  blog: json['blog'] as String?,
  collaborators: (json['collaborators'] as num?)?.toInt(),
  company: json['company'] as String?,
  createdAt: json['created_at'] as String,
  defaultRepositoryPermission: json['default_repository_permission'] as String?,
  diskUsage: (json['disk_usage'] as num?)?.toInt(),
  email: json['email'] as String?,
  followers: (json['followers'] as num?)?.toInt(),
  following: (json['following'] as num?)?.toInt(),
  hasOrganizationProjects: json['has_organization_projects'] as bool?,
  hasRepositoryProjects: json['has_repository_projects'] as bool?,
  isVerified: json['is_verified'] as bool?,
  location: json['location'] as String?,
  membersAllowedRepositoryCreationType:
      json['members_allowed_repository_creation_type'] as String?,
  membersCanCreateInternalRepositories:
      json['members_can_create_internal_repositories'] as bool?,
  membersCanCreatePages: json['members_can_create_pages'] as bool?,
  membersCanCreatePrivatePages:
      json['members_can_create_private_pages'] as bool?,
  membersCanCreatePrivateRepositories:
      json['members_can_create_private_repositories'] as bool?,
  membersCanCreatePublicPages: json['members_can_create_public_pages'] as bool?,
  membersCanCreatePublicRepositories:
      json['members_can_create_public_repositories'] as bool?,
  membersCanCreateRepositories:
      json['members_can_create_repositories'] as bool?,
  name: json['name'] as String?,
  ownedPrivateRepos: (json['owned_private_repos'] as num?)?.toInt(),
  plan: json['plan'] == null
      ? null
      : OrganizationPlan.fromJson(json['plan'] as Map<String, dynamic>),
  privateGists: (json['private_gists'] as num?)?.toInt(),
  publicGists: (json['public_gists'] as num?)?.toInt(),
  publicRepos: (json['public_repos'] as num?)?.toInt(),
  totalPrivateRepos: (json['total_private_repos'] as num?)?.toInt(),
  twitterUsername: json['twitter_username'] as String?,
  twoFactorRequirementEnabled: json['two_factor_requirement_enabled'] as bool?,
  type: json['type'] as String,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'url': instance.url,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'hooks_url': instance.hooksUrl,
      'issues_url': instance.issuesUrl,
      'members_url': instance.membersUrl,
      'public_members_url': instance.publicMembersUrl,
      'avatar_url': instance.avatarUrl,
      'description': instance.description,
      'billing_email': instance.billingEmail,
      'blog': instance.blog,
      'collaborators': instance.collaborators,
      'company': instance.company,
      'created_at': instance.createdAt,
      'default_repository_permission': instance.defaultRepositoryPermission,
      'disk_usage': instance.diskUsage,
      'email': instance.email,
      'followers': instance.followers,
      'following': instance.following,
      'has_organization_projects': instance.hasOrganizationProjects,
      'has_repository_projects': instance.hasRepositoryProjects,
      'is_verified': instance.isVerified,
      'location': instance.location,
      'members_allowed_repository_creation_type':
          instance.membersAllowedRepositoryCreationType,
      'members_can_create_internal_repositories':
          instance.membersCanCreateInternalRepositories,
      'members_can_create_pages': instance.membersCanCreatePages,
      'members_can_create_private_pages': instance.membersCanCreatePrivatePages,
      'members_can_create_private_repositories':
          instance.membersCanCreatePrivateRepositories,
      'members_can_create_public_pages': instance.membersCanCreatePublicPages,
      'members_can_create_public_repositories':
          instance.membersCanCreatePublicRepositories,
      'members_can_create_repositories': instance.membersCanCreateRepositories,
      'name': instance.name,
      'owned_private_repos': instance.ownedPrivateRepos,
      'plan': instance.plan,
      'private_gists': instance.privateGists,
      'public_gists': instance.publicGists,
      'public_repos': instance.publicRepos,
      'total_private_repos': instance.totalPrivateRepos,
      'twitter_username': instance.twitterUsername,
      'two_factor_requirement_enabled': instance.twoFactorRequirementEnabled,
      'type': instance.type,
      'updated_at': instance.updatedAt,
    };

OrganizationPlan _$OrganizationPlanFromJson(Map<String, dynamic> json) =>
    OrganizationPlan(
      filledSeats: (json['filled_seats'] as num).toInt(),
      name: json['name'] as String,
      privateRepos: (json['private_repos'] as num).toInt(),
      seats: (json['seats'] as num).toInt(),
      space: (json['space'] as num).toInt(),
    );

Map<String, dynamic> _$OrganizationPlanToJson(OrganizationPlan instance) =>
    <String, dynamic>{
      'filled_seats': instance.filledSeats,
      'name': instance.name,
      'private_repos': instance.privateRepos,
      'seats': instance.seats,
      'space': instance.space,
    };
