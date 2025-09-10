// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'BiggerTask';

  @override
  String get search => 'Rechercher';

  @override
  String get repositories => 'Dépôts';

  @override
  String get commit => 'Commit';

  @override
  String get commits => 'Commits';

  @override
  String get issue => 'Issue';

  @override
  String get issues => 'Problèmes';

  @override
  String get pullRequests => 'Demandes de tirage';

  @override
  String get code => 'Code';

  @override
  String get topics => 'Sujets';

  @override
  String get users => 'Utilisateurs';

  @override
  String get stars => 'Étoiles';

  @override
  String get forks => 'Forks';

  @override
  String get release => 'Versions';

  @override
  String get userInfo => 'Infos utilisateur';

  @override
  String get contributors => 'Contributeurs';

  @override
  String get starRepositories => 'Dépôts étoilés';

  @override
  String get public => 'Public';

  @override
  String get private => 'Privé';

  @override
  String get changes => 'CHANGEMENTS';

  @override
  String get details => 'DÉTAILS';

  @override
  String get parents => 'Parents';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String howManyFilesChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers modifiés',
      one: '1 fichier modifié',
    );
    return '$_temp0';
  }

  @override
  String howManyAdditions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ajouts',
      one: '1 ajout',
    );
    return '$_temp0';
  }

  @override
  String howManyDeletions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count suppressions',
      one: '1 suppression',
    );
    return '$_temp0';
  }

  @override
  String get followers => 'Abonnés';

  @override
  String get followings => 'Abonnements';

  @override
  String followersCount(int followers) {
    String _temp0 = intl.Intl.pluralLogic(
      followers,
      locale: localeName,
      other: '$followers abonnés',
      one: '1 abonné',
    );
    return '$_temp0';
  }

  @override
  String followingCount(int followings) {
    String _temp0 = intl.Intl.pluralLogic(
      followings,
      locale: localeName,
      other: '$followings abonnements',
      one: '1 abonnement',
    );
    return '$_temp0';
  }

  @override
  String get organizations => 'Organisations';

  @override
  String get members => 'Membres';

  @override
  String memberCount(int members) {
    String _temp0 = intl.Intl.pluralLogic(
      members,
      locale: localeName,
      other: '$members membres',
      one: '1 membre',
    );
    return '$_temp0';
  }

  @override
  String get noMore => 'Plus de données';

  @override
  String get settings => 'Paramètres';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'OK';

  @override
  String get login => 'Connexion';

  @override
  String loginFailed(Object error) {
    return 'Échec de la connexion : $error';
  }

  @override
  String loginError(Object error) {
    return 'Erreur de connexion : $error';
  }

  @override
  String get noLogin => 'Non connecté';

  @override
  String get exit => 'Se déconnecter';

  @override
  String get exitTitle => 'Se déconnecter';

  @override
  String get exitMessage => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String forkedFrom(String parentName) {
    return 'Forké depuis $parentName';
  }

  @override
  String get star => 'Étoiler';

  @override
  String get unStar => 'Retirer l\'étoile';

  @override
  String get unStarMessage =>
      'Êtes-vous sûr de vouloir retirer l\'étoile de ce dépôt ?';

  @override
  String get starMessage => 'Êtes-vous sûr de vouloir étoiler ce dépôt ?';

  @override
  String whose(String who) {
    return 'de $who';
  }

  @override
  String searchForSomething(String what) {
    return 'Rechercher $what';
  }

  @override
  String get gitHubLogin => 'Connexion GitHub';

  @override
  String get noBio => 'Aucune bio fournie';

  @override
  String get loading => 'Chargement...';

  @override
  String get loadFailed => 'Échec du chargement';

  @override
  String get savedSuccessfully => 'Enregistré avec succès !';

  @override
  String get copiedSuccessfully => 'Copié avec succès !';

  @override
  String get noEventText => 'Aucun événement trouvé';

  @override
  String get notLoginEventText =>
      'Les événements s\'afficheront après la connexion';

  @override
  String get theme => 'Thème';

  @override
  String get previousPage => 'Page précédente';

  @override
  String get nextPage => 'Page suivante';

  @override
  String get noReadme => 'Aucun fichier README trouvé';

  @override
  String get readmeLoadFailed => 'Échec du chargement du README';

  @override
  String get noDescription => 'Aucune description fournie';

  @override
  String get noMoreRepos => 'Plus de dépôts';

  @override
  String get noReleases => 'Aucune version trouvée';

  @override
  String get unNamed => 'Sans nom';

  @override
  String get repoNoExistOrPrivate => 'Ce dépôt n\'existe pas ou est privé';

  @override
  String get cannotSaveImageWithNoPermissionToGallery =>
      'Permission d\'accès à la galerie requise pour sauvegarder les images';

  @override
  String get saveImage => 'Sauvegarder l\'image';

  @override
  String get savingImage => 'Sauvegarde de l\'image...';

  @override
  String get imageSaved => 'Image sauvegardée dans la galerie';

  @override
  String get imageSaveFailed => 'Échec de la sauvegarde de l\'image';

  @override
  String get forkARepository => 'A forké un dépôt';

  @override
  String get starARepository => 'A étoilé un dépôt';

  @override
  String get createARepository => 'A créé un dépôt';

  @override
  String get createABranch => 'A créé une branche';

  @override
  String get createATag => 'A créé un tag';

  @override
  String get deleteABranch => 'A supprimé une branche';

  @override
  String get deleteATag => 'A supprimé un tag';

  @override
  String get releaseANewVersion => 'A publié une nouvelle version';

  @override
  String get written => 'Écrit le';

  @override
  String get now => 'À l\'instant';

  @override
  String minuteAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'Il y a $minutes minutes',
      one: 'Il y a 1 minute',
    );
    return '$_temp0';
  }

  @override
  String hourAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Il y a $hours heures',
      one: 'Il y a 1 heure',
    );
    return '$_temp0';
  }

  @override
  String dayAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Il y a $days jours',
      one: 'Il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String monthAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Il y a $months mois',
      one: 'Il y a 1 mois',
    );
    return '$_temp0';
  }

  @override
  String yearAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: 'Il y a $years ans',
      one: 'Il y a 1 an',
    );
    return '$_temp0';
  }

  @override
  String get bottomNavigationExplore => 'Explorer';

  @override
  String get bottomNavigationMine => 'Profil';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Par défaut du système';

  @override
  String get languageChinese => 'Chinois';

  @override
  String get languageChineseMicrosoft => 'Chinois (Microsoft)';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get choosePrimaryColor => 'Choisir la couleur principale';

  @override
  String get chooseSecondaryColor => 'Choisir la couleur d\'accentuation';

  @override
  String get chooseSurfaceColor => 'Choisir la couleur de surface';

  @override
  String get chooseErrorColor => 'Choisir la couleur d\'erreur';

  @override
  String get chooseOnPrimaryColor => 'Couleur du texte sur couleur principale';

  @override
  String get chooseOnSecondaryColor =>
      'Couleur du texte sur couleur d\'accentuation';

  @override
  String get chooseOnSurfaceColor => 'Couleur du texte sur couleur de surface';

  @override
  String get chooseOnErrorColor => 'Couleur du texte sur couleur d\'erreur';

  @override
  String get colorShade => 'Nuance de couleur';

  @override
  String get opacity => 'Opacité';

  @override
  String get saveChangesOfTheme => 'Sauvegarder les modifications du thème';

  @override
  String get unSavedThemeChangesTitle => 'Modifications non sauvegardées';

  @override
  String get unSavedThemeChangesMessage =>
      'Vous avez des modifications non sauvegardées. Voulez-vous quitter sans sauvegarder ?';

  @override
  String get cannotDeleteLastTheme => 'Au moins un thème doit être conservé';

  @override
  String get longPressToDeleteTheme => 'Appui long pour supprimer le thème';

  @override
  String get advancedThemeSettings => 'Paramètres de thème avancés';

  @override
  String get autoSelectOtherColors =>
      'Définir automatiquement les autres couleurs';

  @override
  String get autoSelectTextColors =>
      'Définir automatiquement les couleurs de texte';

  @override
  String get enableDarkMode => 'Mode sombre';

  @override
  String get primaryColorLabel => 'Couleur principale';

  @override
  String get accentColorLabel => 'Couleur d\'accentuation';

  @override
  String get bothColorLabel => 'Couleurs principale et d\'accentuation';

  @override
  String get customColorLabel => 'Personnalisé';

  @override
  String get wheelColorLabel => 'Roue';

  @override
  String get codePreviewSettings => 'Paramètres d\'aperçu du code';

  @override
  String get preview => 'Preview';

  @override
  String get showLineNumber => 'Afficher les numéros de ligne';

  @override
  String get lineWrap => 'Retour à la ligne';
}
