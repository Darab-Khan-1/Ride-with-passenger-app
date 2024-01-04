import 'package:dio/dio.dart';
import '../Local/hive_storage.dart';

class NetworkClient {
  static final NetworkClient _singleton = NetworkClient._internal();
  factory NetworkClient() => _singleton;
  NetworkClient._internal();

  static final Dio dio = Dio();

  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      bool isTokenRequired = true}) async {
    return await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: headers(isTokenRequired: isTokenRequired),
      ),
    ).timeout(const Duration(seconds: 30));
  }

  static Future<Response> post(String url,
      {Map<String, dynamic>? data,
      bool isTokenRequired = true,
      Map<String, dynamic>? header}) async {
    print("-----------");

    return await dio.post(
      url,
      data: data,
      options: Options(
        headers: header ?? headers(isTokenRequired: isTokenRequired),
      ),
    ).timeout(const Duration(seconds: 30));
  }

  static Future<Response> put(String url,
      {Map<String, dynamic>? data, bool isTokenRequired = true}) async {
    return await dio.put(
      url,
      data: data,
      options: Options(
        headers: headers(isTokenRequired: isTokenRequired),
      ),
    ).timeout(const Duration(seconds: 30));
  }

  static Future<Response> delete(String url,
      {Map<String, dynamic>? data, bool isTokenRequired = true}) async {
    return await dio.delete(
      url,
      data: data,
      options: Options(
        headers: headers(isTokenRequired: isTokenRequired),
      ),
    ).timeout(const Duration(seconds: 30));
  }

  static Map<String, dynamic> headers({bool isTokenRequired = true}) {
    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String? accessToken = LocalStorage.getAccessToken;
    if (isTokenRequired && accessToken != null) {
      header["Authorization"] = "Bearer $accessToken";
    }
    return header;
  }
}
