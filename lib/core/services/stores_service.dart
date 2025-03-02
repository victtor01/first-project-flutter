import 'package:dio/dio.dart';
import 'package:mobile_pointsale/common/constants/api_constants.dart';
import 'package:mobile_pointsale/core/interfaces/stores_interfaces/get_informations_response.dart';
import 'package:mobile_pointsale/core/models/store_model.dart';
import 'package:mobile_pointsale/utils/api.dart';

class StoreService {
  Future<List<InformationStore>> fetchStores() async {
    final String url = "${ApiConstants.apiURL}/stores/my";
    final Dio dio = ApiService.dio;

    try {
      final response = await dio.get(url);
      List<dynamic> data = response.data;

      List<InformationStore> informations = data.map((storeData) {
        dynamic store = storeData["store"];
        dynamic revenue = storeData["revenue"];

        return InformationStore()
          ..store = Store(
            id: store["id"],
            name: store["name"],
            password: store["password"],
            quantityOfTables: store["quantityOfTables"],
            revenueGoal: (store["revenueGoal"] as num).toDouble(),
          )
          ..revenue = (revenue as num).toDouble();
      }).toList();

      return informations;
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

  Future<InformationStore> getInformations() async {
    final String url = "${ApiConstants.apiURL}/stores/informations";

    try {
      Response<dynamic> response = await ApiService.dio.get(url);
      dynamic data = response.data;
      dynamic store = data["store"];

      int revenue = data["revenue"];
      int revenueGoalOfStore = store["revenueGoal"];

      return InformationStore()
        ..store = Store(
          id: store["id"],
          name: store["name"],
          password: store["password"],
          revenueGoal: revenueGoalOfStore.toDouble(),
        )
        ..revenue = revenue.toDouble();
    } catch (e) {
      print("Error $e");
      throw Exception("store not found!");
    }
  }
}
