/// This is a new api services class accomodated for running in new isolate

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:astro/bloc/base/bloc_event.dart';
import 'package:astro/bloc/base/bloc_response.dart';
import 'package:astro/bloc/base/bloc_states.dart';
import 'package:astro/services/rest_client.dart';
import 'package:astro/utils/api_keys.dart';
import 'package:astro/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiServices extends RestClient {
  static final ApiServices _instance = ApiServices._internal();

  ApiServices._internal();

  factory ApiServices() => _instance;

  /// common interface for all api requests
  Future<BlocResponse> apiRequest(
    ApiRequest request,String apiEndPoint,
    BlocEvent event, {
    Map<String, dynamic> ?body,
    Map<String, String> ?headers,
    Map<String, dynamic> ?queryParams,
  }) async {
    Uri uri = createURL(
      ApiKeys.baseUrl + apiEndPoint,
      queryParams,
    );
    if (kDebugMode) {
      log('------------------------------------------');
      final startTime = DateTime.now();
      log('START TIME: ${startTime.hour} : ${startTime.minute} : ${startTime.second}');
      log('URL: $uri');
      log('METHOD: ${request == ApiRequest.apiPost ? 'POST' :'GET'}');
      log('HEADERS: $headers');
      log('BODY: ${json.encode(body)}');
    }

    //try api requests
    try {
      int statusCode;
      String responseBody;
        http.Response response;
        switch (request) {
          case ApiRequest.apiGet:
            response = await getRequest(uri, headers);
            break;
          case ApiRequest.apiPost:
              response = await postRequest(uri, headers, body);
            break;
          default:
            return BlocResponse(
              BlocState.failed,
              event,
              message: "Unknown API Request",
            );
        }
        statusCode = response.statusCode;
        responseBody = response.body;

      if (kDebugMode) {
        log('STATUS CODE: $statusCode');
        log('RESPONSE: $responseBody');
      }

      var res = json.decode(responseBody);
      if (statusCode==200){
        return BlocResponse(
          BlocState.success,
          event,
          data: res,
          statusCode:statusCode,
        );
      } else {
        print("failed response ");
        return BlocResponse(
          BlocState.failed,
          event,
          message: "Something went wrong",
          statusCode: statusCode,
        );
      }
    } on TimeoutException {
      return BlocResponse(
        BlocState.noInternet,
        event,
        message: "No Internet",
      );
    } catch (e) {
      print("error $e");
      return BlocResponse(
        BlocState.failed,
        event,
        message: e.toString(),
        exceptionType: e.runtimeType,
      );
    } finally {
      if (kDebugMode) {
        log('---------------------------------------');
      }
    }
  }
}
