// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Bayer/Auth/log_in.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class BuyerAuth {
  final String url = "https://pharmabag.in:3000/buyer/un/auth";
  final String url3 = 'https://pharmabag.in:3000/verify/pan/gst/GST';
  final String url2 = 'https://pharmabag.in:3000/verify/pan/gst/PAN';
  final String url4 = 'https://pharmabag.in:3000/buyer/auth/register';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  sendOTP(String phone, BuildContext context) async {
    final response =
        await http.post(Uri.parse('$url/phone'), body: {"phone_no": phone});
    // debugPrint(
    //     'The status code is ${response.statusCode} and the response is ${response.body.runtimeType}');
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      var otp = res['otp'].toString();
      debugPrint(otp);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyOTP(otp: otp, phone: phone)));
    }
  }

  getToken(String otp, String phone, BuildContext context) async {
    final response = await http
        .post(Uri.parse('$url/verify'), body: {"phone_no": phone, "otp": otp});
    if (response.statusCode == 200) {
      debugPrint(response.body);
      Map<String, dynamic> res = jsonDecode(response.body);
      var token = res['auth-token'].toString();
      debugPrint(token);
      debugPrint(res['is_user_found'].toString());

      if (res['is_user_found'] == 1) {
        _storage.write(key: 'buyertoken', value: res['auth-token'].toString());

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const BuyerHome(isLoggedIn: true)));
      } else {
        _storage.write(key: 'buyertoken', value: res['auth-token'].toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ExtraDetails(
                  phone: phone,
                )));
      }
    }
  }

  getDetails(
      String pan, BuildContext context, int selected, String phone) async {
    if (selected == 1) {
      final response = await http.get(Uri.parse('$url2/$pan'));
      debugPrint('When 1 is selected : $url2/$pan');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse.runtimeType.toString());
        debugPrint(jsonResponse.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FinalDetails(data: jsonResponse, phone: phone)));
      }
    } else if (selected == 0) {
      final response = await http.get(Uri.parse('$url3/$pan'));
      debugPrint('When 0 is selected : $url3/$pan');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final jsonresponse = jsonDecode(response.body);
        debugPrint(jsonresponse.toString());
        debugPrint(jsonresponse.runtimeType.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FinalDetails(data: jsonresponse, gst: true, phone: phone)));
      }
    }
  }

  Future<List<String>> upload(File image, File image2, File image3) async {
    String fileName = image.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    String fileName2 = image2.path.split('/').last;
    FormData data2 = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image2.path,
        filename: fileName2,
      ),
    });
    String fileName3 = image3.path.split('/').last;
    FormData data3 = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image3.path,
        filename: fileName3,
      ),
    });

    Dio dio = Dio();

    var url = "https://pharmabag.in/upload.php";

    final img1 = await dio.post(url, data: data).then(
      (response) {
        debugPrint('The first image link is ${response.data}');
        return response.data;
      },
    );
    final img2 = await dio.post(url, data: data2).then((response) {
      debugPrint('The first image link is ${response.data}');
      return response.data;
    });
    final img3 = await dio.post(url, data: data3).then((response) {
      debugPrint('The first image link is ${response.data}');
      return response.data;
    });
    List<String> DL20B = [img1.toString(), img2.toString(), img3.toString()];
    // print(DL20B.toString());
    return DL20B;
  }

  getGeoLocation(String city, String state, String pincode) async {
    String address = '$city $state $pincode';
    var url = 'https://geocode.maps.co/search?q';
    String cords = '';
    var res = await http.get(Uri.parse("$url=$address")).then((response) {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse);
        cords = '${jsonResponse[0]['lat']},${jsonResponse[0]['lon']}';
        return cords;
      } else {
        cords = '20.5937,78.9629';
        return cords;
      }
    });
    return cords;
  }

  register(
      String legalName,
      String email,
      String phone,
      String name,
      String address,
      List<String> licenseA,
      List<String> licenseB,
      String bankAccount,
      String invite,
      String license,
      String gstpan) async {
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    var body = {
      "legal_name": legalName,
      "email": email,
      "phone_no": phone,
      "name": name,
      "address": address,
      "DL_20B": licenseA,
      "DL_21B": licenseB,
      "band_account": bankAccount,
      "invite_code": invite,
      "licence": license,
      "gst_pan_response": gstpan
    };
    var jsonencode = jsonEncode(body);
    final response = await http.post(Uri.parse(url4),
        body: jsonencode,
        headers: {
          "auth-token": token,
          "content-type": "application/json"
        }).then((value) {
      debugPrint(value.statusCode.toString());
    });
  }

  getBuyerProfile() async {
    const String url = 'https://pharmabag.in:3000/buyer/auth/profile';
    String token = await _storage.read(key: 'buyertoken').then((value) {
      print(value.toString());
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    return res;
  }
}
