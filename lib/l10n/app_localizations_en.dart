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
  String get topics => 'Topics';

  @override
  String get users => 'Users';

  @override
  String get stars => 'Stars';

  @override
  String get forks => 'Forks';

  @override
  String get release => 'Releases';

  @override
  String get userInfo => 'User Info';

  @override
  String get contributors => 'Contributors';

  @override
  String get starRepositories => 'Starred Repositories';

  @override
  String get public => 'Public';

  @override
  String get private => 'Private';

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
  String get organizations => 'Organizations';

  @override
  String get members => 'Members';

  @override
  String memberCount(int members) {
    String _temp0 = intl.Intl.pluralLogic(
      members,
      locale: localeName,
      other: '$members members',
      one: '1 member',
    );
    return '$_temp0';
  }

  @override
  String get noMore => 'No more data';

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
  String whose(String who) {
    return '$who\'s';
  }

  @override
  String searchForSomething(String what) {
    return 'Search for $what';
  }

  @override
  String get gitHubLogin => 'GitHub Login';

  @override
  String get noBio => 'No bio provided';

  @override
  String get loading => 'Loading...';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get savedSuccessfully => 'Saved successfully!';

  @override
  String get copiedSuccessfully => 'Copied successfully!';

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
  String get noDescription => 'No description provided';

  @override
  String get noMoreRepos => 'No more repositories';

  @override
  String get noReleases => 'No releases found';

  @override
  String get unNamed => 'Unnamed';

  @override
  String get repoNoExistOrPrivate =>
      'This repository does not exist or is private';

  @override
  String get cannotSaveImageWithNoPermissionToGallery =>
      'Permission to access gallery is required to save images';

  @override
  String get saveImage => 'Save Image';

  @override
  String get savingImage => 'Saving image...';

  @override
  String get imageSaved => 'Image saved to gallery';

  @override
  String get imageSaveFailed => 'Failed to save image';

  @override
  String get forkARepository => 'Forked a repository';

  @override
  String get starARepository => 'Starred a repository';

  @override
  String get createARepository => 'Created a repository';

  @override
  String get createABranch => 'Created a branch';

  @override
  String get createATag => 'Created a tag';

  @override
  String get deleteABranch => 'Deleted a branch';

  @override
  String get deleteATag => 'Deleted a tag';

  @override
  String get releaseANewVersion => 'Released a new version';

  @override
  String get now => 'Just now';

  @override
  String minuteAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String hourAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String dayAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String monthAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months months ago',
      one: '1 month ago',
    );
    return '$_temp0';
  }

  @override
  String yearAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years ago',
      one: '1 year ago',
    );
    return '$_temp0';
  }

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
  String get languageChineseMicrosoft => 'Chinese (Microsoft)';

  @override
  String get languageEnglish => 'English';

  @override
  String get choosePrimaryColor => 'Choose Primary Color';

  @override
  String get chooseSecondaryColor => 'Choose Accent Color';

  @override
  String get chooseSurfaceColor => 'Choose Surface Color';

  @override
  String get chooseErrorColor => 'Choose Error Color';

  @override
  String get chooseOnPrimaryColor => 'Text Color on Primary Color';

  @override
  String get chooseOnSecondaryColor => 'Text Color on Accent Color';

  @override
  String get chooseOnSurfaceColor => 'Text Color on Surface Color';

  @override
  String get chooseOnErrorColor => 'Text Color on Error Color';

  @override
  String get colorShade => 'Color Shade';

  @override
  String get opacity => 'Opacity';

  @override
  String get saveChangesOfTheme => 'Save Theme Changes';

  @override
  String get unSavedThemeChangesTitle => 'Unsaved Changes';

  @override
  String get unSavedThemeChangesMessage =>
      'You have unsaved changes. Do you want to exit without saving?';

  @override
  String get cannotDeleteLastTheme => 'At least one theme must be kept';

  @override
  String get longPressToDeleteTheme => 'Long press to delete theme';

  @override
  String get advancedThemeSettings => 'Advanced Theme Settings';

  @override
  String get autoSelectOtherColors => 'Automatically set other colors';

  @override
  String get autoSelectTextColors => 'Automatically set text colors';

  @override
  String get enableDarkMode => 'Dark Mode';

  @override
  String get primaryColorLabel => 'Primary Color';

  @override
  String get accentColorLabel => 'Accent Color';

  @override
  String get bothColorLabel => 'Primary and Accent Colors';

  @override
  String get customColorLabel => 'Custom';

  @override
  String get wheelColorLabel => 'Wheel';

  @override
  String get codePreviewSettings => 'Code Preview Settings';
}
