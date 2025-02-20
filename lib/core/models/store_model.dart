// Modelo básico do store que vai vir da minha API.

class Store {
  final String id;
  final String name;
  final double? revenueGoal;
  final int? quantityOfTables;
  String? password;

  Store(
      {required this.id,
      required this.name,
      required this.revenueGoal,
      this.quantityOfTables,
      this.password});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      revenueGoal: json['revenueGoal'],
      password: json['password'],
    );
  }
}
