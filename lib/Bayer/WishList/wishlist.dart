import 'dart:convert';

import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/components/productdetails.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:http/http.dart' as http;

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  void initState() {
    getWishList();
    super.initState();
  }

  List<dynamic> finalData = [];
  int cartCount = 0;
  getWishList() async {
    String url = "https://pharmabag.in:3000/buyer/auth/wishlist";
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    finalData = jsonDecode(res.body);
    for (var element in finalData) {
      if ((element['product_details'] as List<dynamic>).isNotEmpty) {
        cartCount += 1;
      }
    }
    setState(() {
      finalData = finalData;
      cartCount = cartCount;
    });
  }

  deleteItem(String id) async {
    String url = "https://pharmabag.in:3000/buyer/auth/wishlist/$id";
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    setState(() {
      finalData.removeWhere((element) => element['product_id'] == id);
    });
    http.Response res =
        await http.delete(Uri.parse(url), headers: {'auth-token': token});
    if (res.statusCode == 200) {
      showAlert('Item deleted successfully');

      dispatchCustomEvent((cartCount - 1).toString(), 'WishList');
    } else {
      print(res.statusCode);
      showAlert('Item deletion failed');
    }
  }

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
        title: const Text(
          'WishList',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: cartCount == 0
          ? const Center(
              child: Text(
                'No items in the wishlist',
                style: TextStyle(color: primaryColor),
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView.builder(
                  itemCount: finalData.length,
                  itemBuilder: (context, index) {
                    var currentItem = finalData[index];
                    if ((currentItem['product_details'] as List<dynamic>)
                        .isEmpty) {
                      return Container();
                    }
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                  productId: currentItem['product_id']))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 0,
                          child: ListTile(
                            leading: currentItem['product_details'][0]
                                        ['image_list'][0]
                                    .toString()
                                    .isNotEmpty
                                ? Image.network(
                                    currentItem['product_details'][0]
                                            ['image_list'][0]
                                        .toString(),
                                    errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      "https://pharmabag.in/image/logo/logo-edited.png",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.contain,
                                    );
                                  })
                                : const Text('No Image'),
                            title: currentItem['product_details'][0]
                                        ['product_name']
                                    .toString()
                                    .isEmpty
                                ? const Text('No Title')
                                : Text(
                                    currentItem['product_details'][0]
                                        ['product_name'],
                                    style: const TextStyle(color: primaryColor),
                                  ),
                            subtitle: currentItem['product_details'][0]
                                        ['company_name']
                                    .toString()
                                    .isEmpty
                                ? const Text('No company')
                                : Text(currentItem['product_details'][0]
                                    ['company_name']),
                            trailing: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Material(
                                          type: MaterialType.circle,
                                          color: whiteColor,
                                          child: Icon(
                                            Icons.warning,
                                            color: red,
                                            size: 45,
                                          ),
                                        ),
                                        content: const Text('Are you sure?',
                                            style:
                                                TextStyle(color: primaryColor)),
                                        actions: [
                                          MaterialButton(
                                            color: primaryColor,
                                            onPressed: () {
                                              Navigator.pop(context);
                                              deleteItem(
                                                  currentItem['product_id']);
                                            },
                                            child: const Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                          ),
                                          MaterialButton(
                                            color: whiteColor,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
