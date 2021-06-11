import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:x_flutter/models/time.dart';
import 'package:x_flutter/models/version.dart';

class Api {
  final dio = Dio();

  String backendScheme = "https";
  String backendHost = "main.philov.com";
  String get url => '$backendScheme://$backendHost/index.php';

  /// Api Singleton
  static Api? _instance;
  static Api get instance {
    if (_instance == null) {
      _instance = Api();
    }
    return _instance!;
  }

  // 백엔드에 요청
  //
  // [route] 와 [data] 에 요청 값을 넣고 백엔드로 요청
  //
  // 예제: 백엔드 버전 가져오기
  // ```dart
  // final res = await Api.instance.request('app.version');
  // print('version: ${res['version']}');
  // ```
  Future request(String route, [Map<String, dynamic>? data]) async {
    if (data == null) data = {};
    data['route'] = route;
    try {
      final res = await dio.post(
        url,
        data: data,
        onSendProgress: (int sent, int total) {
          // print('sent: $sent total: $total');
        },
      );
      if (res.data is String) {
        print(res);
        throw "벡엔드로 부터 결과 값을 받았으나, 그 결과 값이 올바르지 않습니다. 접속 주소가 올바른지, 백엔드로 요청한 값이 올바른지, 백엔드 프로그램에 에러가 있는지 확인을 해 주세요.";
      }
      if (res.data['response'] is String) {
        throw res.data['response'];
      }

      // 성공
      return res.data['response'];
    } on DioError catch (e) {
      // 백엔드에서 에러 발생.
      //
      // 백엔드로 접속이 되었으나 2xx 또는 304 가 아닌 다른 응답 코드가 발생한 경우.
      if (e.response != null) {
        final res = e.response as Response;
        print("경고: Dio 에서 이 부분에 에러가 발생하는 경우를 찾지 못하겠다. 에러가 이 부분으로 떨어지면, 디버깅을 해서 처리를 할 것.");
        throw (res.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);

        // 백엔드 호스트 오류. 접속 불가.
        if (e.message.indexOf('Failed host lookup') > -1) {
          throw "백엔드 호스트 - $backendHost - 에 접속 할 수 없습니다. 호스트가 올바른지 확인을 해 주세요.";
        } else if (e.message.indexOf('CERTIFICATE_VERIFY_FAILED') > -1) {
          throw "백엔드 호스트 접속시 인증서 오류가 발생하였습니다. HTTP 또는 HTTPS 접속인지 확인을 해 주세요.\nCERTIFICATE_VERIFY_FAILED: application verification failure";
        }
      }
    } catch (e) {
      // 모든 에러를 캐치
      _printDebugUrl(data);
      rethrow;
    }
  }

  // 디버그 URL 출력
  //
  // 백엔드로 부터 원하는 결과가 도착하지 않을 때, 실제로 백엔드로 접속할 수 있는 URL 을 Debug console 에 출력한다.
  // ignore: unused_element
  _printDebugUrl(data) {
    Map<String, dynamic> params = {};
    data.forEach((k, v) {
      if (v is int || v is double) v = v.toString();
      params[k] = v;
    });

    try {
      String queryString = Uri(queryParameters: params).query;
      debugPrint("==>> $url?$queryString", wrapWidth: 1024);
    } catch (e) {
      print("==> Caught error on _printDebug() with data: ");
      print(data);
    }
  }

  // 백엔드의 버전을 가져온다.
  // ```
  // print('버전: ' + (await Api.instance.version()).version);
  // ```
  Future<Version> version() async {
    return Version.fromJson(await this.request('app.version'));
  }

  // 백엔드 서버의 시간을 가져온다.
  // ```
  // final res = await Api.instance.time();
  // print('res; ${res.time}');
  // ```
  Future<Time> time() async {
    return Time.fromJson(await this.request('app.time'));
  }
}
