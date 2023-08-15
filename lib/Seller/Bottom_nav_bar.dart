import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmabag/Seller/Inventory/add_inventory.dart';
import 'package:pharmabag/Seller/Home/home_dashboard.dart';
import 'package:pharmabag/Seller/Settlements/settlement.dart';
import 'package:pharmabag/Seller/Stocks/stocks.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'Orders/order.dart';

class BottomNavBarpage extends StatefulWidget {
  final int gIndex;
  const BottomNavBarpage({Key? key, this.gIndex = 0}) : super(key: key);

  @override
  State<BottomNavBarpage> createState() => _BottomNavBarpageState();
}

class _BottomNavBarpageState extends State<BottomNavBarpage> {
  int selectedindex = 1;

  @override
  void initState() {
    setPage();
    super.initState();
  }

  setPage() {
    if (widget.gIndex == 2) {
      setState(() {
        selectedindex = 2;
        currentItemScreen = const settlePage();
      });
    } else if (widget.gIndex == 3) {
      setState(() {
        selectedindex = 3;
        currentItemScreen = const StokasPage();
      });
    } else if (widget.gIndex == 1) {
      selectedindex = 1;
      currentItemScreen = const HomeDashboardPage();
    } else if (widget.gIndex == 4) {
      selectedindex = 4;
      currentItemScreen = const OrderPage();
    }
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentItemScreen = const HomeDashboardPage();

  // final controller1 = Get.put(NavBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),

      // body: Obx(() => IndexedStack(
      //       index: navBarController.selectedIndex.value,
      //       children: pages_r,
      //     )),

      // body: Center(
      //   child:  _pages.elementAt(_selectedindex),
      // ),

      body: PageStorage(
        bucket: bucket,
        child: currentItemScreen,
      ),

      // bottomNavigationBar:  Container(
      //   decoration: BoxDecoration(
      //     color: primaryColor,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //   ),

      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 10),
      //     child: GNav(

      //       activeColor: Colors.white,
      //       backgroundColor: primaryColor,
      //       color: Colors.white,
      //       tabBackgroundColor: Color.fromARGB(148, 73, 130, 245),
      //       haptic: true,
      //       padding: EdgeInsets.all(13),
      //       gap: 8,
      //       tabs: const[
      //         GButton(
      //           icon: Icons.all_inbox,
      //           text: "Products",
      //         ),
      //         GButton(
      //           icon: Icons.shopping_cart,
      //           text: "Orders",
      //         ),
      //         GButton(
      //           icon: Icons.fact_check,
      //           text: "Settlement",
      //         ),
      //         GButton(
      //           icon: Icons.auto_graph,
      //           text: "Dashboard",
      //         ),
      //       ],
      // selectedIndex: _selectedindex,

      // onTabChange: (index) {
      //   setState(() {
      //     _selectedindex = index;
      //   });
      // },

      //     ),
      //   ),
      // ),

      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(

      //     indicatorColor: Color.fromARGB(33, 89, 0, 255),

      //     labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
      //     ),

      //   ),
      //   child: NavigationBar(
      //   height: 60,
      //   animationDuration: Duration(seconds: 2),

      //   selectedIndex: _selectedindex,

      //   destinations: [
      //   NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      //   NavigationDestination(icon: Icon(Icons.volunteer_activism), label: 'Settlement'),
      //   NavigationDestination(icon: Icon(Icons.add_circle), label: 'Add Stock'),
      //   NavigationDestination(icon: Icon(Icons.inventory), label: 'Stocks'),
      //   NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Orders'),
      // ],

      //       onDestinationSelected: (index) {
      //         setState(() {
      //           _selectedindex = index;
      //         });
      //       },
      // ),
      // ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
          onPressed: () {
            setState(() {
              currentItemScreen = const productAddForm();
              selectedindex = 5;
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentItemScreen = const HomeDashboardPage();
                        selectedindex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: selectedindex == 1 ? primaryColor : greyColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("Home",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: selectedindex == 1
                                      ? primaryColor
                                      : greyColor,
                                  fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentItemScreen = const settlePage();
                        selectedindex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.volunteer_activism,
                          color: selectedindex == 2 ? primaryColor : greyColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("Settlement",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: selectedindex == 2
                                      ? primaryColor
                                      : greyColor,
                                  fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentItemScreen = const StokasPage();
                        selectedindex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory,
                          color: selectedindex == 3 ? primaryColor : greyColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("Inventory",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: selectedindex == 3
                                      ? primaryColor
                                      : greyColor,
                                  fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentItemScreen = const OrderPage();
                        selectedindex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: selectedindex == 4 ? primaryColor : greyColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("Orders",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: selectedindex == 4
                                        ? primaryColor
                                        : greyColor),
                                fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
