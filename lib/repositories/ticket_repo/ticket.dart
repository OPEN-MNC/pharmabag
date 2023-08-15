import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Tickets {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future addTicket(String reason, String subject, String message) async {
    const url = 'https://pharmabag.in:3000/seller/create/ticket';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var body = {"reason": reason, "subject": subject, "message": message};
    var finalData = jsonEncode(body).toString();
    var res = await http.post(Uri.parse(url),
        body: finalData,
        headers: {'content-type': 'application/json', 'auth-token': token});
    debugPrint(res.statusCode.toString());
    return res.statusCode;
  }

  Future getTickets() async {
    var res;
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    const url = 'https://pharmabag.in:3000/seller/my/tickets';
    res = await http
        .get(Uri.parse(url), headers: {'auth-token': token}).then((value) {
      res = value.body;
      return res;
    });
    return res;
  }

  Future getBuyerTickets() async {
    var res;
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    const url = 'https://pharmabag.in:3000/buyer/my/tickets';
    res = await http
        .get(Uri.parse(url), headers: {'auth-token': token}).then((value) {
      res = value.body;
      return res;
    });
    return res;
  }
}
