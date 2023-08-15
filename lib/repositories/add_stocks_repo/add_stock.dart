import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddStock {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  addNewStock(
      String productName,
      String companyName,
      String chemicalComb,
      List<String> extrafields2,
      String categories,
      String stocks,
      String min,
      String max,
      String price,
      String expiryDate,
      String gstPercent,
      String discountOnPtrPercentage,
      String buy,
      String get,
      String producName,
      String images,
      String bulk,
      String extrafields,
      String discountformdetails,
      String discountdetails) async {
    const String url = "https://pharmabag.in:3000/seller/auth/products/add";
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var body = {
      "product_name": productName,
      "company_name": companyName,
      "chemical_combination": chemicalComb,
      "extra_fields2": extrafields2,
      "categories": categories,
      "stock": stocks,
      "min_order_qty": min,
      "max_order_qty": max,
      "product_price": price,
      "expire_date": expiryDate,
      "gstPercentage": gstPercent,
      "discountOnPtrOnlyPercenatge": discountOnPtrPercentage,
      "buy": buy,
      "get": get,
      "producName": producName,
      "image_list": images,
      "bulk": bulk,
      "extra_fields": extrafields,
      "discount_form_details": discountformdetails,
      "discount_details": discountdetails
    };

    var finalData = jsonEncode(body).toString();
    final res = await http.post(Uri.parse(url), body: finalData, headers: {
      'content-type': 'application/json',
      'auth-token': token
    }).then((value) {
      return value.body;
    });
    return res;
  }

  editStock(
      String id,
      String productName,
      String companyName,
      String chemicalComb,
      List<String> extrafields2,
      String categories,
      String stocks,
      String min,
      String max,
      String price,
      String expiryDate,
      String gstPercent,
      String discountOnPtrPercentage,
      String buy,
      String get,
      String producName,
      String images,
      String bulk,
      String extrafields,
      String discountformdetails,
      String discountdetails) async {
    String url =
        "https://pharmabag.in:3000/seller/auth/products/add/update/$id";
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var body = {
      "product_name": productName,
      "company_name": companyName,
      "chemical_combination": chemicalComb,
      "extra_fields2": extrafields2,
      "categories": categories,
      "stock": stocks,
      "min_order_qty": min,
      "max_order_qty": max,
      "product_price": price,
      "expire_date": expiryDate,
      "gstPercentage": gstPercent,
      "discountOnPtrOnlyPercenatge": discountOnPtrPercentage,
      "buy": buy,
      "get": get,
      "producName": producName,
      "image_list": images,
      "bulk": bulk,
      "extra_fields": extrafields,
      "discount_form_details": discountformdetails,
      "discount_details": discountdetails
    };

    var finalData = jsonEncode(body).toString();
    final res = await http.post(Uri.parse(url), body: finalData, headers: {
      'content-type': 'application/json',
      'auth-token': token
    }).then((value) {
      return value.body;
    });
    return res;
  }

  Future getStocks() async {
    var url = 'https://pharmabag.in:3000/seller/auth/products/seller';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    var data = json.decode(res.body);

    return data;
  }

  Future getOrders() async {
    var url = 'https://pharmabag.in:3000/seller/auth/orders/seller';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    var data = json.decode(res.body);

    return data;
  }

  Future getCustomOrders() async {
    var url =
        'https://pharmabag.in:3000/seller/auth/orders/seller/get/all/custom/orders';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    var data = json.decode(res.body);

    return data;
  }

  Future getCancelledOrders() async {
    var url =
        'https://pharmabag.in:3000/seller/auth/orders/seller/get/cancel/orders';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    var data = json.decode(res.body);

    return data;
  }

  Future<String> uploadImage(File image) async {
    String fileName = image.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    var url = "https://pharmabag.in/upload.php";

    final img1 = await dio.post(url, data: data).then(
      (response) {
        debugPrint(response.statusMessage);
        debugPrint(response.statusCode.toString());
        debugPrint('The first image link is ${response.data}');
        return response.data;
      },
    );
    var img2 = img1.toString().split('https://')[1];
    // print(DL20B.toString());
    return 'https://$img2';
  }

  Future deleteProduct(String id) async {
    var res;
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    String url = 'https://pharmabag.in:3000/seller/auth/products/add/delete';
    var body = jsonEncode({'id': id}).toString();
    res = await http.post(
      Uri.parse(url),
      body: body,
      headers: {'content-type': 'application/json', 'auth-token': token},
    ).then((value) {
      res = value;
      return res;
    });
    return res;
  }

  Future decision(String id, int choice) async {
    var response;
    String url = '';
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    if (choice == 0) {
      url =
          "https://pharmabag.in:3000/seller/auth/orders/seller/accept/order/$id";
      var body = {"ispartial": 0};
      var data = jsonEncode(body).toString();
      var res = await http.post(Uri.parse(url), body: data, headers: {
        'content-type': 'application/json',
        'auth-token': token
      }).then((value) {
        response = value;
        return response;
      });
    } else if (choice == 1) {
      url =
          "https://pharmabag.in:3000/seller/auth/orders/seller/reject/order/$id";
      var res = await http.get(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'auth-token': token
      }).then((value) {
        response = value;
        return response;
      });
    } else {
      url =
          "https://pharmabag.in:3000/seller/auth/orders/seller/setmilestone/order/$id";
    }
    return response;
  }
}

//=====================================good code========================================
class CustomEvent {
  final String data;

  CustomEvent(this.data);
}

class EventManager {
  static EventManager? _instance;

  factory EventManager() {
    _instance ??= EventManager._internal();
    return _instance!;
  }

  EventManager._internal();

  final StreamController<CustomEvent> _eventController =
      StreamController<CustomEvent>.broadcast();

  Stream<CustomEvent> get eventStream => _eventController.stream;

  void dispatchEvent(CustomEvent event) {
    _eventController.sink.add(event);
  }

  // void dispose() {
  //   _eventController.close();
  // }
}

dispatchCustomEvent(var eventValue) {
  final event = CustomEvent(eventValue);
  EventManager().dispatchEvent(event);
}
//========================================================================================