// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationRepo {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  getNotifications() async {
    const String url = 'https://pharmabag.in:3000/seller/my/notifications';
    String token = await _storage.read(key: 'token').then((value) {
      // print(value.toString());
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    return res.body;
  }

  getBuyerNotifications() async {
    const String url = 'https://pharmabag.in:3000/buyer/my/notifications';
    String token = await _storage.read(key: 'buyertoken').then((value) {
      // print(value.toString());
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    return res.body;
  }
// pass auth-token in the header at teh register api
}
