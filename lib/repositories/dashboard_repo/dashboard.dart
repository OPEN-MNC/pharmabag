import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DashboardRepo {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  getDashboardDetails() async {
    const String url = 'https://pharmabag.in:3000/seller/dashboard/details';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    Response res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    if (res.statusCode == 200) {
      return res;
    } else {
      return res;
    }
  }
}
