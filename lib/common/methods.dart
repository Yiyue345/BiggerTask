import 'dart:async';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/models/search.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Methods {

  static final DioManager _dioManager = DioManager();

  static Future<Map<String, dynamic>?> getMyInfo(String? token) async {
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

  static Future<bool> isStarred(String repoFullName, String? token) async {
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

  static Future<bool> starRepository(String repoFullName, String? token) async {
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

  static Future<bool> unstarRepository(String repoFullName, String? token) async {
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

  static Future<List<Event>> getMyEvents(String? token, {int page = 1, int perPage = 30}) async {
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

  static Future<Repository?> getRepository(String fullName, String? token) async {
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

  static Future<List<Repository>> getStarredRepositories(String? token, String username, {int page = 1, int perPage = 30}) async {
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

  static Future<int> getStarredCount(String? token, GitHubUser? user) async {
    if (token == null || user == null) {
      return 0;
    }
    try {
      List response;
      int count = 0;
      response = await Methods.getStarredRepositories(token, user.login, page: 1, perPage: 100);
      while (response.isNotEmpty) {
        count += response.length;
        // 获取下一页
        response = await Methods.getStarredRepositories(token, user.login, page: (count / 100).ceil() + 1, perPage: 100);
      }
      return count;
    } catch (e) {
      Fluttertoast.showToast(msg: '获取标星数量失败: $e');
      return 0;
    }
  }

  static Future<List<Repository>> getOwnRepositories(String? token, {int page = 1, int perPage = 30}) async {
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

  static Future<List<Repository>> getRepositories(String? token, String username, {int page = 1, int perPage = 30}) async {
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

  static Future<SearchReposResponse?> searchRepositories(String? token, String query, {int page = 1, int perPage = 30}) async {
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
