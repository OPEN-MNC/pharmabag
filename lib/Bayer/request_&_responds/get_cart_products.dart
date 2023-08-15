import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:pharmabag/Bayer/request_&_responds/get_product_details.dart';
import 'package:pharmabag/Bayer/request_&_responds/global.dart';

Future<List<dynamic>> getbagProducts() async {
  final String? authToken = await BuyerGlobalHandler.getToken();
  final response = await http.get(
    Uri.parse('$baseUrl/buyer/auth/cart'),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "auth-token": authToken!
    },
  );
  if (response.statusCode == 200) {
    late List<dynamic> data;
    try {
      data = json.decode(response.body);
      // data = jsonRespone.values.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {}

    return data;
  } else {
    throw Exception('getting error');
  }
}
