// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'BiggerTask';

  @override
  String get search => 'Suchen';

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
  String get topics => 'Themen';

  @override
  String get users => 'Benutzer';

  @override
  String get stars => 'Sterne';

  @override
  String get forks => 'Forks';

  @override
  String get release => 'Versionen';

  @override
  String get userInfo => 'Benutzerinfo';

  @override
  String get contributors => 'Mitwirkende';

  @override
  String get starRepositories => 'Markierte Repositories';

  @override
  String get public => 'Öffentlich';

  @override
  String get private => 'Privat';

  @override
  String get changes => 'ÄNDERUNGEN';

  @override
  String get details => 'DETAILS';

  @override
  String howManyFilesChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien geändert',
      one: '1 Datei geändert',
    );
    return '$_temp0';
  }

  @override
  String howManyAdditions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Hinzufügungen',
      one: '1 Hinzufügung',
    );
    return '$_temp0';
  }

  @override
  String howManyDeletions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Löschungen',
      one: '1 Löschung',
    );
    return '$_temp0';
  }

  @override
  String get followers => 'Follower';

  @override
  String get followings => 'Folgt';

  @override
  String followersCount(int followers) {
    String _temp0 = intl.Intl.pluralLogic(
      followers,
      locale: localeName,
      other: '$followers Follower',
      one: '1 Follower',
    );
    return '$_temp0';
  }

  @override
  String followingCount(int followings) {
    String _temp0 = intl.Intl.pluralLogic(
      followings,
      locale: localeName,
      other: 'Folgt $followings',
      one: 'Folgt 1',
    );
    return '$_temp0';
  }

  @override
  String get organizations => 'Organisationen';

  @override
  String get members => 'Mitglieder';

  @override
  String memberCount(int members) {
    String _temp0 = intl.Intl.pluralLogic(
      members,
      locale: localeName,
      other: '$members Mitglieder',
      one: '1 Mitglied',
    );
    return '$_temp0';
  }

  @override
  String get noMore => 'Keine weiteren Daten';

  @override
  String get settings => 'Einstellungen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'OK';

  @override
  String get login => 'Anmelden';

  @override
  String loginFailed(Object error) {
    return 'Anmeldung fehlgeschlagen: $error';
  }

  @override
  String loginError(Object error) {
    return 'Anmeldefehler aufgetreten: $error';
  }

  @override
  String get noLogin => 'Nicht angemeldet';

  @override
  String get exit => 'Abmelden';

  @override
  String get exitTitle => 'Abmelden';

  @override
  String get exitMessage => 'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String forkedFrom(String parentName) {
    return 'Geforkt von $parentName';
  }

  @override
  String get star => 'Markieren';

  @override
  String get unStar => 'Markierung entfernen';

  @override
  String get unStarMessage =>
      'Sind Sie sicher, dass Sie die Markierung dieses Repositories entfernen möchten?';

  @override
  String get starMessage =>
      'Sind Sie sicher, dass Sie dieses Repository markieren möchten?';

  @override
  String whose(String who) {
    return '${who}s';
  }

  @override
  String searchForSomething(String what) {
    return 'Nach $what suchen';
  }

  @override
  String get gitHubLogin => 'GitHub-Anmeldung';

  @override
  String get noBio => 'Keine Biografie vorhanden';

  @override
  String get loading => 'Lädt...';

  @override
  String get loadFailed => 'Laden fehlgeschlagen';

  @override
  String get savedSuccessfully => 'Erfolgreich gespeichert!';

  @override
  String get copiedSuccessfully => 'Erfolgreich kopiert!';

  @override
  String get noEventText => 'Keine Ereignisse gefunden';

  @override
  String get notLoginEventText =>
      'Ereignisse werden nach der Anmeldung angezeigt';

  @override
  String get theme => 'Design';

  @override
  String get previousPage => 'Vorherige Seite';

  @override
  String get nextPage => 'Nächste Seite';

  @override
  String get noReadme => 'Keine README-Datei gefunden';

  @override
  String get readmeLoadFailed => 'Laden der README fehlgeschlagen';

  @override
  String get noDescription => 'Keine Beschreibung vorhanden';

  @override
  String get noMoreRepos => 'Keine weiteren Repositories';

  @override
  String get noReleases => 'Keine Versionen gefunden';

  @override
  String get unNamed => 'Unbenannt';

  @override
  String get repoNoExistOrPrivate =>
      'Dieses Repository existiert nicht oder ist privat';

  @override
  String get cannotSaveImageWithNoPermissionToGallery =>
      'Berechtigung für Galerie-Zugriff erforderlich, um Bilder zu speichern';

  @override
  String get saveImage => 'Bild speichern';

  @override
  String get savingImage => 'Bild wird gespeichert...';

  @override
  String get imageSaved => 'Bild in Galerie gespeichert';

  @override
  String get imageSaveFailed => 'Speichern des Bildes fehlgeschlagen';

  @override
  String get forkARepository => 'Repository geforkt';

  @override
  String get starARepository => 'Repository markiert';

  @override
  String get createARepository => 'Repository erstellt';

  @override
  String get createABranch => 'Branch erstellt';

  @override
  String get createATag => 'Tag erstellt';

  @override
  String get deleteABranch => 'Branch gelöscht';

  @override
  String get deleteATag => 'Tag gelöscht';

  @override
  String get releaseANewVersion => 'Neue Version veröffentlicht';

  @override
  String get written => 'Geschrieben am';

  @override
  String get now => 'Gerade eben';

  @override
  String minuteAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'vor $minutes Minuten',
      one: 'vor 1 Minute',
    );
    return '$_temp0';
  }

  @override
  String hourAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'vor $hours Stunden',
      one: 'vor 1 Stunde',
    );
    return '$_temp0';
  }

  @override
  String dayAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'vor $days Tagen',
      one: 'vor 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String monthAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'vor $months Monaten',
      one: 'vor 1 Monat',
    );
    return '$_temp0';
  }

  @override
  String yearAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: 'vor $years Jahren',
      one: 'vor 1 Jahr',
    );
    return '$_temp0';
  }

  @override
  String get bottomNavigationExplore => 'Entdecken';

  @override
  String get bottomNavigationMine => 'Profil';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get languageChinese => 'Chinesisch';

  @override
  String get languageChineseMicrosoft => 'Chinesisch (Microsoft)';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageRussian => 'Russisch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get choosePrimaryColor => 'Primärfarbe wählen';

  @override
  String get chooseSecondaryColor => 'Akzentfarbe wählen';

  @override
  String get chooseSurfaceColor => 'Oberflächenfarbe wählen';

  @override
  String get chooseErrorColor => 'Fehlerfarbe wählen';

  @override
  String get chooseOnPrimaryColor => 'Textfarbe auf Primärfarbe';

  @override
  String get chooseOnSecondaryColor => 'Textfarbe auf Akzentfarbe';

  @override
  String get chooseOnSurfaceColor => 'Textfarbe auf Oberflächenfarbe';

  @override
  String get chooseOnErrorColor => 'Textfarbe auf Fehlerfarbe';

  @override
  String get colorShade => 'Farbton';

  @override
  String get opacity => 'Deckkraft';

  @override
  String get saveChangesOfTheme => 'Design-Änderungen speichern';

  @override
  String get unSavedThemeChangesTitle => 'Nicht gespeicherte Änderungen';

  @override
  String get unSavedThemeChangesMessage =>
      'Sie haben nicht gespeicherte Änderungen. Möchten Sie beenden ohne zu speichern?';

  @override
  String get cannotDeleteLastTheme =>
      'Mindestens ein Design muss behalten werden';

  @override
  String get longPressToDeleteTheme => 'Lange drücken, um Design zu löschen';

  @override
  String get advancedThemeSettings => 'Erweiterte Design-Einstellungen';

  @override
  String get autoSelectOtherColors => 'Andere Farben automatisch festlegen';

  @override
  String get autoSelectTextColors => 'Textfarben automatisch festlegen';

  @override
  String get enableDarkMode => 'Dunkler Modus';

  @override
  String get primaryColorLabel => 'Primärfarbe';

  @override
  String get accentColorLabel => 'Akzentfarbe';

  @override
  String get bothColorLabel => 'Primär- und Akzentfarben';

  @override
  String get customColorLabel => 'Benutzerdefiniert';

  @override
  String get wheelColorLabel => 'Rad';

  @override
  String get codePreviewSettings => 'Code-Vorschau-Einstellungen';

  @override
  String get showLineNumber => 'Zeilennummern anzeigen';

  @override
  String get lineWrap => 'Zeilenumbruch';
}
