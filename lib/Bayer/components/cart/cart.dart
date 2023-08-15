// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Bayer/My_order/order_page.dart';
import 'package:pharmabag/Bayer/components/ordersScreen_test.dart';
import 'package:pharmabag/components_&_color/color.dart';

class CartItem {
  final String productImage;
  final String cartId;
  final String productId;
  final String productName;
  final String productPrice;
  final String quantity;
  final String perPtr;
  final String gstValue;
  final String finalOrderValue;

  CartItem({
    required this.productImage,
    required this.cartId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.perPtr,
    required this.gstValue,
    required this.finalOrderValue,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<CartItem> cartItems = [];
  double finalPrice = 0;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  List<dynamic> cartData = [];
  double totalPrice = 0.0;
  fetchCartItems() async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart');
    String authToken = await _storage.read(key: 'buyertoken').then((value) {
      debugPrint(value.toString());
      return value.toString();
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'auth-token': authToken,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['result_cart'];
        debugPrint('the data ${data.runtimeType} and  $data');
        cartData = data;
        for (var element in cartData) {
          totalPrice +=
              double.parse(element['pricing']['final_order_value'].toString());
        }
        setState(() {
          cartData = cartData;
          totalPrice = totalPrice;
        });

        // final List<CartItem> fetchedItems = [];
        // double totalPrice = 0;

        // for (var i = data.length - 1; i >= 0; i--) {
        //   final item = CartItem(
        //     productImage: data[i]['product_image'],
        //     cartId: data[i]['cart_id'],
        //     productId: data[i]['product_id'],
        //     productName: data[i]['product_name'],
        //     productPrice: data[i]['product_price'].toString(),
        //     quantity: data[i]['quantity'].toString(),
        //     perPtr: data[i]['pricing']['per_ptr'].toString(),
        //     gstValue: data[i]['pricing']['gst_value'].toString(),
        //     finalOrderValue: data[i]['pricing']['final_order_value'].toString(),
        //   );

        //   fetchedItems.add(item);
        //   totalPrice +=
        //       double.parse(data[i]['pricing']['final_order_value'].toString());
        // }

        // setState(() {
        //   cartItems = fetchedItems;
        //   finalPrice = totalPrice;
        // });
      } else {
        showAlert(
            'Failed to fetch cart items. Please try again or contact admin.');
      }
    } catch (e) {
      showAlert(
          'An error occurred while fetching cart items. Please try again.$e');
    }
  }

  Future<void> deleteCartItem(String id) async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart/del');
    final authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'auth-token': authToken,
        },
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        fetchCartItems();
        dispatchCustomEvent((cartData.length - 1).toString(), 'CartDelete');
      } else {
        showAlert(
            'Sorry, we cannot delete this item. Please try again or contact admin.');
      }
    } catch (e) {
      showAlert('An error occurred while deleting the item. Please try again.');
    }
  }

  Future<void> updateCartItem(
      String id, String productId, String quantity) async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart/update');
    final authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'auth-token': authToken,
        },
        body: jsonEncode({
          'id': id,
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        fetchCartItems();
      } else if (response.statusCode == 422) {
        showAlert(
            'Sorry, but quantity cannot be less than the minimum quantity.');
      } else {
        showAlert('Your total bill value must be more than ₹20000.');
        fetchCartItems();
      }
    } catch (e) {
      showAlert('An error occurred while updating the item. Please try again.');
    }
  }

  Future<void> placeOrder(BuildContext context) async {
    String authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    final response = await http.get(
      Uri.parse('https://pharmabag.in:3000/buyer/auth/cart'),
      headers: {
        'auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final cartItems = data['result_cart'];

      if (cartItems.length > 0) {
        final orderResponse = await http.post(
          Uri.parse('https://pharmabag.in:3000/buyer/auth/order/placed'),
          headers: {
            'content-type': 'application/json',
            'auth-token': authToken,
          },
          body: jsonEncode({
            'order_token': data['order_token'],
            'order_status': 'Placed',
            'order_payment_details': 'Not paid',
          }),
        );

        if (orderResponse.statusCode == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Order Placed'),
                content: const Text(
                  'Your order is successfully placed! Now make payment after seller accepts your request.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderScreen()),
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

  TextEditingController quantity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: cartData.isEmpty
          ? const Center(
              child: Text(
                'No items in the cart',
                style: TextStyle(color: primaryColor),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cartItem = cartData[index];
                      quantity.text = cartItem['quantity'].toString();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            leading: Image.network(cartItem['product_image'],
                                errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://pharmabag.in/image/logo/logo-edited.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              );
                            }),
                            title: Column(
                              children: [
                                Text(
                                  cartItem['product_name'],
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        '₹${cartItem['product_price']}/unit',
                                        style:
                                            const TextStyle(color: greyColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        'PTR - ₹${(double.parse(cartItem['quantity'].toString()) * double.parse(cartItem['pricing']['per_ptr'])).toStringAsFixed(2)}',
                                        style:
                                            const TextStyle(color: greyColor),
                                      ),
                                    ),
                                    Text(
                                      'GST - ₹${(double.parse(cartItem['quantity'].toString()) * double.parse(cartItem['pricing']['gst_value'])).toStringAsFixed(2)}',
                                      style: const TextStyle(color: greyColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      updateCartItem(
                                          cartItem['cart_id'],
                                          cartItem['product_id'],
                                          (int.parse(quantity.text) - 1)
                                              .toString());

                                      setState(() {
                                        fetchCartItems();
                                        quantity.text =
                                            (int.parse(quantity.text) - 1)
                                                .toString();
                                        print(quantity.text);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 50,
                                    child: TextFormField(
                                      initialValue:
                                          cartItem['quantity'].toString(),
                                      onChanged: (value) {
                                        updateCartItem(
                                            cartItem['cart_id'],
                                            cartItem['product_id'],
                                            (int.parse(value)).toString());
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    ),
                                    onPressed: () {
                                      updateCartItem(
                                          cartItem['cart_id'],
                                          cartItem['product_id'],
                                          (int.parse(quantity.text) + 1)
                                              .toString());

                                      setState(() {
                                        fetchCartItems();
                                        quantity.text =
                                            (int.parse(quantity.text) + 1)
                                                .toString();
                                      });
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        deleteCartItem(cartItem['cart_id']);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: primaryColor,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () {
                          placeOrder(context);
                        },
                        child: Text(
                            'Place Your Order | ₹${totalPrice.toStringAsFixed(2)}'),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
