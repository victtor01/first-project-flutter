import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/common/constants/api_constants.dart';

class ApiService {
  static final Dio dio = Dio();
  static CookieJar cookieJar = CookieJar();

  static Future<void> setupDio() async {
    final directory = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(storage: FileStorage(directory.path));
    dio.interceptors.add(CookieManager(cookieJar));
  }

  static Future<List<Cookie>> getCookies() async {
    List<Cookie> cookies =
        await cookieJar.loadForRequest(Uri.parse(ApiConstants.apiURL));
    return cookies;
  }

  static void showCookies() async {
    List<Cookie> cookies = await ApiService.getCookies();

    if (cookies.isEmpty) {
      print("Nenhum cookie encontrado.");
    } else {
      for (var cookie in cookies) {
        print("Nome: ${cookie.name}, Valor: ${cookie.value}");
      }
    }
  }
}
