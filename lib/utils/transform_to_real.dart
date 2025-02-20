import 'package:intl/intl.dart';

String formatToReais(dynamic value) {
  // Verifica se o valor é do tipo String ou int
  double parsedValue = 0.0;
  if (value is String) {
    parsedValue = double.tryParse(value) ?? 0.0; // Converte string para double
  } else if (value is int) {
    parsedValue = value.toDouble(); // Converte int para double
  }

  // Usa o Intl para formatar o número para o formato de reais
  final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  return formatter.format(parsedValue);
}
