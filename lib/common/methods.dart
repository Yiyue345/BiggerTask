import 'dart:async';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/models/repository_content.dart';
import 'package:biggertask/models/search.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Methods {

  static final DioManager _dioManager = DioManager();

  static Future<Map<String, dynamic>?> getMyInfo({required String? token}) async {
    // 第三发请求，获取用户信息

    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.post(
          'https://api.github.com/user',
      );

      if (response.statusCode == 200) {
        print('获取到用户信息: ${response.data}');
        return response.data;
      }

    } catch (e) {
      print("获取用户信息时发生错误: $e");
    }

    return null;
  }

  static Future<GitHubUser?> getUserInfo(String username, String? token) async {
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/users/$username',
      );

      if (response.statusCode == 200) {
        return GitHubUser.fromJson(response.data);
      } else {
        throw Exception('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user info: $e');
      return null;
    }
  }

  static Future<bool> isStarred({required String repoFullName, required String? token}) async {
    if (token == null || token.isEmpty) {
      return false;
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/user/starred/$repoFullName',
          options: Options(
            validateStatus: (status) => status == 204 || status == 404, // 204 表示已收藏，404 表示未收藏
          ),

      );

      if (response.statusCode == 204) {
        return true;
      }
      else if (response.statusCode == 404) {
        return false;
      }
      else {
        throw Exception('Failed to check starred status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error checking starred status: $e');
      return false; // 如果发生错误，默认返回未收藏状态
    }
  }

  static Future<bool> starRepository({required String repoFullName, required String? token}) async {
    if (token == null || token.isEmpty) {
      return false;
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.put(
        'https://api.github.com/user/starred/$repoFullName',
      );

      return response.statusCode == 204; // 204 No Content 表示成功
    } catch (e) {
      print('Error starring repository: $e');
      return false; // 如果发生错误，默认返回失败状态
    }
  }

  static Future<bool> unstarRepository({required String repoFullName, required String? token}) async {
    if (token == null || token.isEmpty) {
      return false;
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.delete(
        'https://api.github.com/user/starred/$repoFullName',
      );

      return response.statusCode == 204; // 204 No Content 表示成功
    } catch (e) {
      print('Error unstarring repository: $e');
      return false; // 如果发生错误，默认返回失败状态
    }
  }

  static Future<List<Event>> getMyEvents({required String? token, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty || Global.gitHubUser == null) {
      print('Token is null or empty, or GitHub user is not set.');
      return [];
    }

    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/users/${Global.gitHubUser?.login}/received_events',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );
      // print('Received events response: ${response.data}');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Event.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  static Future<List<Event>> getRepositoryEvents({required String? token, required String repoFullName, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return [];
    }

    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/repos/$repoFullName/events',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Event.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load repository events: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching repository events: $e');
      return [];
    }
  }

  static Future<Repository?> getRepository({required String fullName, required String? token}) async {
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/repos/$fullName',
      );

      if (response.statusCode == 200) {
        return Repository.fromJson(response.data);
      } else {
        throw Exception('Failed to load repository: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching repository: $e');
      return null; // 返回一个空的 Repository 实例
    }
  }

  static Future<List<Repository>> getStarredRepositories({required String? token, required String username, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return [];
    }

    try {
      late var response;
      _dioManager.setAuthToken(token);
      if (username == Global.gitHubUser!.login) {
        response = await _dioManager.dio.get(
          'https://api.github.com/user/starred',
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
        );
      }
      else {
        response = await _dioManager.dio.get(
          'https://api.github.com/users/$username/starred',
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
        );
      }


      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Repository.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load starred repositories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching starred repositories: $e');
      return [];
    }
  }

  static Future<int> getStarredCount({required String? token, GitHubUser? user}) async {
    if (token == null || user == null) {
      return 0;
    }
    try {
      List response;
      int count = 0;
      int page = 1;
      do {
        response = await Methods.getStarredRepositories(token: token, username: user.login, page: page, perPage: 100);
        page++;
        count += response.length;
      }
      while (response.isNotEmpty);

      return count;
    } catch (e) {
      Fluttertoast.showToast(msg: '获取标星数量失败: $e');
      return 0;
    }
  }

  static Future<List<Repository>> getOwnRepositories({required String? token, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return [];
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
          'https://api.github.com/user/repos',
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data; // 已经是List<dynamic>了
        // print(response.data);
        return jsonList.map((json) => Repository.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching repositories: $e');
      print('Error fetching repositories: $e');
      return [];
    }
  }

  static Future<List<Repository>> getRepositories({required String? token, required String username, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return [];
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
          'https://api.github.com/users/$username/repos',
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data; // 已经是 List<dynamic> 了
        // print(response.data);
        return jsonList.map((json) => Repository.fromJson(json)).toList();
      }
      else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching repositories: $e');
      print('Error fetching repositories: $e');
      return [];
    }
  }

  static Future<SearchReposResponse?> searchRepositories({required String? token, required String query, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return null;
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/search/repositories',
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        final SearchReposResponse searchResponse = SearchReposResponse.fromJson(response.data);
        return searchResponse;
      } else {
        throw Exception('Failed to search repositories: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error searching repositories: $e');
      print('Error searching repositories: $e');
      return null;
    }
  }

  static Future<SearchUsersResponse?> searchUsers({required String? token, required String query, int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/search/users',
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        final SearchUsersResponse searchResponse = SearchUsersResponse.fromJson(response.data);
        return searchResponse;
      } else {
        throw Exception('Failed to search users: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error searching users: $e');
      print('Error searching users: $e');
      return null;
    }
  }

  static Future<List<Release>> getReleases({required String? token, required String repoFullName, int page = 1, int perPage = 30}) async {
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/repos/$repoFullName/releases',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Release.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load releases: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching releases: $e');
      return [];
    }
  }

  static Future<int> getReleaseCount({required String? token, required String repoFullName}) async {
    int count = 0;
    try {
      _dioManager.setAuthToken(token);
      List response = await getReleases(token: token, repoFullName: repoFullName, page: 1, perPage: 100);
      while (response.isNotEmpty) {
        count += response.length;
        // 获取下一页
        response = await getReleases(token: token, repoFullName: repoFullName, page: (count ~/ 100) + 1, perPage: 100); // ~/是整除
      }
      return count;

    } catch (e) {
      print('Error fetching release count: $e');
      return 0;
    }
  }

  static Future<List<RepositoryContent>> getRepoContent({
    required String? token,
    required String repoFullName,
    String? path,
    String? ref,
}) async {
    if (token == null || token.isEmpty) {
      return [];
    }
    _dioManager.setAuthToken(token);
    try {
      String url = 'https://api.github.com/repos/$repoFullName/contents';
      if (path != null && path.isNotEmpty) {
        url += '/$path';
      }

      Map<String, dynamic> queryParameters = {};
      if (ref != null && ref.isNotEmpty) {
        queryParameters['ref'] = ref;
      }

      final response = await _dioManager.dio.get(
          url,
          queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> data = response.data;
          return data.map((item) => RepositoryContent.fromJson(item)).toList();
        }
        else if (response.data is Map) {
          // 如果是单个文件的内容，返回一个包含该文件的列表
          return [RepositoryContent.fromJson(response.data)];
        }
        else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      }
      else {
        throw Exception('Failed to fetch repository content: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching repository content: $e');
      return [];
    }
  }

  static Future<Map<String, int>> getRepositoryLanguages({required String? token, required String repoFullName}) async {
    if (token == null || token.isEmpty) {
      return {};
    }
    try {
      _dioManager.setAuthToken(token);
      final response = await _dioManager.dio.get(
        'https://api.github.com/repos/$repoFullName/languages',
      );

      if (response.statusCode == 200) {
        return Map<String, int>.from(response.data);
      } else {
        throw Exception('Failed to load repository languages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching repository languages: $e');
      return {};
    }
  }
}

class DioManager {
  static final DioManager _instance = DioManager._internal();
  late final Dio _dio;

  factory DioManager() {
    return _instance;
  }

  DioManager._internal() {
    _dio = Dio();
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          handler.next(error);
        },
      )
    );

    _dio.options.connectTimeout = Duration(seconds: 30);
    _dio.options.receiveTimeout = Duration(seconds: 30);
    _dio.options.headers['Accept'] = 'application/vnd.github.v3+json';

  }

  void setAuthToken(String? token) {
    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
    else {
      _dio.options.headers.remove('Authorization');
    }
  }

}
