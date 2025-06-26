import 'package:dio/dio.dart';

class Methods {
  static Future<Map<String, dynamic>?> getUserInfo(String? token) async {
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
}