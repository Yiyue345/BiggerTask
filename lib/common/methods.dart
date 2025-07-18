import 'dart:async';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/models/event.dart';
import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:dio/dio.dart';

class Methods {
  static Future<Map<String, dynamic>?> getMyInfo(String? token) async {
    // 第三发请求，获取用户信息

    try {
      final dio = Dio();
      final response = await dio.post(
          'https://api.github.com/user',
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              }
          )
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
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/users/$username',
        options: Options(
          headers: {
            'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
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
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/user/starred/$repoFullName',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token'
            },
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
    Dio dio = Dio();
    try {
      final response = await dio.put(
        'https://api.github.com/user/starred/$repoFullName',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
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
    Dio dio = Dio();
    try {
      final response = await dio.delete(
        'https://api.github.com/user/starred/$repoFullName',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      return response.statusCode == 204; // 204 No Content 表示成功
    } catch (e) {
      print('Error unstarring repository: $e');
      return false; // 如果发生错误，默认返回失败状态
    }
  }

  static Future<List<Event>> getMyEvents(String? token, {int page = 1, int perPage = 30}) async {
    if (token == null || token.isEmpty || Global.gitHubUser == null) {
      return [];
    }

    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/users/${Global.gitHubUser?.login}/received_events',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

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
    Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.github.com/repos/$fullName',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
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
}