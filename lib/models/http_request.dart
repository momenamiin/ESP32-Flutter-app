import 'package:http/http.dart' as http;


class HttpRequest{

  static Future<http.Response> fetchData(String IP,String pin) {
    print('http://192.168.$IP/$pin');
    return http.get(Uri.parse('http://192.168.$IP/$pin'));
  }
}

