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
      gravatarId: json['gravatar_id'] as String,
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
    };

GitHubUser _$GitHubUserFromJson(Map<String, dynamic> json) => GitHubUser(
  avatarUrl: json['avatar_url'] as String,
  eventsUrl: json['events_url'] as String,
  followersUrl: json['followers_url'] as String,
  followingUrl: json['following_url'] as String,
  gistsUrl: json['gists_url'] as String,
  gravatarId: json['gravatar_id'] as String,
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
