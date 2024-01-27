import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_hackathon/screens/arvr/agent/upload_data_screen.dart';

class CreateAd {
  late final _apiLink;
  late final Dio _dio;

  CreateAd() {
    _apiLink = "http://172.22.125.32";
    _dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
        },
        baseUrl: _apiLink,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 200) < 500;
        },
      ),
    );
    // _timeNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  Future<Map<dynamic, dynamic>> getItenirary() async {
    try {
      Response response = await _dio.get(
        '/getproperty',
      );
      print(response.data.toString());

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Map<dynamic, dynamic>> getItinerary() async {
    try {
      Response response = await _dio.get(
        '/getmarathon',
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> createPet(PropertyPayload pay) async {
    try {
      Response response =
          await _dio.post('/propertyFeed', data: json.encode(pay));
      print(response);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<dynamic>> getNoti() async {
    try {
      Response response = await _dio.get(
        '/getnoti',
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<dynamic>> getSearch(String q) async {
    try {
      Response response = await _dio.get(
        '/searchEvent?event=' + q,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Map<dynamic, dynamic>> getUserEvents() async {
    try {
      Response response = await _dio.get(
        '/getUsersMarathon',
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<dynamic>> getSearchPet(String q) async {
    try {
      Response response = await _dio.get(
        '/searchPetition?petition=' + q,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<dynamic>> getCategory(String c) async {
    try {
      Response response = await _dio.get(
        '/getEventByCategory?category=' + c,
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> sendFcmToken(String token) async {
    try {
      Response response = await _dio.get(
        '/tokenSave?token=' + token,
      );
      print(response.data.toString());
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> createEvent(String id, String type) async {
    try {
      Response response = await _dio
          .get('/join', queryParameters: {'marathonId': id, 'type': type});
      print(response.data.toString());
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> login(String username) async {
    try {
      Response response = await _dio.post('/login', data: {'email': username});
      print(response.data.toString());
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
