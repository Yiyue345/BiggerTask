// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '更大的任务';

  @override
  String get search => '搜索';

  @override
  String get repositories => '仓库';

  @override
  String get commits => '提交';

  @override
  String get issues => '议题';

  @override
  String get pullRequests => '拉取请求';

  @override
  String get code => '代码';

  @override
  String get users => '用户';

  @override
  String get stars => '标星';

  @override
  String get forks => '复刻';

  @override
  String get release => '发行版';

  @override
  String get followers => '粉丝';

  @override
  String get followings => '关注';

  @override
  String followersCount(int followers) {
    return '$followers 粉丝';
  }

  @override
  String followingCount(int followings) {
    return '$followings 关注';
  }

  @override
  String get settings => '设置';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确定';

  @override
  String get login => '登录';

  @override
  String loginFailed(Object error) {
    return '登录失败：$error';
  }

  @override
  String loginError(Object error) {
    return '登录过程出错：$error';
  }

  @override
  String get noLogin => '未登录';

  @override
  String get exit => '退出';

  @override
  String get exitTitle => '退出登录';

  @override
  String get exitMessage => '你真的要退出登录吗？';

  @override
  String forkedFrom(String parentName) {
    return '复刻自 $parentName';
  }

  @override
  String get star => '标星';

  @override
  String get unStar => '取消标星';

  @override
  String get unStarMessage => '确定取消标星该仓库吗？';

  @override
  String get starMessage => '确定标星该仓库吗？';

  @override
  String get loading => '加载中...';

  @override
  String get loadFailed => '加载失败';

  @override
  String get noEventText => '暂时还没有事件哦~';

  @override
  String get theme => '主题';

  @override
  String get previousPage => '上一页';

  @override
  String get nextPage => '下一页';

  @override
  String get noReadme => '该仓库没有 README 文件';

  @override
  String get readmeLoadFailed => 'README 加载失败';

  @override
  String get bottomNavigationExplore => '探索';

  @override
  String get bottomNavigationMine => '我的';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '跟随系统';

  @override
  String get languageChinese => '中文';

  @override
  String get languageEnglish => '英文';
}
