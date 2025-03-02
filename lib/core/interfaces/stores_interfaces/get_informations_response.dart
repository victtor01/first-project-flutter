import 'package:mobile_pointsale/core/models/store_model.dart';

class InformationStore {
	Store? store;
	double? revenue;
	
	 InformationStore({this.store, this.revenue});

  factory InformationStore.fromJson(Map<String, dynamic> json) {
    return InformationStore(
      store: Store.fromJson(json['store']),
      revenue: json['revenue'],
    );
  }

}