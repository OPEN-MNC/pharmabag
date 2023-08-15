// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  final bool camefromaccount;
  const OrderScreen({super.key, this.camefromaccount = false});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController controller = TextEditingController();
  List<dynamic> orders = []; // Replace this with your actual order data
  Map<dynamic, dynamic> dataList = {};
  getMyOrders() async {
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    var x = await http.get(
        Uri.parse("https://pharmabag.in:3000/buyer/auth/get/my/orders"),
        headers: {"content-type": "application/json", "auth-token": token});
    var data = jsonDecode(x.body);
    setState(() {
      orders = data;
    });
    return data;
  }

  getMileStoneDetails(id) async {
    var x = await http.get(
        Uri.parse("https://pharmabag.in:3000/get/milestone/$id"),
        headers: {
          "content-type": "application/json",
          "auth-token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s"
        });
    var data = jsonDecode(x.body);
    setState(() {
      dataList = data["milestone_details"];
    });
    return data;
  }

  Future makePayment(
      String link, int isPartial, double due, double finalPay) async {
    double amount = 0;
    if (isPartial != 0) {
      if (due == finalPay) {
        amount = double.parse(await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text("Seller Accepts Part Payment"),
              children: [
                SimpleDialogOption(
                  child: Column(
                    children: [
                      Text(
                          "First Installment is 25% which is ₹${(finalPay * 0.25).ceil()}"),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () => Navigator.pop(
                                context, (finalPay * 0.25).ceil().toString()),
                            child: Text("Pay ₹${(finalPay * 0.25).ceil()}"),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   child: const Text(
                          //       "Pay Custom Amount"), //on click open a textfield number type and get the vale and pass here at navigetor.pop
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
      } else {
        TextEditingController x = TextEditingController();
        amount = double.parse(await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text("Thanks for clearing First EMIs Installment"),
              children: [
                SimpleDialogOption(
                  child: Column(
                    children: [
                      const Text("Now You can pay any amount you want "),
                      TextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: x,
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context, x.text),
                          child: const Text("Pay Now"))
                    ],
                  ),
                ),
              ],
            );
          },
        ));
      }
    }

    Uri url =
        Uri.parse((link + (amount >= 0 ? amount.toString() : '1')).toString());

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (err) {}
  }

  Widget renderOrderStatus(dynamic order, index, context) {
    final orderStatus = order['order_status'];
    dynamic paymentDetails = order["order_payment_details"];
    final dueAmount = paymentDetails is Map
        ? double.tryParse(paymentDetails["due"].toString() ?? "") ?? 0
        : 0;
    final paymentLink =
        paymentDetails is Map ? paymentDetails["paymentlink"] : null;
    final isPartial =
        paymentDetails is Map ? paymentDetails["is_partial"] : null;

    if (orderStatus == 'awaiting confirmation') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Badge(
                color: Colors.green,
                text: orderStatus,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () => aWconfirmOrder(order['_id'], context),
            child: const Text('Confirm'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () => aWcancelOrder(order['_id'], context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => viewBreakdown(order['_id'], index, context),
            child: const Row(
              children: [
                Icon(Icons.visibility),
                SizedBox(width: 5),
                Text('View Breakdown'),
              ],
            ),
          ),
        ],
      );
    } else if (orderStatus == 'accepted' &&
        paymentDetails?.containsKey('paymentlink') == true) {
      return Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        child: Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  onPressed: () => makePayment(
                      paymentLink,
                      isPartial,
                      dueAmount.toDouble(),
                      double.parse(order["cart_details"]["pricing"]
                          ["final_order_value"])),
                  child: const Text('Make Full Payment')),
              const SizedBox(
                height: 5,
              ),
              const Badge(
                color: Colors.green,
                text: 'Order Accepted',
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('You get Free Delivery on this order'),
              ),
            ],
          ),
        ),
      );
    } else if ([
          'PAID',
          'way to warehouse',
          'sucessfull',
          'Reached warehouse',
          'Order in Transit',
          'Out for Delivery',
          'Order Shipped',
          'Transport delay'
        ].contains(orderStatus) &&
        dueAmount <= 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('Thanks for Payment'),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Badge(
                color: Colors.green,
                text: orderStatus,
              ),
            ],
          ),
        ],
      );
    } else if (orderStatus == 'partialpayment') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                makePayment(
                    paymentLink,
                    isPartial,
                    dueAmount.toDouble(),
                    double.parse(
                        order["cart_details"]["pricing"]["final_order_value"]));
                debugPrint("clicked due");
              },
              child: Text('Pay Due ₹${dueAmount.ceil()}')),
          const Row(
            children: [
              SizedBox(
                height: 10,
              ),
              Badge(
                color: Color.fromARGB(255, 0, 117, 123),
                text: 'Order Accepted',
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Free Delivery on Full Payment'),
        ],
      );
    } else if (orderStatus == 'full credit') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () {
                makePayment(paymentLink, isPartial, dueAmount.toDouble(),
                    order["cart_details"]["pricing"]["final_order_value"]);
              },
              child: Text('Pay Due ₹${dueAmount.ceil()}')),
          const Row(
            children: [
              Badge(
                color: Colors.green,
                text: 'full credit',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Free Delivery on Full Payment'),
          ),
        ],
      );
    } else if (orderStatus == 'sucessfull') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text('Successfull', style: TextStyle(color: Colors.green)),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Badge(
                color: Colors.green,
                text: orderStatus,
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Under Review', style: TextStyle(color: Colors.green)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Badge(
                  color: Colors.green,
                  text: orderStatus,
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget renderOrderActions(dynamic order, BuildContext context) {
    final orderStatus = order['order_status'];

    if (orderStatus == 'Placed') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => modifyOrder(order["_id"], context),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: primaryColor),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: whiteColor,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Modify Order',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              TextEditingController message = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Why you want to Cancel?'),
                    content: TextField(
                      controller: message,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('go Back'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 243, 33,
                                  33)), // Set the button background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Set the button text color
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight
                                    .bold), // Set the button text style
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24), // Set the button padding
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the button border radius
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Update the order details

                          setState(() {
                            cancelOrder(
                                order["cart_details"]["product_id"],
                                order["seller_id"],
                                message.text,
                                order["_id"],
                                context);
                          });

                          // Close the dialog
                        },
                        child: const Text('cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: whiteColor,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Cancel Order',
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      );
    } else if (orderStatus == 'sucessfull') {
      return TextButton(
        onPressed: () => generateInvoice(order),
        child: const Padding(
          padding: EdgeInsets.only(left: 3.0),
          child: Row(
            children: [
              Icon(Icons.download),
              SizedBox(width: 5),
              Text('Invoice'),
            ],
          ),
        ),
      );
    }
    return Container(); // Empty container for other order statuses
  }

  aWconfirmOrder(id, context) async {
    var x = await http.get(
        Uri.parse("https://pharmabag.in:3000/confirm/milestone/$id"),
        headers: {
          "content-type": "application/json",
          "auth-token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s"
        });
    var data = await jsonDecode(x.body);
    if (x.statusCode == 200) {
      showAlert(
          "Thanks for confirming! your order will reach you soon", context);
      getMyOrders();
    } else {
      showAlert("we cannot process now! try again after sometime.", context);
    }
    return data;
  }

  aWcancelOrder(id, context) async {
    var x = await http.get(
        Uri.parse("https://pharmabag.in:3000/cancel/milestone/$id"),
        headers: {
          "content-type": "application/json",
          "auth-token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s"
        });
    var data = await jsonDecode(x.body);
    if (x.statusCode == 200) {
      showAlert(
          "We are sorry to hear that!Don't worry order again hope this time it works.",
          context);
      getMyOrders();
    } else {
      showAlert("we cannot process now! try again after sometime.", context);
    }
    return data;
  }

  void viewBreakdown(dynamic order, int index, context) {
    // Implement your logic to view the breakdown of the order and while loading show a loder
    getMileStoneDetails(order).then((x) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Divided Order'),
            content: SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final entry = dataList.entries.toList()[index];
                  final date = entry.key;
                  final value = entry.value;
                  return ListTile(
                    title: Column(
                      children: [
                        Text(
                          "$value",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$date",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  if ("message".contains("updated!") ||
                      "message".contains("canceled!")) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  void modifyOrder(String orderId, context) {
    // Find the order index in the list
    final index = orders.indexWhere((order) => order['_id'] == orderId);
    //var index = 2;
    if (index != -1) {
      showDialog(
        context: context,
        builder: (context) {
          var modifiedOrder = orders[index]['cart_details']["quantity"];

          return AlertDialog(
            title: const Text('Modify Order Qantity'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (value) {
                modifiedOrder = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Update the order details

                  setState(() {
                    orders[index]['cart_details']["quantity"] = modifiedOrder;
                    updateOrder(
                        orders[index]['cart_details']["product_id"],
                        modifiedOrder,
                        orderId,
                        orders[index]['cart_details']["min_order_qty"],
                        context);
                  });

                  // Close the dialog
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }
  }

  void generateInvoice(dynamic order) async {
    Uri url = Uri.parse(
        ("https://pharmabag.in/invoiceGeneretor.php?generateInvoice=${Uri.encodeFull(jsonEncode(order))}")
            .toString());
    http.get(url);
    debugPrint("String $url");
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future updateOrder(String pid, qty, String order_id_now, int minq,
      BuildContext context) async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart');
    const authToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s";

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'auth-token': authToken,
      },
      body: jsonEncode({
        'product_id': pid,
        'quantity': qty,
        'price_details': jsonEncode({
          'delivery_date': DateTime.now().toIso8601String(),
        }),
      }),
    );

    if (response.statusCode == 422) {
      showAlert(
          'You must select a valid quantity to buy (More than Min qty $minq)',
          context);
      return;
    } else if (response.statusCode == 423) {
      showAlert(
          'You must contact admin. It seems this product is out of stock or removed by the seller',
          context);
      return;
    } else if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 402) {
      showAlert('You must login as a buyer first, then you can buy', context);
      // Redirect to register.php
      return;
    } else if (response.statusCode == 424) {
      showAlert('Your total bill value must be more than ₹20000', context);
      return;
    } else {
      final response = await http.get(
        Uri.parse('https://pharmabag.in:3000/buyer/auth/cart'),
        headers: {
          'auth-token': authToken,
        },
      );
      final data = jsonDecode(response.body);

      if (data['result_cart'].length > 0) {
        final response = await http.post(
          Uri.parse('https://pharmabag.in:3000/buyer/auth/order/placed'),
          headers: {
            'Content-Type': 'application/json',
            'auth-token': authToken,
          },
          body: jsonEncode({
            'order_token': data['order_token'],
            'order_status': 'Placed',
            'order_payment_details': 'Not paid',
          }),
        );

        if (response.statusCode == 200) {
          final del = await http.delete(
            Uri.parse(
                'https://pharmabag.in:3000/buyer/auth/order/placed/$order_id_now'),
            headers: {
              'auth-token': authToken,
            },
          );
          showAlert(
              'Your order is successfully updated! Now make payment after the seller accepts your request. Click OK to see your orders',
              context);

          if (del.statusCode != 200) {
            debugPrint('Cannot delete old order');
          } else {
            getMyOrders();
          }
          // Reload the page
        }
      }
    }
  }

  Future<void> cancelOrder(
      String pid, String sid, String mes, String order_id_now, context) async {
    if (await confirm('Are you sure to cancel this Order', context) == true) {
      final url =
          Uri.parse('https://pharmabag.in:3000/buyer/auth/get/my/orders');
      const authToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s";

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'auth-token': authToken,
        },
        body: jsonEncode({
          'product_id': pid,
          'seller_id': sid,
          'message': mes,
        }),
      );

      if (response.statusCode == 200) {
        showAlert('Your order is successfully canceled!', context);

        final del = await http.delete(
          Uri.parse(
              'https://pharmabag.in:3000/buyer/auth/order/placed/$order_id_now'),
          headers: {
            'auth-token': authToken,
          },
        );

        if (del.statusCode != 200) {
          debugPrint('Cannot delete this order. Please contact admin');
        } else {
          getMyOrders();
        }
        // Reload the page
      }
    }
  }

  void showAlert(String message, BuildContext context) {
    // Show an alert dialog with the message
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (message.contains("updated!") ||
                    message.contains("canceled!")) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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

  @override
  void initState() {
    // TODO: implement initState
    getMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.camefromaccount == true) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BuyerHome(isLoggedIn: true)));
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'My Orders',
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders.reversed.toList()[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 0,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        child: Text(
                          '${order['cart_details']['product_name']}',
                          style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Order Id',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '#${order['order_id']}',
                                      style: const TextStyle(color: greyColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const Text('Quantity',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      '${order['cart_details']['quantity']}',
                                      style: const TextStyle(color: greyColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          renderOrderStatus(order, index, context),
                        ],
                      ),
                    ),
                    renderOrderActions(order, context),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Color color;
  final String text;

  const Badge({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
