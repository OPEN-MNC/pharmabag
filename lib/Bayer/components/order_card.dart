import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

import '../theme/custom_theme.dart';
import 'package:http/http.dart' as http;
// List<Map<String, String>> productDate1 = [
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'false'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'false'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'false'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'false'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
//   {
//     "imageUrl":
//         "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
//     "title": "Tonact 5g tablets",
//     "subtitle": "Sold by SLS farm",
//     "MRP": "\$49.99",
//     "PTR": "\$27.18",
//     "isAccepted": 'true'
//   },
// ];

// class OrderCard1 extends StatelessWidget {
//   const OrderCard1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       scrollDirection: Axis.vertical,
//       itemCount: productDate.length,
//       itemBuilder: (context, index) {
//         var currentItem = productDate[index];
//         return Container(
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 // boxShadow: CustomTheme.cardShadow,
//                 borderRadius: BorderRadius.circular(10)),
//             child: ListTile(
//               leading: Image.network(
//                 "${currentItem['imageUrl']}",
//                 height: 50,
//               ),
//               title: Text(
//                 "${currentItem['title']}",
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 93, 90, 241),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//               ),
//               subtitle: Text(
//                 '09/12/2022',
//                 // "${currentItem['subtitle']}",
//                 style: const TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   '${currentItem['isAccepted']}' == 'true'
//                       ? Text(
//                           'Accepted',
//                           style: TextStyle(
//                               color: Colors.green,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold),
//                         )
//                       : Text(
//                           'Rejected',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold),
//                         ),
//                   // Container(
//                   //   padding: const EdgeInsets.only(left: 30),
//                   //   width: 80,
//                   //   height: 30,
//                   //   child: CupertinoButton(
//                   //     padding: const EdgeInsets.all(0),
//                   //     color: '${currentItem['isAccepted']}' == "true"
//                   //         ? Colors.green
//                   //         : Colors.grey,
//                   //     child: '${currentItem['isAccepted']}' == 'true'
//                   //         ? Text(
//                   //             'Accepted',
//                   //             style:
//                   //                 TextStyle(color: Colors.white, fontSize: 10),
//                   //           )
//                   //         : Text(
//                   //             'Rejected',
//                   //             style:
//                   //                 TextStyle(color: Colors.white, fontSize: 10),
//                   //           ),
//                   //     onPressed: () {},
//                   //   ),
//                   // ),
//                   Container(
//                     padding: const EdgeInsets.only(left: 10),
//                     width: 90,
//                     height: 30,
//                     child: CupertinoButton(
//                       padding: const EdgeInsets.all(0),
//                       color: '${currentItem['isAccepted']}' == 'true'
//                           ? const Color.fromARGB(255, 93, 90, 241)
//                           : Colors.grey,
//                       child: '${currentItem['isAccepted']}' == 'true'
//                           ? Text(
//                               'Make payment',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             )
//                           : Text(
//                               'Contact Admin',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 10),
//                             ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // child: Column(
//             //   children: [
//             //     Row(
//             //       children: [
//             //         Image.network(
//             //           "${currentItem['imageUrl']}",
//             //           height: 50,
//             //         ),
//             //         Column(
//             //           crossAxisAlignment: CrossAxisAlignment.start,
//             //           children: [
//             //             SizedBox(
//             //               height: 50,
//             //               width: 150,
//             //               child: ListTile(
//             //                   title: Text(
//             //                     "${currentItem['title']}",
//             //                     style: const TextStyle(
//             //                       color: Color.fromARGB(255, 93, 90, 241),
//             //                       fontWeight: FontWeight.bold,
//             //                       fontSize: 15,
//             //                     ),
//             //                   ),
//             //                   subtitle: Text(
//             //                     "${currentItem['subtitle']}",
//             //                     style: const TextStyle(
//             //                       fontSize: 12,
//             //                     ),
//             //                   )),
//             //             ),
//             //             Padding(
//             //               padding: const EdgeInsets.only(left: 18, top: 10),
//             //               child: Text(
//             //                 "${currentItem['MRP']}",
//             //               ),
//             //             )
//             //           ],
//             //         ),
//             //         Container(
//             //           padding: const EdgeInsets.only(left: 30),
//             //           width: 80,
//             //           height: 30,
//             //           child: CupertinoButton(
//             //             padding: const EdgeInsets.all(0),
//             //             color: Colors.green,
//             //             child: Text(
//             //               'Accepted',
//             //               style: TextStyle(color: Colors.white, fontSize: 10),
//             //             ),
//             //             onPressed: () {},
//             //           ),
//             //         ),
//             //         Container(
//             //           padding: const EdgeInsets.only(left: 10),
//             //           width: 90,
//             //           height: 30,
//             //           child: CupertinoButton(
//             //             padding: const EdgeInsets.all(0),
//             //             color: const Color.fromARGB(255, 93, 90, 241),
//             //             child: Text(
//             //               'Make payment',
//             //               style: TextStyle(color: Colors.white, fontSize: 10),
//             //             ),
//             //             onPressed: () {},
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //     const Divider(
//             //       color: Colors.black,
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'MRP :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$ 100',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'Discount type :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             'PTR discount',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'Final PTR Excluding GST :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$ 70.72',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'GST (12%) :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$0.08',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'Net Rate including Gst :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$79.21',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'Quentity :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$100 Strip',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Padding(
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: const [
//             //           Text(
//             //             'Final Payable Value :',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //           Text(
//             //             '\$7921.00',
//             //             style: TextStyle(fontSize: 12),
//             //           ),
//             //         ],
//             //       ),
//             //     ),
//             //     Row(
//             //       children: [
//             //         IconButton(
//             //           onPressed: () {},
//             //           icon: const Icon(
//             //             Icons.remove_circle,
//             //             color: Color.fromARGB(255, 93, 90, 241),
//             //           ),
//             //         ),
//             //         const Text(
//             //           "10",
//             //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             //         ),
//             //         IconButton(
//             //           onPressed: () {},
//             //           icon: const Icon(
//             //             Icons.add_circle,
//             //             color: Color.fromARGB(255, 93, 90, 241),
//             //           ),
//             //         ),
//             //         const SizedBox(
//             //           width: 150,
//             //         ),
//             //         SizedBox(
//             //           width: 50,
//             //           height: 30,
//             //           child: CupertinoButton(
//             //             padding: const EdgeInsets.all(0),
//             //             color: const Color.fromARGB(255, 93, 90, 241),
//             //             child: Text(
//             //               'Remove',
//             //               style: TextStyle(color: Colors.white, fontSize: 10),
//             //             ),
//             //             onPressed: () {},
//             //           ),
//             //         )
//             //       ],
//             //     ),
//             //   ],
//             // ),
//             );
//       },
//     );
//   }
// }

//  Column(
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.remove_circle,
//                             color: Color.fromARGB(255, 93, 90, 241),
//                           ),
//                         ),
//                         const Text(
//                           "10",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.add_circle,
//                             color: Color.fromARGB(255, 93, 90, 241),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 50,
//                       height: 30,
//                       child: CupertinoButton(
//                         padding: const EdgeInsets.all(0),
//                         color: const Color.fromARGB(255, 93, 90, 241),
//                         child: Text(
//                           'Remove',
//                           style: TextStyle(color: whiteColor, fontSize: 10),
//                         ),
//                         onPressed: () {},
//                       ),
//                     )
//                   ],
//                 ),

List productData = [
  // Add more items if needed
];

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  getMyOrders() async {
    var x = await http.get(
        Uri.parse("https://pharmabag.in:3000/buyer/auth/get/my/orders"),
        headers: {
          "content-type": "application/json",
          "auth-token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2RldGFpbHMiOnsiX2lkIjoiNjM5YjA1MTA0NzI3MzA3NDQyYWM1MjBhIiwicGhvbmVfbm8iOjYyOTc0NDA1MDAsInBhc3N3b3JkIjoiJDJiJDEwJHZjQXBjNENTSXlTTVNUeTdBd1c4UU94M2FxQkdKeTE4eVdrOFRrMEJmSEFJaTlDRlo4M3M2IiwiZXhwaXJlX3Bhc3N3b3JkIjoiMjAyMy0wNy0wN1QxNDozODoxNS40NDNaIiwiZGF0ZV90aW1lIjoiMjAyMi0xMi0xNVQxMToyOToyMC4wMDBaIiwibWVzc2FnZSI6IiIsImlzX3VzZXJfYmxvY2siOmZhbHNlLCJzdGF0dXMiOjEsIl9fdiI6MH0sImlhdCI6MTY4ODc0MDEwNCwiZXhwIjoxNjkxMzMyMTA0fQ.9VvOWNDC8ET7w-2xCCwNBPuPWshfHBsLNru5zN-S-6s"
        });
    var data = jsonDecode(x.body);
    setState(() {
      productData = data;
    });
    return data;
  }

  showAwaitingConfirmation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [Icon(Icons.remove_red_eye), Text("view BreakDown")],
        ),
        ReusebleTextButton(onPressed: () {}, child: const Text("Confirm")),
        ReusebleTextButton(onPressed: () {}, child: const Text("Cancel"))
      ],
    );
  }

  showPlaced() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [Icon(Icons.remove_red_eye), Text("view product")],
        ),
        ReusebleTextButton(onPressed: () {}, child: const Text("Modify")),
        ReusebleTextButton(onPressed: () {}, child: const Text("Cancel"))
      ],
    );
  }

  showSuccess() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [Icon(Icons.remove_red_eye), Text("view product")],
        ),
        ReusebleTextButton(
            onPressed: () {},
            child: const Row(
              children: [Icon(Icons.download), Text("Invoice")],
            ))
      ],
    );
  }

  showPayment(paymentDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [Icon(Icons.currency_rupee), Text("Payment Status: ")],
        ),
        paymentDetails.runtimeType != String &&
                paymentDetails["paymentlink"] != ""
            ? ReusebleTextButton(
                onPressed: () {},
                child: const Row(
                  children: [Icon(Icons.payment), Text("Make Full Payment")],
                ))
            : paymentDetails.runtimeType != String &&
                    paymentDetails["due"] != ""
                ? ReusebleTextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.payments),
                        Text("Pay Due ${paymentDetails["due"]}")
                      ],
                    ))
                : Container()
      ],
    );
  }

  Column buildOrderDetailsWidget(Map<String, dynamic> data, int index) {
    final orderStatus = data["order_status"];
    dynamic paymentDetails = data["order_payment_details"];
    final dueAmount = paymentDetails is Map
        ? double.tryParse(paymentDetails["due"].toString() ?? "") ?? 0
        : 0;
    final paymentLink =
        paymentDetails is Map ? paymentDetails["paymentlink"] : null;
    final isPartial =
        paymentDetails is Map ? paymentDetails["is_partial"] : null;

    return Column(
      children: [
        if (orderStatus == "awaiting confirmation")
          const ListTile(
            title: Text('Order Status:'),
            subtitle: Text('awaiting confirmation'),
          ),
        if (orderStatus == "accepted" && paymentDetails?["paymentlink"] != null)
          ListTile(
            title: const Text('Payment Status:'),
            subtitle: ElevatedButton(
                onPressed: () {}, child: const Text("Make Full Payment")),
            onTap: () {
              makePayment(
                  paymentDetails!["paymentlink"], paymentDetails["is_partial"]);
            },
          ),
        if ([
              "PAID",
              "way to warehouse",
              "sucessfull",
              "Reached warehouse",
              "Order in Transit",
              "Out for Delivery",
              "Order Shipped",
              "Transport delay"
            ].contains(orderStatus) &&
            dueAmount <= 0)
          const ListTile(
            title: Text('Payment Status:'),
            subtitle: Text('Thanks for Payment'),
          ),
        if (orderStatus == "partialpayment")
          ListTile(
            title: const Text('Partial Payment Status:'),
            subtitle: ElevatedButton(
                onPressed: () {
                  makePayment(paymentDetails!["paymentlink"],
                      paymentDetails["is_partial"]);
                },
                child: Text('Pay Due ₹${dueAmount.ceil()}')),
            onTap: () {
              makePayment(
                  paymentDetails!["paymentlink"], paymentDetails["is_partial"]);
            },
          ),
        if (orderStatus == "full credit")
          ListTile(
            title: const Text('Credit Payment Status:'),
            subtitle: Text('Pay Due ₹${dueAmount.ceil()}'),
            onTap: () {
              makePayment(
                  paymentDetails!["paymentlink"], paymentDetails["is_partial"]);
            },
          ),
        if (orderStatus == "sucessfull")
          ListTile(
            trailing: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  orderStatus,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }

  makePayment(link, ispartial) {}

  @override
  void initState() {
    getMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: productData.length,
      itemBuilder: (context, i) {
        var data = productData.reversed.toList()[i];
        var OrderStatus = data["order_status"];
        var payAmount = "Make Full Payment";
        var order_payment_details = data["order_payment_details"];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: CustomTheme.cardShadow,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                        "${data["cart_details"]["product_image"].replaceAll("https://pharmabag03.s3.ap-south-1.amazonaws.com/", "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_")}",
                        height: 60, errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://pharmabag.in/image/logo/logo-edited.png",
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      );
                    }),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['cart_details']['product_name']}",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 93, 90, 241),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${data['cart_details']['company_name']}",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // '${currentItem['isAccepted']}' == 'true'
                    //     ? Text(
                    //         'Accepted',
                    //         style: TextStyle(
                    //           color: Colors.green,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       )
                    //     : Text(
                    //         'Rejected',
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    // SizedBox(width: 10),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const ReusableText(
                            text: "Order Id",
                            fontSize: 14,
                            fontcolor: blackColor),
                        const SizedBox(
                          height: 3,
                        ),
                        ReusableText(
                            text: " ${data['order_id']}",
                            fontSize: 13,
                            fontcolor: primaryColor),
                      ],
                    ),
                    Column(
                      children: [
                        const ReusableText(
                            text: "Ordered Qty.",
                            fontSize: 14,
                            fontcolor: blackColor),
                        const SizedBox(
                          height: 3,
                        ),
                        ReusableText(
                            text: " ${data['cart_details']['quantity']}",
                            fontSize: 13,
                            fontcolor: primaryColor),
                      ],
                    ),
                    Column(
                      children: [
                        const ReusableText(
                            text: "Order Status",
                            fontSize: 14,
                            fontcolor: blackColor),
                        const SizedBox(
                          height: 3,
                        ),
                        ReusableText(
                            text: "$OrderStatus",
                            fontSize: 10,
                            fontcolor: greenColor),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                buildOrderDetailsWidget(data, i),

                ///awaiting confirmation starts

//------awaiting confirmation ends
              ],
            ),
          ),
        );
      },
    );
  }
}
