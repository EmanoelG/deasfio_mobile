import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class HttpMetod {
  static const String post = 'post';
  static const String get = 'get';
  static const String put = 'put';
  static const String delete = 'delete';
  static const String patch = 'patch';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String metod,
    Map? headers,
    Map? body,
  }) async {



    Dio dio = Dio();
    try {
      dio.options.connectTimeout = const Duration(seconds: 15000);
      dio.options.receiveTimeout = const Duration(seconds: 15000);
      Response response = await dio.request(
        url,
        options: Options(
          method: metod,
        ),
        data: body,
      );
      return response.data;
    } on SocketException {
      return {'error': 'sem conexão com internet'};
    } on DioError catch (error) {
      if (error.error is SocketException) {
        // Lida com a exceção SocketException aqui
        return {'error': 'sem conexao de internet'};
      } else {
        // Lida com outras exceções aqui
        if (error.error is TimeoutException) {
          return {'error': 'sem conexao de internet'};
        } else if (error.type == DioErrorType.connectionTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          // lidar com o erro de timeout
          return {'error': 'sem conexao de internet'};
        } else {
          return error.response?.data ?? {};
        }
      }
    } catch (error) {
      return {'error': error.toString()};
    }
  }
}

// abstract class KeysApp {
//   static String userKey = 'user_key';
//   static String userToken = 'userToken';
// }
