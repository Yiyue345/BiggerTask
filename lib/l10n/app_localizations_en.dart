// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BiggerTask';

  @override
  String get search => 'Search';

  @override
  String get repositories => 'Repositories';

  @override
  String get commits => 'Commits';

  @override
  String get issues => 'Issues';

  @override
  String get pullRequests => 'Pull Requests';

  @override
  String get code => 'Code';

  @override
  String get users => 'Users';

  @override
  String get stars => 'Stars';

  @override
  String get forks => 'Forks';

  @override
  String get release => 'Releases';

  @override
  String get followers => 'Followers';

  @override
  String get followings => 'Followings';

  @override
  String followersCount(int followers) {
    String _temp0 = intl.Intl.pluralLogic(
      followers,
      locale: localeName,
      other: '$followers followers',
      one: '1 follower',
    );
    return '$_temp0';
  }

  @override
  String followingCount(int followings) {
    String _temp0 = intl.Intl.pluralLogic(
      followings,
      locale: localeName,
      other: '$followings followings',
      one: '1 following',
    );
    return '$_temp0';
  }

  @override
  String get settings => 'Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'OK';

  @override
  String get login => 'Login';

  @override
  String loginFailed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String loginError(Object error) {
    return 'Login error occurred: $error';
  }

  @override
  String get noLogin => 'Not logged in';

  @override
  String get exit => 'Sign out';

  @override
  String get exitTitle => 'Sign out';

  @override
  String get exitMessage => 'Are you sure you want to sign out?';

  @override
  String forkedFrom(String parentName) {
    return 'Forked from $parentName';
  }

  @override
  String get star => 'Star';

  @override
  String get unStar => 'Unstar';

  @override
  String get unStarMessage =>
      'Are you sure you want to unstar this repository?';

  @override
  String get starMessage => 'Are you sure you want to star this repository?';

  @override
  String get loading => 'Loading...';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get noEventText => 'No events found';

  @override
  String get theme => 'Theme';

  @override
  String get previousPage => 'Previous Page';

  @override
  String get nextPage => 'Next Page';

  @override
  String get noReadme => 'No README file found';

  @override
  String get readmeLoadFailed => 'Failed to load README';

  @override
  String get bottomNavigationExplore => 'Explore';

  @override
  String get bottomNavigationMine => 'Profile';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System Default';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageEnglish => 'English';
}
