import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:recipes_app/core/utils/exceptions_app.dart';
export 'package:http/http.dart';

abstract class HttpAppClient {
  static http.Client _client = http.Client();

  static Map<String, String> get headersJson {
    return {'Content-Type': "application/json", 'Accept': "application/json", "Connection": 'keep-alive'};
  }

  static Future<http.Client> _getInstance({Map<String, String>? headersParams, bool isRemoveHeaders = false}) async {
  
    Map<String, String> headers = {};

    headers.addAll(headersJson);

    _client = http.Client();

    if (isRemoveHeaders) {
      headers = headersParams ?? {};
    } else {
      headers.addAll(headersParams ?? {});
    }

    return _client;
  }

  static Future<http.Response> get(String url, {Map<String, String>? headers, Map<String, dynamic>? queryParameters, bool isRemoveHeaders = false}) async {
    late final http.Response instanceResult;

    try {
      final instance = await _getInstance(headersParams: headers, isRemoveHeaders: isRemoveHeaders);

      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      instanceResult = await instance.get(uri, headers: headers).timeout(Duration(seconds: 2), onTimeout: (){
      return http.Response('Time out!', 500);
    });
    } on http.ClientException catch (error) {
      throw ExceptionGeneral(message: error.message);
    } on NetworkException catch (ex) {
      throw NetworkException(ex.message);
    }

    return instanceResult;
  }
}
