import 'package:dio/dio.dart';
import 'package:test/common/constants/api_constants.dart';
import 'package:test/utils/api.dart';

class StoreService {
  Future<List<dynamic>> fetchStores() async {
    final String url = "${ApiConstants.apiURL}/stores/my";
    final Dio dio = ApiService.dio;

    try {
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      throw Exception("Erro ao buscar lojas: $e");
    }
  }

  Future<void> selectStore(String storeId) async {
    final String url = "${ApiConstants.apiURL}/auth/select/$storeId";
    final Dio dio = ApiService.dio;

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

  Future<dynamic> getInformations() async {
    final String url = "${ApiConstants.apiURL}/stores/informations";

    try {
      Response<dynamic> response = await ApiService.dio.get(url);
      dynamic data = response.data;
      print(data);
      return data;
    } catch (e) {
      print("Error $e");
    }
    return null;
  }
}
