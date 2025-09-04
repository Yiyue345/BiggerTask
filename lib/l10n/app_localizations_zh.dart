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
  String get topics => '主题';

  @override
  String get users => '用户';

  @override
  String get stars => '标星';

  @override
  String get forks => '复刻';

  @override
  String get release => '发行版';

  @override
  String get userInfo => '用户信息';

  @override
  String get contributors => '贡献者';

  @override
  String get starRepositories => '标星仓库';

  @override
  String get public => '公共';

  @override
  String get private => '私人';

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
  String get organizations => '组织';

  @override
  String get members => '成员';

  @override
  String memberCount(int members) {
    return '$members 成员';
  }

  @override
  String get noMore => '没有更多数据了';

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
  String whose(String who) {
    return '$who 的';
  }

  @override
  String searchForSomething(String what) {
    return '搜索$what';
  }

  @override
  String get gitHubLogin => 'GitHub 登录';

  @override
  String get noBio => '无简介';

  @override
  String get loading => '加载中...';

  @override
  String get loadFailed => '加载失败';

  @override
  String get savedSuccessfully => '保存成功！';

  @override
  String get copiedSuccessfully => '复制成功！';

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
  String get noDescription => '该仓库没有描述';

  @override
  String get noMoreRepos => '没有更多仓库了';

  @override
  String get noReleases => '暂无发行版';

  @override
  String get unNamed => '未命名';

  @override
  String get repoNoExistOrPrivate => '该仓库不存在或不可见';

  @override
  String get cannotSaveImageWithNoPermissionToGallery => '需要相册权限才能保存图片';

  @override
  String get saveImage => '保存图片';

  @override
  String get savingImage => '正在保存图片...';

  @override
  String get imageSaved => '图片已保存到相册';

  @override
  String get imageSaveFailed => '图片保存失败';

  @override
  String get forkARepository => '复刻了一个仓库';

  @override
  String get starARepository => '标星了一个仓库';

  @override
  String get createARepository => '创建了一个仓库';

  @override
  String get createABranch => '创建了一个分支';

  @override
  String get createATag => '创建了一个标签';

  @override
  String get deleteABranch => '删除了一个分支';

  @override
  String get deleteATag => '删除了一个标签';

  @override
  String get releaseANewVersion => '发布了一个版本';

  @override
  String get now => '刚刚';

  @override
  String minuteAgo(int minutes) {
    return '$minutes 分钟前';
  }

  @override
  String hourAgo(int hours) {
    return '$hours 小时前';
  }

  @override
  String dayAgo(int days) {
    return '$days 天前';
  }

  @override
  String monthAgo(int months) {
    return '$months 个月前';
  }

  @override
  String yearAgo(int years) {
    return '$years 年前';
  }

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
  String get languageChineseMicrosoft => '中文（微软）';

  @override
  String get languageEnglish => '英文';

  @override
  String get choosePrimaryColor => '选择主色';

  @override
  String get chooseSecondaryColor => '选择强调色';

  @override
  String get chooseSurfaceColor => '选择背景色';

  @override
  String get chooseErrorColor => '选择错误提示颜色';

  @override
  String get chooseOnPrimaryColor => '主色之上的文字颜色';

  @override
  String get chooseOnSecondaryColor => '强调色之上的文字颜色';

  @override
  String get chooseOnSurfaceColor => '背景之上的文字颜色';

  @override
  String get chooseOnErrorColor => '错误色之上的文字颜色';

  @override
  String get colorShade => '颜色深浅';

  @override
  String get opacity => '不透明度';

  @override
  String get saveChangesOfTheme => '保存对当前主题的修改';

  @override
  String get unSavedThemeChangesTitle => '未保存的更改';

  @override
  String get unSavedThemeChangesMessage => '您有未保存的更改，确定要直接退出吗？';

  @override
  String get cannotDeleteLastTheme => '至少需要保留一个主题';

  @override
  String get longPressToDeleteTheme => '长按以删除主题';

  @override
  String get advancedThemeSettings => '高级主题设置';

  @override
  String get autoSelectOtherColors => '自动设置其他颜色';

  @override
  String get autoSelectTextColors => '自动设置文字颜色';

  @override
  String get enableDarkMode => '深色主题';

  @override
  String get primaryColorLabel => '主色';

  @override
  String get accentColorLabel => '强调色';

  @override
  String get bothColorLabel => '主色与强调色';

  @override
  String get customColorLabel => '自定义';

  @override
  String get wheelColorLabel => '色轮';

  @override
  String get codePreviewSettings => '代码预览设置';
}

/// The translations for Chinese, as used in Montserrat (`zh_MS`).
class AppLocalizationsZhMs extends AppLocalizationsZh {
  AppLocalizationsZhMs() : super('zh_MS');

  @override
  String get appTitle => '更加大的任务';

  @override
  String get search => '搜素';

  @override
  String get repositories => '仓库';

  @override
  String get commits => '承诺';

  @override
  String get issues => '问题';

  @override
  String get pullRequests => '请求拉';

  @override
  String get code => '代码';

  @override
  String get topics => '主题';

  @override
  String get users => '用户';

  @override
  String get stars => '星星';

  @override
  String get forks => '叉子';

  @override
  String get release => '释放';

  @override
  String get userInfo => '用户信息';

  @override
  String get contributors => '贡献者';

  @override
  String get starRepositories => '星星仓库';

  @override
  String get public => '公共';

  @override
  String get private => '私人';

  @override
  String get followers => '追随者';

  @override
  String get followings => '正在关注';

  @override
  String followersCount(int followers) {
    return '$followers 追随者';
  }

  @override
  String followingCount(int followings) {
    return '$followings 正在关注';
  }

  @override
  String get organizations => '组织';

  @override
  String get members => '成员';

  @override
  String memberCount(int members) {
    return '$members 成员';
  }

  @override
  String get noMore => '没有更多了';

  @override
  String get settings => '设定';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get login => '登录';

  @override
  String loginFailed(Object error) {
    return '登录已失败：$error';
  }

  @override
  String loginError(Object error) {
    return '登录错误：$error';
  }

  @override
  String get noLogin => '未登录';

  @override
  String get exit => '登出';

  @override
  String get exitTitle => '登出';

  @override
  String get exitMessage => '你真的打算登出吗？';

  @override
  String forkedFrom(String parentName) {
    return '叉自 $parentName';
  }

  @override
  String get star => '星';

  @override
  String get unStar => '联合国之星';

  @override
  String get unStarMessage => '您确定要取消此存储库的星标吗？';

  @override
  String get starMessage => '您确定要为该存储库加星标吗？';

  @override
  String whose(String who) {
    return '$who 的';
  }

  @override
  String searchForSomething(String what) {
    return '搜素$what';
  }

  @override
  String get gitHubLogin => 'GitHub 登录';

  @override
  String get noBio => '未提供简历';

  @override
  String get loading => '坐和放宽...';

  @override
  String get loadFailed => '好东西就要来了！';

  @override
  String get savedSuccessfully => '保存很成功！';

  @override
  String get copiedSuccessfully => '复制很成功！';

  @override
  String get noEventText => '找不到你的事件';

  @override
  String get theme => '主题';

  @override
  String get previousPage => '前一页';

  @override
  String get nextPage => '后一页';

  @override
  String get noReadme => 'README 文件未找到';

  @override
  String get readmeLoadFailed => 'README 装载失败';

  @override
  String get noDescription => '未提供描述';

  @override
  String get noMoreRepos => '没有更多仓库了';

  @override
  String get noReleases => '暂未释放';

  @override
  String get unNamed => '无名氏';

  @override
  String get repoNoExistOrPrivate => '这个仓库不存在或是私有的';

  @override
  String get cannotSaveImageWithNoPermissionToGallery => '啊哦！画廊权限对保存图像是必须的';

  @override
  String get saveImage => '保存图像';

  @override
  String get savingImage => '正在装载图像...';

  @override
  String get imageSaved => '图像已保存到画廊';

  @override
  String get imageSaveFailed => '图像保存失败';

  @override
  String get forkARepository => '叉了一个仓库';

  @override
  String get starARepository => '标星了一个仓库';

  @override
  String get createARepository => '创建了一个仓库';

  @override
  String get createABranch => '创建了一个分支';

  @override
  String get createATag => '创建了一个标签';

  @override
  String get deleteABranch => '删除了一个分支';

  @override
  String get deleteATag => '删除了一个标签';

  @override
  String get releaseANewVersion => '释出了一个版本';

  @override
  String get now => '现在';

  @override
  String minuteAgo(int minutes) {
    return '$minutes 分前';
  }

  @override
  String hourAgo(int hours) {
    return '$hours 时前';
  }

  @override
  String dayAgo(int days) {
    return '$days 天前';
  }

  @override
  String monthAgo(int months) {
    return '$months 个月前';
  }

  @override
  String yearAgo(int years) {
    return '$years 年前';
  }

  @override
  String get bottomNavigationExplore => '探险';

  @override
  String get bottomNavigationMine => '配置文件';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '系统默认';

  @override
  String get languageChinese => '中文';

  @override
  String get languageChineseMicrosoft => '中文（微软）';

  @override
  String get languageEnglish => '英文';

  @override
  String get choosePrimaryColor => '选择主要的色';

  @override
  String get chooseSecondaryColor => '选择强调色';

  @override
  String get chooseSurfaceColor => '选择表面色';

  @override
  String get chooseErrorColor => '选择错误颜色';

  @override
  String get chooseOnPrimaryColor => '主要色上面的文本颜色';

  @override
  String get chooseOnSecondaryColor => '强调色上面的文本颜色';

  @override
  String get chooseOnSurfaceColor => '表面颜色上面的文本颜色';

  @override
  String get chooseOnErrorColor => '错误颜色上面的文本颜色';

  @override
  String get colorShade => '颜色阴影';

  @override
  String get opacity => '不透明度';

  @override
  String get saveChangesOfTheme => '保存主题更改';

  @override
  String get unSavedThemeChangesTitle => '未保存的更改';

  @override
  String get unSavedThemeChangesMessage => '您有未保存的更改。您想在不保存的情况下退出吗？';

  @override
  String get cannotDeleteLastTheme => '主题至少要保留一个';

  @override
  String get longPressToDeleteTheme => '长按删除主题';

  @override
  String get advancedThemeSettings => '先进主题设置';

  @override
  String get autoSelectOtherColors => '自动设置其他颜色';

  @override
  String get autoSelectTextColors => '自动设置文字颜色';

  @override
  String get enableDarkMode => '黑暗模式';

  @override
  String get primaryColorLabel => '主要的色';

  @override
  String get accentColorLabel => '强调色';

  @override
  String get bothColorLabel => '主要的色和强调色';

  @override
  String get customColorLabel => '自定义';

  @override
  String get wheelColorLabel => '色轮';

  @override
  String get codePreviewSettings => '代码预览设置';
}
