import 'dart:convert';
import 'package:astro/utils/api_keys.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> getPHeaders(
  bool authHeader,
) async {
  return {
    ApiKeys.contentType:ApiKeys.applicationJSON,
    if (authHeader) 'api_key': '1234',
  };
}

class RestClient {
  /// convert the url string to URI
  /// appends query params to the url
  Uri createURL(
    String url,
    Map<String, dynamic> ?queryParams,
  ) {
    // append query params to url
    if (queryParams != null) {
      int count = 0;
      queryParams.forEach((key, value) {
        if (count == 0) url += '?';
        url += '$key=$value';
        if (count < queryParams.length - 1) url += '&';
        count++;
      });
    }

    return Uri.parse(url);
  }

  /// to send get api request
  Future<http.Response> getRequest(
    Uri uri,
    Map<String, String> ?headers,
  ) async {
    print("api called");
    http.Response res =
        await http.get(uri, headers: headers).timeout(const Duration(seconds: 10));
    print("response status  is ${res.statusCode}");
    print("res data : -- ${res.body}");
    return res;
  }

  /// to send post api request
  Future<http.Response> postRequest(
    Uri uri,
    Map<String, String> ?headers,
    Map<String, dynamic> ?body,
  ) async {
    return await http
        .post(uri, headers: headers, body: json.encode(body))
        .timeout(const Duration(seconds: 10));
  }
}
