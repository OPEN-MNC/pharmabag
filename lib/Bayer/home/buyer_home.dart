import 'package:flutter/material.dart';
import 'package:pharmabag/Bayer/Main/product_page.dart';
import 'package:pharmabag/Bayer/home/account_buyer_screen.dart';
import 'package:pharmabag/Bayer/home/home_screen.dart';
import '../../components_&_color/color.dart';
import '../components/ordersScreen_test.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({Key? key, required this.isLoggedIn}) : super(key: key);
  final bool isLoggedIn;
  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
          ),
          child: const TabBar(
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: greyColor,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(
                    Icons.shop_outlined,
                  ),
                  text: "Shop",
                ),
                Tab(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  text: "My Orders",
                ),
                Tab(
                  icon: Icon(
                    Icons.person_outline,
                  ),
                  text: "Account",
                ),
              ]),
        ),
        body: TabBarView(children: [
          HomeScreen(
            isLoggedIn: widget.isLoggedIn,
          ),
          const AllProducts(),
          OrderScreen(),
          const AccountScreen(),
        ]),
      ),
    );
  }
}
