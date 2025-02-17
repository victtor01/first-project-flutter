// Modelo básico do store que vai vir da minha API.

class Store {
  final String id;
  final String name;
  String? password;

  Store({required this.id, required this.name, this.password});
}
