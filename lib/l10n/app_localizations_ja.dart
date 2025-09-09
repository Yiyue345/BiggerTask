// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'BiggerTask';

  @override
  String get search => '検索';

  @override
  String get repositories => 'リポジトリ';

  @override
  String get commits => 'コミット';

  @override
  String get issues => 'イシュー';

  @override
  String get pullRequests => 'プルリクエスト';

  @override
  String get code => 'コード';

  @override
  String get topics => 'トピック';

  @override
  String get users => 'ユーザー';

  @override
  String get stars => 'スター';

  @override
  String get forks => 'フォーク';

  @override
  String get release => 'リリース';

  @override
  String get userInfo => 'ユーザー情報';

  @override
  String get contributors => 'コントリビューター';

  @override
  String get starRepositories => 'スター付きリポジトリ';

  @override
  String get public => 'パブリック';

  @override
  String get private => 'プライベート';

  @override
  String get changes => '変更';

  @override
  String get details => '詳細';

  @override
  String howManyFilesChanged(int count) {
    return '$count個のファイルが変更されました';
  }

  @override
  String howManyAdditions(num count) {
    return '$count個の追加';
  }

  @override
  String howManyDeletions(num count) {
    return '$count個の削除';
  }

  @override
  String get followers => 'フォロワー';

  @override
  String get followings => 'フォロー中';

  @override
  String followersCount(int followers) {
    return '$followers人のフォロワー';
  }

  @override
  String followingCount(int followings) {
    return '$followings人をフォロー中';
  }

  @override
  String get organizations => '組織';

  @override
  String get members => 'メンバー';

  @override
  String memberCount(int members) {
    return '$members人のメンバー';
  }

  @override
  String get noMore => 'これ以上データはありません';

  @override
  String get settings => '設定';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => 'OK';

  @override
  String get login => 'ログイン';

  @override
  String loginFailed(Object error) {
    return 'ログ��ンに失敗しました：$error';
  }

  @override
  String loginError(Object error) {
    return 'ログインエラーが発生しました：$error';
  }

  @override
  String get noLogin => 'ログインしていません';

  @override
  String get exit => 'サインアウト';

  @override
  String get exitTitle => 'サインアウト';

  @override
  String get exitMessage => '本当にサインアウトしますか？';

  @override
  String forkedFrom(String parentName) {
    return '$parentNameからフォーク';
  }

  @override
  String get star => 'スター';

  @override
  String get unStar => 'スターを外す';

  @override
  String get unStarMessage => 'このリポジトリのスターを外しますか？';

  @override
  String get starMessage => 'このリポジトリにスターを付けますか？';

  @override
  String whose(String who) {
    return '$whoの';
  }

  @override
  String searchForSomething(String what) {
    return '$whatを検索';
  }

  @override
  String get gitHubLogin => 'GitHubログイン';

  @override
  String get noBio => 'プロフィールがありません';

  @override
  String get loading => '読み込み中...';

  @override
  String get loadFailed => '読み込みに失敗しました';

  @override
  String get savedSuccessfully => '正常に保存されました！';

  @override
  String get copiedSuccessfully => '正常にコピーされました！';

  @override
  String get noEventText => 'イベントが見つかりません';

  @override
  String get notLoginEventText => 'ログインしていないため、イベントを表示できません';

  @override
  String get theme => 'テーマ';

  @override
  String get previousPage => '前のページ';

  @override
  String get nextPage => '次のページ';

  @override
  String get noReadme => 'READMEファイルが見つかりません';

  @override
  String get readmeLoadFailed => 'READMEの読み込みに失敗しました';

  @override
  String get noDescription => '説明がありません';

  @override
  String get noMoreRepos => 'これ以上リポジトリはありません';

  @override
  String get noReleases => 'リリースが見つかりません';

  @override
  String get unNamed => '名前なし';

  @override
  String get repoNoExistOrPrivate => 'このリポジトリは存在しないかプライベートです';

  @override
  String get cannotSaveImageWithNoPermissionToGallery =>
      '画像を保存するにはギャラリーへのアクセス許可が必要です';

  @override
  String get saveImage => '画像を保存';

  @override
  String get savingImage => '画像を保存中...';

  @override
  String get imageSaved => '画像をギャラリーに保存しました';

  @override
  String get imageSaveFailed => '画像の保存に失敗しました';

  @override
  String get forkARepository => 'リポジトリをフォークしました';

  @override
  String get starARepository => 'リポジトリにスターを付けました';

  @override
  String get createARepository => 'リポジトリを作成しました';

  @override
  String get createABranch => 'ブランチを作成しました';

  @override
  String get createATag => 'タグを作成しました';

  @override
  String get deleteABranch => 'ブランチを削除しました';

  @override
  String get deleteATag => 'タグを削除しました';

  @override
  String get releaseANewVersion => '新しいバージョンをリリースしました';

  @override
  String get written => '書かれた日時';

  @override
  String get now => 'たった今';

  @override
  String minuteAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String hourAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String dayAgo(int days) {
    return '$days日前';
  }

  @override
  String monthAgo(int months) {
    return '$monthsヶ月前';
  }

  @override
  String yearAgo(int years) {
    return '$years年前';
  }

  @override
  String get bottomNavigationExplore => '探索';

  @override
  String get bottomNavigationMine => 'プロフィール';

  @override
  String get language => '言語';

  @override
  String get languageSystem => 'システムデフォルト';

  @override
  String get languageChinese => '中国語';

  @override
  String get languageChineseMicrosoft => '中国語（マイクロソフト）';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageRussian => 'ロシア語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get choosePrimaryColor => 'プライマリカラーを選択';

  @override
  String get chooseSecondaryColor => 'アクセントカラーを選択';

  @override
  String get chooseSurfaceColor => 'サーフェスカラーを選択';

  @override
  String get chooseErrorColor => 'エラーカラーを選択';

  @override
  String get chooseOnPrimaryColor => 'プライマリカラー上のテキストカラー';

  @override
  String get chooseOnSecondaryColor => 'アクセントカラー上のテキストカラー';

  @override
  String get chooseOnSurfaceColor => 'サーフェスカラー上のテキストカラー';

  @override
  String get chooseOnErrorColor => 'エラーカラー上のテキストカラー';

  @override
  String get colorShade => 'カラーシェード';

  @override
  String get opacity => '不透明度';

  @override
  String get saveChangesOfTheme => 'テーマの変更を保存';

  @override
  String get unSavedThemeChangesTitle => '未保存の変更';

  @override
  String get unSavedThemeChangesMessage => '未保存の変更があります。保存せずに終了しますか？';

  @override
  String get cannotDeleteLastTheme => '最低1つのテーマを残しておく必要があります';

  @override
  String get longPressToDeleteTheme => '長押しでテーマを削除';

  @override
  String get advancedThemeSettings => '高度なテーマ設定';

  @override
  String get autoSelectOtherColors => '他の色を自動設定';

  @override
  String get autoSelectTextColors => 'テキストカラーを自動設定';

  @override
  String get enableDarkMode => 'ダークモード';

  @override
  String get primaryColorLabel => 'プライマリカラー';

  @override
  String get accentColorLabel => 'アクセントカラー';

  @override
  String get bothColorLabel => 'プライマリとアクセントカラー';

  @override
  String get customColorLabel => 'カスタム';

  @override
  String get wheelColorLabel => 'ホイール';

  @override
  String get codePreviewSettings => 'コードプレビュー設定';

  @override
  String get showLineNumber => '行番号を表示';

  @override
  String get lineWrap => '行の折り返し';
}
