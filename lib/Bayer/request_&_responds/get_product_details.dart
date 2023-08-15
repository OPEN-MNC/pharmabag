import 'dart:io';
import 'dart:convert';
import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Bayer/Auth/log_in.dart';
import 'package:pharmabag/Bayer/components/cart/cart.dart';
import 'package:pharmabag/Bayer/model/product_details_model.dart';

const baseUrl = "https://pharmabag.in:3000";

const FlutterSecureStorage _storage = FlutterSecureStorage();

Future<ProductsDetailsModel> getProductDetails(productId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/buyer/un/auth/products/per/$productId'),
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
  );
  if (response.statusCode == 200) {
    var jsonRespone = json.decode(response.body);
    var data = ProductsDetailsModel.fromJson(jsonRespone);
    return data;
  } else {
    throw Exception('getting error');
  }
}

int cartnumber = 0;

int getCart() {
  return cartnumber;
}

double parseFloat(String x) {
  return double.parse(x);
}

int parseInt(String x) {
  return int.parse(x);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<bool?> confirm(String message, context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

void alert(String message, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

addtocart(id, qty, date, event, stock, minqty, context) async {
  if (stock <= 0) {
    if (await confirm(
            "You have to wait unlit new Stock comes,or we can find a new seller,are you okay with it?",
            context) ==
        false) {
      return 0;
    }
  }
  if (minqty > qty) {
    alert(
        "you must select a valid  quantity to buy (More than Min qty $minqty)",
        context);
    return;
  }
  var calculate = parseInt(qty.toString()) * parseFloat("966.15");
  calculate += calculate * parseFloat("18.00") / 100;
  if (calculate < 20000) {
    alert(
        "your total amount should be more than ₹20000 buy some more worth ₹${(20000.00 - calculate).toInt()}",
        context);
    return;
  }
  String token = await _storage.read(key: 'buyertoken').then((value) {
    return value.toString();
  });
  var x =
      await http.post(Uri.parse("https://pharmabag.in:3000/buyer/auth/cart"),
          headers: {"content-type": "application/json", "auth-token": token},
          body: jsonEncode({
            "product_id": id,
            "quantity": qty.toString(),
            "price_details": jsonEncode({"delivary_date": date}).toString()
          }).toString());

  if (x.statusCode == 404 || x.statusCode == 401 || x.statusCode == 402) {
    alert("You must login as a buyer first then you can buy", context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const BuyerLogin();
    }));
  } else if (x.statusCode == 403) {
    alert("Please Wait until Admin verify your licenses!", context);
    return;
  } else if (x.statusCode == 200) {
    alert('Item added to cart successfully', context);
    dispatchCustomEvent(1.toString(), "CartUpdate");

// event.innerText="Added to Cart";
// event.disabled=true;
//document.getElementById("reletedItemsContainer").scrollIntoView();
//showmycart();
  }
}

Future<List<dynamic>> getProducts() async {
  final response = await http.get(
    Uri.parse('$baseUrl/user/get/10/product/homepage'),
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
  );
  if (response.statusCode == 200) {
    late List<dynamic> data;
    try {
      data = json.decode(response.body);
      // data = jsonRespone.values.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      // print('error----->$e');
    }

    return data;
  } else {
    throw Exception('getting error');
  }
}

addCustomOrder(id, qty, date, event, stock, maxqty, context) async {
  if (stock <= 0) {
    if (await confirm(
            "You have to wait unlit new Stock comes,or we can find a new seller,are you okay with it?",
            context) ==
        false) {
      return 0;
    }
  }
  if (maxqty > qty) {
    alert(
        "you must select a valid  quantity to buy (More than max qty $maxqty)",
        context);
    return;
  }
  var calculate = parseInt(qty.toString()) * parseFloat("966.15");
  calculate += calculate * parseFloat("18.00") / 100;
  if (calculate < 20000) {
    alert(
        "your total amount should be more than ₹20000 buy some more worth ₹${(20000.00 - calculate).toInt()}",
        context);
    return;
  }
  var x =
      await http.post(Uri.parse("https://pharmabag.in:3000/buyer/auth/cart"),
          headers: {
            "content-type": "application/json",
            "auth-token":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s"
          },
          body: jsonEncode({
            "product_id": id,
            "quantity": qty.toString(),
            "price_details": jsonEncode({"delivary_date": date}).toString()
          }).toString());

  if (x.statusCode == 404 || x.statusCode == 401 || x.statusCode == 402) {
    alert("You must login as a buyer first then you can buy", context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const BuyerLogin();
    }));
  } else if (x.statusCode == 403) {
    alert("Please Wait until Admin verify your licenses!", context);
    return;
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Added to Bag'),
          content: const Text(
            'Your order is successfully Added to Bag! Now make Go to bag and Place Order.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
