import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';

import '../../Seller/pages_view/tickets.dart';
import '../components/order_card.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          "My Order",
          style: TextStyle(
            color: Color.fromARGB(255, 93, 90, 241),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: 200,
              padding: const EdgeInsets.only(top: 18.0),
              child: const OrderCard()),
        ],
      ),
    );
  }
}
