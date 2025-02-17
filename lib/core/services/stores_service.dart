// lib/services/store_service.dart
import 'package:dio/dio.dart';
import 'package:test/common/constants/api_constants.dart';
import 'package:test/core/models/store_model.dart';
import 'package:test/utils/api.dart';

class StoreService {
  Future<List<dynamic>> fetchStores() async {
    final String url = "${ApiConstants.apiURL}/stores/my";
    var dio = ApiService.dio;

    try {
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception("Erro ao buscar lojas: $e");
    }
  }

  Future<void> selectStore(String storeId) async {
    final String url = "${ApiConstants.apiURL}/auth/select/$storeId";
    var dio = ApiService.dio;

    try {
      await dio.post(
        url,
        data: {"password": ""},
        options: Options(headers: {"Content-Type": "application/json"}),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Store?> getInformations() async {
    final String url = "${ApiConstants.apiURL}/stores/informations";

    try {
      Response<dynamic> response = await ApiService.dio.get(url);
      dynamic data = response.data;
      Store store = Store(id: data["id"], name: data["name"], password: null);
      return store;
    } catch (e) {
      print("Error $e");
    }
    return null;
  }
}
