import 'package:dio/dio.dart';
import 'package:flutter_demo/model/flavors_model.dart';

class ApiService {
  final Dio _dio;

  static final ApiService _instance = ApiService._internal(Dio());
  static const https = "http://127.0.0.1:8000/";
  factory ApiService() {
    return _instance;
  }

  ApiService._internal(this._dio) {
    _dio.options.baseUrl = '${https}api';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);
  }

  Future<FlavorsResponse> fetchFlavors() async {
    try {
      final response = await _dio.get('/flavors');
      return FlavorsResponse.fromJson(response.data);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> createFlavor(Map<String, dynamic> flavor) async {
    try {
      final response = await _dio.post('/flavors', data: flavor);
      if (response.statusCode == 200) {
        print('Message: ${response.data['message']}');
      } else {
        print('Failed to create flavor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
    Future<void> deleteFlavor(String id) async {
    try {
      final response = await _dio.post('/flavors/delete', data: {'id': id});
      if (response.statusCode == 200) {
        print('Message: ${response.data['message']}');
      } else {
        print('Failed to delete flavor. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
