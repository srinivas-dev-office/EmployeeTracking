// ignore_for_file: avoid_print, deprecated_member_use, unused_import, unnecessary_import

import 'dart:convert';

import 'package:dio/dio.dart' hide Response, FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../untils/exports.dart';


class ApiService extends GetxService {
  String baseUrl = "http:65.0.157.186:6002/api/";
  String imageUrl = "http:65.0.157.186:6002/api/";

  final errorDict = {
    "data": [
      {"error": "Please check your internet connection."}
    ],
    "status": "error"
  };
  Future putRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.put("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 401) {
       // Get.offAllNamed(Klogin);
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future postRequest({
    required String endpoint,
    Map<dynamic, dynamic>? payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      debugPrint("$payload");
     // dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["authorization"] =
          '${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        return response.data;
      }
    } catch (e) {
      print(e);
    }
  }
Future<Map<String, dynamic>?> postidRequest({
  required String endpoint,
  Map<String, String>? customHeaders,
}) async {
  Uri url = Uri.parse(baseUrl + endpoint);
  try {
    Dio dio = Dio();
    dio.options.headers["accept"] = 'application/json';
    dio.options.headers["authorization"] =
        '${UserSimplePreferences.getToken()}';

    var response = await dio.post(
      "$url",
      options: Options(
        validateStatus: (status) {
          // Allow all responses (even errors) to be processed
          return true;
        },
      ),
    );

    return response.data; // Always return response data
  } on DioException catch (e) {
    print("DioException: ${e.response?.data}");
    return e.response?.data ?? {"success": false, "message": "Request failed"};
  } catch (e) {
    print("Unexpected Error: $e");
    return {"success": false, "message": "Unexpected error occurred"};
  }
}

  Future deleteRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.delete("$url");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

 Future postAuthRequest({
    required String endpoint,
    Map<dynamic, dynamic>? payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      debugPrint("$payload");
      dio.options.headers["Content-Type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 ||
           
          response.statusCode == 202) {
        return response.data;
      }
    
    } catch (e) {
      print(e);
    }

   
  }

  /////////////////
  Future<dynamic> getwithoutRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "accept": "application/json",
      };
      var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response");
        print(response.body);
        return response.body;
      } else if (response.statusCode == 404 || response.statusCode == 401) {
        if (jsonDecode(response.body)["message"] == "Unauthorized") {
         // Get.offAllNamed(Klogin);
        }
      } else {
        print("response.body");
      }
    } catch (e) {
      print(e);
      print("Die eroro.body");
    }
  }

  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
  "Authorization": 'Bearer ${UserSimplePreferences.getToken()}',
  "accept": "application/json" 
};

      var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        
        print("response");
        print(response.body);
        return response.body;
      } else if (response.statusCode == 404 || response.statusCode == 401) {
        if (jsonDecode(response.body)["message"] == "Unauthorized") {
          UserSimplePreferences.clearAllData();
         // Get.offAllNamed(Klogin);
        }
      } else {
        print("response.body");
      }
    } catch (e) {
      print(e);
      print("Die eroro.body");
    }
  }

  
}
