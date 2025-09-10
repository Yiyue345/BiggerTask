// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'BiggerTask';

  @override
  String get search => 'Поиск';

  @override
  String get repositories => 'Репозитории';

  @override
  String get commit => 'Commit';

  @override
  String get commits => 'Коммиты';

  @override
  String get issue => 'Issue';

  @override
  String get issues => 'Задачи';

  @override
  String get pullRequests => 'Pull Request\'ы';

  @override
  String get code => 'Код';

  @override
  String get topics => 'Темы';

  @override
  String get users => 'Пользователи';

  @override
  String get stars => 'Звёзды';

  @override
  String get forks => 'Форки';

  @override
  String get release => 'Релизы';

  @override
  String get userInfo => 'Информация о пользователе';

  @override
  String get contributors => 'Участники';

  @override
  String get starRepositories => 'Помеченные репозитории';

  @override
  String get public => 'Публичный';

  @override
  String get private => 'Приватный';

  @override
  String get changes => 'ИЗМЕНЕНИЯ';

  @override
  String get details => 'ДЕТАЛИ';

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
      other: '$count файлов изменено',
      few: '$count файла изменено',
      one: '1 файл изменён',
    );
    return '$_temp0';
  }

  @override
  String howManyAdditions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count добавлений',
      few: '$count добавления',
      one: '1 добавление',
    );
    return '$_temp0';
  }

  @override
  String howManyDeletions(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count удалений',
      few: '$count удаления',
      one: '1 удаление',
    );
    return '$_temp0';
  }

  @override
  String get followers => 'Подписчики';

  @override
  String get followings => 'Подписки';

  @override
  String followersCount(int followers) {
    String _temp0 = intl.Intl.pluralLogic(
      followers,
      locale: localeName,
      other: '$followers подписчиков',
      few: '$followers подписчика',
      one: '1 подписчик',
    );
    return '$_temp0';
  }

  @override
  String followingCount(int followings) {
    String _temp0 = intl.Intl.pluralLogic(
      followings,
      locale: localeName,
      other: '$followings подписок',
      few: '$followings подписки',
      one: '1 подписка',
    );
    return '$_temp0';
  }

  @override
  String get organizations => 'Организации';

  @override
  String get members => 'Участники';

  @override
  String memberCount(int members) {
    String _temp0 = intl.Intl.pluralLogic(
      members,
      locale: localeName,
      other: '$members участников',
      few: '$members участника',
      one: '1 участник',
    );
    return '$_temp0';
  }

  @override
  String get noMore => 'Больше нет данных';

  @override
  String get settings => 'Настройки';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'ОК';

  @override
  String get login => 'Войти';

  @override
  String loginFailed(Object error) {
    return 'Ошибка входа: $error';
  }

  @override
  String loginError(Object error) {
    return 'Произошла ошибка входа: $error';
  }

  @override
  String get noLogin => 'Не авторизован';

  @override
  String get exit => 'Выйти';

  @override
  String get exitTitle => 'Выйти';

  @override
  String get exitMessage => 'Вы уверены, что хотите выйти?';

  @override
  String forkedFrom(String parentName) {
    return 'Форк от $parentName';
  }

  @override
  String get star => 'Отметить';

  @override
  String get unStar => 'Убрать отметку';

  @override
  String get unStarMessage =>
      'Вы уверены, что хотите убрать отметку с этого репозитория?';

  @override
  String get starMessage => 'Вы уверены, что хотите отметить этот репозиторий?';

  @override
  String whose(String who) {
    return '$who';
  }

  @override
  String searchForSomething(String what) {
    return 'Поиск $what';
  }

  @override
  String get gitHubLogin => 'Вход в GitHub';

  @override
  String get noBio => 'Биография отсутствует';

  @override
  String get loading => 'Загрузка...';

  @override
  String get loadFailed => 'Ошибка загрузки';

  @override
  String get savedSuccessfully => 'Успешно сохранено!';

  @override
  String get copiedSuccessfully => 'Успешно скопировано!';

  @override
  String get noEventText => 'События не найдены';

  @override
  String get notLoginEventText =>
      'События не отображаются, так как вы не вошли в систему';

  @override
  String get theme => 'Тема';

  @override
  String get previousPage => 'Предыдущая страница';

  @override
  String get nextPage => 'Следующая страница';

  @override
  String get noReadme => 'Файл README не найден';

  @override
  String get readmeLoadFailed => 'Не удалось загрузить README';

  @override
  String get noDescription => 'Описание отсутствует';

  @override
  String get noMoreRepos => 'Больше нет репозиториев';

  @override
  String get noReleases => 'Релизы не найдены';

  @override
  String get unNamed => 'Без названия';

  @override
  String get repoNoExistOrPrivate =>
      'Этот репозиторий не существует или является приватным';

  @override
  String get cannotSaveImageWithNoPermissionToGallery =>
      'Требуется разрешение доступа к галерее для сохранения изображений';

  @override
  String get saveImage => 'Сохранить изображение';

  @override
  String get savingImage => 'Сохранение изображения...';

  @override
  String get imageSaved => 'Изображение сохранено в галерею';

  @override
  String get imageSaveFailed => 'Не удалось сохранить изображение';

  @override
  String get forkARepository => 'Сделал форк репозитория';

  @override
  String get starARepository => 'Отметил репозиторий';

  @override
  String get createARepository => 'Создал репозиторий';

  @override
  String get createABranch => 'Создал ветку';

  @override
  String get createATag => 'Создал тег';

  @override
  String get deleteABranch => 'Удалил ветку';

  @override
  String get deleteATag => 'Удалил тег';

  @override
  String get releaseANewVersion => 'Выпустил новую версию';

  @override
  String get written => 'Написано';

  @override
  String get now => 'Только что';

  @override
  String minuteAgo(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutes минут назад',
      few: '$minutes минуты назад',
      one: '1 минуту назад',
    );
    return '$_temp0';
  }

  @override
  String hourAgo(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours часов назад',
      few: '$hours часа назад',
      one: '1 час назад',
    );
    return '$_temp0';
  }

  @override
  String dayAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дней назад',
      few: '$days дня назад',
      one: '1 день назад',
    );
    return '$_temp0';
  }

  @override
  String monthAgo(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months месяцев назад',
      few: '$months месяца назад',
      one: '1 месяц назад',
    );
    return '$_temp0';
  }

  @override
  String yearAgo(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years лет назад',
      few: '$years года назад',
      one: '1 год назад',
    );
    return '$_temp0';
  }

  @override
  String get bottomNavigationExplore => 'Обзор';

  @override
  String get bottomNavigationMine => 'Профиль';

  @override
  String get language => 'Язык';

  @override
  String get languageSystem => 'Системный по умолчанию';

  @override
  String get languageChinese => 'Китайский';

  @override
  String get languageChineseMicrosoft => 'Китайский (Microsoft)';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageFrench => 'Французский';

  @override
  String get languageGerman => 'Немецкий';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageJapanese => 'Японский';

  @override
  String get choosePrimaryColor => 'Выбрать основной цвет';

  @override
  String get chooseSecondaryColor => 'Выбрать акцентный цвет';

  @override
  String get chooseSurfaceColor => 'Выбрать цвет поверхности';

  @override
  String get chooseErrorColor => 'Выбрать цвет ошибки';

  @override
  String get chooseOnPrimaryColor => 'Цвет текста на основном цвете';

  @override
  String get chooseOnSecondaryColor => 'Цвет текста на акцентном цвете';

  @override
  String get chooseOnSurfaceColor => 'Цвет текста на поверхности';

  @override
  String get chooseOnErrorColor => 'Цвет текста на цвете ошибки';

  @override
  String get colorShade => 'Оттенок цвета';

  @override
  String get opacity => 'Непрозрачность';

  @override
  String get saveChangesOfTheme => 'Сохранить изменения темы';

  @override
  String get unSavedThemeChangesTitle => 'Несохранённые изменения';

  @override
  String get unSavedThemeChangesMessage =>
      'У вас есть несохранённые изменения. Хотите выйти без сохранения?';

  @override
  String get cannotDeleteLastTheme => 'Должна остаться хотя бы одна тема';

  @override
  String get longPressToDeleteTheme => 'Длительное нажатие для удаления темы';

  @override
  String get advancedThemeSettings => 'Расширенные настройки темы';

  @override
  String get autoSelectOtherColors => 'Автоматически установить другие цвета';

  @override
  String get autoSelectTextColors => 'Автоматически установить цвета текста';

  @override
  String get enableDarkMode => 'Тёмная тема';

  @override
  String get primaryColorLabel => 'Основной цвет';

  @override
  String get accentColorLabel => 'Акцентный цвет';

  @override
  String get bothColorLabel => 'Основной и акцентный цвета';

  @override
  String get customColorLabel => 'Пользовательский';

  @override
  String get wheelColorLabel => 'Колесо';

  @override
  String get codePreviewSettings => 'Настройки предпросмотра кода';

  @override
  String get preview => 'Preview';

  @override
  String get showLineNumber => 'Показать номера строк';

  @override
  String get lineWrap => 'Перенос строк';
}
