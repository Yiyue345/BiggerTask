import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'MS'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'BiggerTask'**
  String get appTitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @repositories.
  ///
  /// In en, this message translates to:
  /// **'Repositories'**
  String get repositories;

  /// No description provided for @commits.
  ///
  /// In en, this message translates to:
  /// **'Commits'**
  String get commits;

  /// No description provided for @issues.
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get issues;

  /// No description provided for @pullRequests.
  ///
  /// In en, this message translates to:
  /// **'Pull Requests'**
  String get pullRequests;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @stars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get stars;

  /// No description provided for @forks.
  ///
  /// In en, this message translates to:
  /// **'Forks'**
  String get forks;

  /// No description provided for @release.
  ///
  /// In en, this message translates to:
  /// **'Releases'**
  String get release;

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'User Info'**
  String get userInfo;

  /// No description provided for @starRepositories.
  ///
  /// In en, this message translates to:
  /// **'Starred Repositories'**
  String get starRepositories;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @followings.
  ///
  /// In en, this message translates to:
  /// **'Followings'**
  String get followings;

  /// Text showing the number of followers
  ///
  /// In en, this message translates to:
  /// **'{followers, plural, =1{1 follower} other{{followers} followers}}'**
  String followersCount(int followers);

  /// Text showing the number of followings
  ///
  /// In en, this message translates to:
  /// **'{followings, plural, =1{1 following} other{{followings} followings}}'**
  String followingCount(int followings);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get confirm;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {error}'**
  String loginFailed(Object error);

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login error occurred: {error}'**
  String loginError(Object error);

  /// No description provided for @noLogin.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get noLogin;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get exit;

  /// Title of the sign out confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get exitTitle;

  /// Message of the sign out confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get exitMessage;

  /// Text showing which repository this is forked from
  ///
  /// In en, this message translates to:
  /// **'Forked from {parentName}'**
  String forkedFrom(String parentName);

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @unStar.
  ///
  /// In en, this message translates to:
  /// **'Unstar'**
  String get unStar;

  /// No description provided for @unStarMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unstar this repository?'**
  String get unStarMessage;

  /// No description provided for @starMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to star this repository?'**
  String get starMessage;

  /// Text showing whose name it is
  ///
  /// In en, this message translates to:
  /// **'{who}\'s'**
  String whose(String who);

  /// Text shown in the search bar when searching for something
  ///
  /// In en, this message translates to:
  /// **'Search for {what}'**
  String searchForSomething(String what);

  /// No description provided for @gitHubLogin.
  ///
  /// In en, this message translates to:
  /// **'GitHub Login'**
  String get gitHubLogin;

  /// No description provided for @noBio.
  ///
  /// In en, this message translates to:
  /// **'No bio provided'**
  String get noBio;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailed;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully!'**
  String get savedSuccessfully;

  /// Text shown when there are no events to display on home page
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventText;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous Page'**
  String get previousPage;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next Page'**
  String get nextPage;

  /// No description provided for @noReadme.
  ///
  /// In en, this message translates to:
  /// **'No README file found'**
  String get noReadme;

  /// No description provided for @readmeLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load README'**
  String get readmeLoadFailed;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description provided'**
  String get noDescription;

  /// No description provided for @noMoreRepos.
  ///
  /// In en, this message translates to:
  /// **'No more repositories'**
  String get noMoreRepos;

  /// No description provided for @noReleases.
  ///
  /// In en, this message translates to:
  /// **'No releases found'**
  String get noReleases;

  /// No description provided for @unNamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unNamed;

  /// No description provided for @repoNoExistOrPrivate.
  ///
  /// In en, this message translates to:
  /// **'This repository does not exist or is private'**
  String get repoNoExistOrPrivate;

  /// Text showing that a repository was forked
  ///
  /// In en, this message translates to:
  /// **'Forked a repository'**
  String get forkARepository;

  /// Text showing that a repository was starred
  ///
  /// In en, this message translates to:
  /// **'Starred a repository'**
  String get starARepository;

  /// Text showing that a repository was created
  ///
  /// In en, this message translates to:
  /// **'Created a repository'**
  String get createARepository;

  /// Text showing that a branch was created
  ///
  /// In en, this message translates to:
  /// **'Created a branch'**
  String get createABranch;

  /// Text showing that a tag was created
  ///
  /// In en, this message translates to:
  /// **'Created a tag'**
  String get createATag;

  /// Text showing that a branch was deleted
  ///
  /// In en, this message translates to:
  /// **'Deleted a branch'**
  String get deleteABranch;

  /// Text showing that a tag was deleted
  ///
  /// In en, this message translates to:
  /// **'Deleted a tag'**
  String get deleteATag;

  /// Text showing that a new version was released
  ///
  /// In en, this message translates to:
  /// **'Released a new version'**
  String get releaseANewVersion;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get now;

  /// Text showing how long ago something happened in minutes
  ///
  /// In en, this message translates to:
  /// **'{minutes, plural, =1{1 minute ago} other{{minutes} minutes ago}}'**
  String minuteAgo(int minutes);

  /// Text showing how long ago something happened in hours
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =1{1 hour ago} other{{hours} hours ago}}'**
  String hourAgo(int hours);

  /// Text showing how long ago something happened in days
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{1 day ago} other{{days} days ago}}'**
  String dayAgo(int days);

  /// Text showing how long ago something happened in months
  ///
  /// In en, this message translates to:
  /// **'{months, plural, =1{1 month ago} other{{months} months ago}}'**
  String monthAgo(int months);

  /// Text showing how long ago something happened in years
  ///
  /// In en, this message translates to:
  /// **'{years, plural, =1{1 year ago} other{{years} years ago}}'**
  String yearAgo(int years);

  /// No description provided for @bottomNavigationExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get bottomNavigationExplore;

  /// No description provided for @bottomNavigationMine.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavigationMine;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language option to follow the system language
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get languageSystem;

  /// Language option for Chinese
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @languageChineseMicrosoft.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Microsoft)'**
  String get languageChineseMicrosoft;

  /// Language option for English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @choosePrimaryColor.
  ///
  /// In en, this message translates to:
  /// **'Choose Primary Color'**
  String get choosePrimaryColor;

  /// Prompt to choose the accent color used in the app
  ///
  /// In en, this message translates to:
  /// **'Choose Accent Color'**
  String get chooseSecondaryColor;

  /// No description provided for @chooseSurfaceColor.
  ///
  /// In en, this message translates to:
  /// **'Choose Surface Color'**
  String get chooseSurfaceColor;

  /// Prompt to choose the color used for error messages
  ///
  /// In en, this message translates to:
  /// **'Choose Error Color'**
  String get chooseErrorColor;

  /// Prompt to choose the text color that appears on the primary color background
  ///
  /// In en, this message translates to:
  /// **'Text Color on Primary Color'**
  String get chooseOnPrimaryColor;

  /// No description provided for @chooseOnSecondaryColor.
  ///
  /// In en, this message translates to:
  /// **'Text Color on Accent Color'**
  String get chooseOnSecondaryColor;

  /// No description provided for @chooseOnSurfaceColor.
  ///
  /// In en, this message translates to:
  /// **'Text Color on Surface Color'**
  String get chooseOnSurfaceColor;

  /// No description provided for @chooseOnErrorColor.
  ///
  /// In en, this message translates to:
  /// **'Text Color on Error Color'**
  String get chooseOnErrorColor;

  /// No description provided for @colorShade.
  ///
  /// In en, this message translates to:
  /// **'Color Shade'**
  String get colorShade;

  /// No description provided for @opacity.
  ///
  /// In en, this message translates to:
  /// **'Opacity'**
  String get opacity;

  /// No description provided for @saveChangesOfTheme.
  ///
  /// In en, this message translates to:
  /// **'Save Theme Changes'**
  String get saveChangesOfTheme;

  /// No description provided for @unSavedThemeChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unSavedThemeChangesTitle;

  /// Message of the dialog warning about unsaved theme changes
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to exit without saving?'**
  String get unSavedThemeChangesMessage;

  /// No description provided for @advancedThemeSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced Theme Settings'**
  String get advancedThemeSettings;

  /// No description provided for @autoSelectOtherColors.
  ///
  /// In en, this message translates to:
  /// **'Automatically set other colors'**
  String get autoSelectOtherColors;

  /// No description provided for @autoSelectTextColors.
  ///
  /// In en, this message translates to:
  /// **'Automatically set text colors'**
  String get autoSelectTextColors;

  /// No description provided for @enableDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get enableDarkMode;

  /// No description provided for @primaryColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColorLabel;

  /// No description provided for @accentColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accentColorLabel;

  /// Label for a color option that includes both primary and accent colors
  ///
  /// In en, this message translates to:
  /// **'Primary and Accent Colors'**
  String get bothColorLabel;

  /// No description provided for @customColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customColorLabel;

  /// No description provided for @wheelColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Wheel'**
  String get wheelColorLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'MS':
            return AppLocalizationsZhMs();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
