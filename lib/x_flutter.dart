library x_flutter;

import 'package:dio/dio.dart';

class Api {
  final dio = Dio();

  String backendHost = "adsljjlf.adsafsd.com";

  /// Api Singleton
  static Api? _instance;
  static Api get instance {
    if (_instance == null) {
      _instance = Api();
    }
    return _instance!;
  }

  request(String route, {Map<String, dynamic> data = const {}}) async {
    try {
      //404
      final res = await dio.get('https://$backendHost/xsddddd');
      print(res.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        final res = e.response as Response;
        print(res.data);
        print(res.headers);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
        if (e.message != null) {
          if (e.message.indexOf('Failed host lookup') > -1) {
            throw "백엔드 호스트 - $backendHost - 에 접속 할 수 없습니다.";
          }
        }
      }
    }
  }
}
