// lib/services/store_service.dart
import 'package:dio/dio.dart';
import 'package:test/common/constants/api_constants.dart';
import 'package:test/core/models/store_model.dart';

class StoreService {
  final Dio _dio = Dio();

  Future<List<Store>> fetchStores() async {
    final String url = "${ApiConstants.apiURL}/stores/my";
    try {
      final response = await _dio.get(url);
      return (response.data as List)
          .map((store) => Store(
                id: store['id'],
                name: store['name'],
                password: store['password'],
              ))
          .toList();
    } catch (e) {
      throw Exception("Erro ao buscar lojas: $e");
    }
  }
}
