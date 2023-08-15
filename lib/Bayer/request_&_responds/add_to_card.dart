import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Bayer/request_&_responds/get_product_details.dart';
import 'package:pharmabag/Bayer/request_&_responds/global2.dart';


Future addtoCart(String id, String qty, String price) async {
  final String? authToken = await SellerGlobalHandler.getToken();
  final data = await http.post(Uri.parse('$baseUrl/buyer/auth/cart'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "auth-token": authToken!
      },
      body: json.encode({
        "product_id": id,
        "quantity": qty,
        "price_details": price,
        "delivary_date": ""
      }));
  print(data.statusCode);
}