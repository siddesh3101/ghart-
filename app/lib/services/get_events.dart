import 'dart:developer';

import 'package:dio/dio.dart';

class EventsService {
  late final _apiLink;
  late final Dio _dio;

  EventsService() {
    _apiLink = "https://edumate.glitch.me";
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

  Future<Map<dynamic, dynamic>> getItenirary(Map data) async {
    var prompt =
        "Generate a personalized travel itinerary for a trip to ${data["destination"]} with a budget of ${data["budget"]}. The traveler is interested in a ${data["duration"]} vacation and enjoys ${data["interests"]}. They are looking for simple accommodations and prefer car transportation. The itinerary should include ${data["actitivity"]} activities. Please provide a detailed itinerary with daily recommendations for ${data["duration"]} days, including suggested destinations, activities, and dining options. The itinerary should be written in ${data["language"]}.";
    print(data);
    var data2 = {
      "prompt": prompt,
      // "limit": 11
      // transfer - 4, pending - 0, completed - 1
    };
    print(data2.toString());
    try {
      Response response = await _dio.post(
        '/travel',
        data: data2,
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

  Future<dynamic> createPet(String title, String cause, String category,
      String target, String img) async {
    try {
      Response response = await _dio.post('/createPetition', data: {
        "name": title,
        "cause": cause,
        "category": category,
        "target": target,
        "img": img
      });
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
