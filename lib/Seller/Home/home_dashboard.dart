import 'dart:convert';
import 'package:http/http.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/Seller/Notifications/notifications.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/repositories/auth_repo/auth_repo.dart';
import 'package:pharmabag/repositories/dashboard_repo/dashboard.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import '../drawer.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({Key? key}) : super(key: key);

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  @override
  void initState() {
    getDash();
    getDetails();
    getOrders();
    super.initState();
  }

  var dashData;
  List<dynamic> slowmoving = [];
  List<dynamic> nearExpiry = [];
  List<dynamic> outofstockproductcount = [];
  List<dynamic> dashboard = [];
  List<dynamic> products = [];
  List<dynamic> slowmovers = [];
  String pendingOrders = '';
  var sellerData;
  List<dynamic> orders = [];
  List<dynamic> customOrders = [];
  List<dynamic> lastOrders = [];
  getOrders() async {
    var res = await AddStock().getOrders().then((value) async {
      setState(() {
        orders = value;
        lastOrders.add(orders.first);
      });
      var res1 = await AddStock().getCustomOrders().then((value) {
        setState(() {
          customOrders = value;
          lastOrders.add(customOrders.first);
        });
      });
    });
    debugPrint('The last orders are $lastOrders');
  }

  getDetails() async {
    Response res = await AuthRepo().getSellerProfile();
    // print(res.body);
    sellerData = jsonDecode(res.body);
  }

  getDash() async {
    Response res = await DashboardRepo().getDashboardDetails();
    // print(res.body);
    setState(() {
      dashData = jsonDecode(res.body);
      // print(dashData['slowmoving'].runtimeType);
      slowmoving = dashData['slowmoving'];
      nearExpiry = dashData['nearexpirycount'];
      outofstockproductcount = dashData['outofstockproductcount'];
      dashboard = dashData['dashboard'];
      // print(dashboard.length);
      pendingOrders = dashData['pending_orders_count'].toString();
    });

    await AddStock().getStocks().then((value) {
      products = value['result_products'];
      setState(() {});
    });

    products.where((element) {
      for (int i = 0; i < slowmoving.length; i++) {
        if (slowmoving[i]['_id'] == element['_id']) {
          setState(() {
            products.remove(element);
          });
        }
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(5, 12, 9, 214),
        // key: Keys().scaffoldKey,
        drawer: const Drawer(
          child: Drawers(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
              iconTheme: const IconThemeData(color: primaryColor),
              title: const ReusableText(
                  text: "Home", fontSize: 18, fontcolor: primaryColor),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              // leading: IconButton(
              //     onPressed: () {
              //       Keys().scaffoldKey.currentState!.openDrawer();
              //     },
              //     icon: const Icon(
              //       Icons.sort,
              //       color: primaryColor,
              //       size: 30,
              //     )),
              actions: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifications())),
                  child: const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),
                ),
              ]),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     IconButton(onPressed: () {
                //      debugPrint('side bar icon pressed do sonthing');},
                //       icon: Icon(Icons.sort,color: primaryColor,size: 30,)),

                //     CircleAvatar(
                //       backgroundColor: whiteColor,
                //       backgroundImage: NetworkImage("https://pharmabag.in/pharmabag-admin/assets/images/logo-icon.png"),
                //     ),
                //   ],
                // ),

                // SizedBox(height: 25,),

                // Text("Total Sales This month",style: GoogleFonts.inter(textStyle: TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 17),),),
                // const ReusableText(
                //     text: "Total Sales This month",
                //     fontSize: 17,
                //     fontcolor: primaryColor),
                // const SizedBox(
                //   height: 6,
                // ),

                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ReusableText(
                //         text: "₹1,52,933", fontSize: 22, fontcolor: blackColor),
                //     ReusableText(text: "-12.7%", fontSize: 22, fontcolor: red),
                //   ],
                // ),

                // const SizedBox(
                //   height: 6,
                // ),

                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ReusableText(
                //         text: "Last Update 12min ago ",
                //         fontSize: 11,
                //         fontcolor: blackColor),
                //     ReusableText(
                //         text: "Since last month", fontSize: 11, fontcolor: red),
                //   ],
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBarpage(
                                    gIndex: 4,
                                  ))),
                      child: ReusableContainer(
                        width: 150.0,
                        height: 150.0,
                        color: lightGrey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, top: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                color: greenColor,
                              ),
                              const Spacer(),
                              ReusableText(
                                  text: pendingOrders,
                                  fontSize: 22,
                                  fontcolor: blackColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Pending order",
                                  fontSize: 13,
                                  fontcolor: primaryColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Tap to view",
                                  fontSize: 12,
                                  fontcolor: greyColor),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // -----------------------------------------------------------------------------------------

                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.remove_shopping_cart_outlined,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Out of Stock',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  color: primaryColor,
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: whiteColor),
                                  ),
                                )
                              ],
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  height: 500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: ListView.builder(
                                      itemCount: outofstockproductcount.length,
                                      itemBuilder: (context, index) {
                                        var currentItem =
                                            outofstockproductcount[index];
                                        return Column(
                                          children: [
                                            SizedBox(
                                              child: ListTile(
                                                leading: Image.network(
                                                  currentItem['image_list'][0],
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.network(
                                                      "https://pharmabag.in/image/logo/logo-edited.png",
                                                      height: 80,
                                                      width: 80,
                                                      fit: BoxFit.contain,
                                                    );
                                                  },
                                                  frameBuilder: (context,
                                                      child,
                                                      frame,
                                                      wasSynchronouslyLoaded) {
                                                    return child;
                                                  },
                                                ),
                                                title: Text(currentItem[
                                                    'product_name']),
                                                subtitle: Text(currentItem[
                                                    'company_name']),
                                              ),
                                            ),
                                            const Divider(
                                              color: greyColor,
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            );
                          }),
                      child: ReusableContainer(
                        width: 150.0,
                        height: 150.0,
                        color: lightGrey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, top: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                color: red,
                              ),
                              const Spacer(),
                              ReusableText(
                                  text:
                                      outofstockproductcount.length.toString(),
                                  fontSize: 22,
                                  fontcolor: blackColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Out of stock",
                                  fontSize: 13,
                                  fontcolor: primaryColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Tap to view",
                                  fontSize: 12,
                                  fontcolor: greyColor),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.slideshow_outlined,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Slow Moving',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  color: primaryColor,
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: whiteColor),
                                  ),
                                )
                              ],
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  height: 500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ListView.builder(
                                      itemCount: products.length,
                                      itemBuilder: (context, index) {
                                        var currentItem = products[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 2),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                child: ListTile(
                                                  leading: Image.network(
                                                    currentItem['image_list']
                                                        [0],
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.network(
                                                          "https://pharmabag.in/image/logo/logo-edited.png",
                                                          height: 80,
                                                          width: 80,
                                                          fit: BoxFit.contain,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                        return Image.network(
                                                          "https://pharmabag.in/image/logo/logo-edited.png",
                                                          height: 80,
                                                          width: 80,
                                                          fit: BoxFit.contain,
                                                        );
                                                      });
                                                    },
                                                    fit: BoxFit.cover,
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  title: Text(
                                                      currentItem[
                                                              'product_name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          color: primaryColor)),
                                                  subtitle: Text(
                                                    'Stocks left : ${currentItem['stock'].toString()}',
                                                    style: const TextStyle(
                                                        color: greyColor),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                color: greyColor,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            );
                          }),
                      child: ReusableContainer(
                        width: 150.0,
                        height: 150.0,
                        color: lightGrey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, top: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                color: orangeColor,
                              ),
                              const Spacer(),
                              ReusableText(
                                  text: products.length.toString(),
                                  fontSize: 22,
                                  fontcolor: blackColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Slow moving",
                                  fontSize: 13,
                                  fontcolor: primaryColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Tap to view",
                                  fontSize: 12,
                                  fontcolor: greyColor),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // -----------------------------------------------------------------------------------------

                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                MaterialButton(
                                  color: primaryColor,
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: whiteColor),
                                  ),
                                )
                              ],
                              title: const Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.slideshow_outlined,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Close to Expiry',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ],
                              ),
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  height: 500,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: ListView.builder(
                                      itemCount: nearExpiry.length,
                                      itemBuilder: (context, index) {
                                        var currentItem = nearExpiry[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 2),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                child: ListTile(
                                                  leading: Image.network(
                                                      currentItem['image_list']
                                                          [0],
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                    return Image.network(
                                                      "https://pharmabag.in/image/logo/logo-edited.png",
                                                      height: 80,
                                                      width: 80,
                                                      fit: BoxFit.contain,
                                                    );
                                                  }),
                                                  title: Text(
                                                      currentItem[
                                                              'product_name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          color: primaryColor)),
                                                  subtitle: Text(
                                                    'Stocks left : ${currentItem['stock'].toString()}',
                                                    style: const TextStyle(
                                                        color: greyColor),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                color: greyColor,
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            );
                          }),
                      child: ReusableContainer(
                        width: 150.0,
                        height: 150.0,
                        color: lightGrey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22, top: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.shopping_bag_outlined,
                                color: primaryColor,
                              ),
                              const Spacer(),
                              ReusableText(
                                  text: nearExpiry.length.toString(),
                                  fontSize: 22,
                                  fontcolor: blackColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Close to expiry",
                                  fontSize: 13,
                                  fontcolor: primaryColor),
                              const Spacer(),
                              const ReusableText(
                                  text: "Tap to view",
                                  fontSize: 12,
                                  fontcolor: greyColor),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "Order Overview",
                        fontSize: 17,
                        fontcolor: blackColor),
                    // ReusableText(
                    //     text: "View more", fontSize: 15, fontcolor: greyColor),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                dashboard.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : SfCartesianChart(

                        // plotAreaBorderColor: primaryColor,
                        borderColor: primaryColor,
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                // Bind data source
                                dataSource: <SalesData>[
                                  SalesData('Jan', dashboard[0].toDouble()),
                                  SalesData('Feb', dashboard[1].toDouble()),
                                  SalesData('Mar', dashboard[2].toDouble()),
                                  SalesData('Apr', dashboard[3].toDouble()),
                                  SalesData('May', dashboard[4].toDouble()),
                                  SalesData('Jun', dashboard[5].toDouble()),
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ]),

                // SfCartesianChart(
                //   margin: EdgeInsets.all(0),
                //   borderWidth: 0,
                //   plotAreaBorderWidth: 0,
                //   borderColor: Colors.transparent,
                //   primaryXAxis: NumericAxis(minimum: 50,maximum: 200,isVisible: false,interval: 1,borderWidth: 0,borderColor: Colors.transparent),
                //   primaryYAxis: NumericAxis(minimum: 8,maximum: 12,
                //     interval: 1000,isVisible: false,borderWidth: 0,borderColor: Colors.transparent),
                //   series: <LineSeries<SalesData, String>>[
                //     LineSeries<SalesData, String>(
                //       // Bind data source
                //       dataSource:  <SalesData>[
                //         SalesData('Jan', 18),
                //         SalesData('Feb', 28),
                //         SalesData('Mar', 34),
                //         SalesData('Apr', 32),
                //         SalesData('May', 25),
                //         SalesData('Jun', 10),
                //         SalesData('Jul', 38),
                //         SalesData('Aug', 48),
                //         SalesData('Sep', 15),
                //         SalesData('Oct', 20),
                //         SalesData('Nov', 10),
                //         SalesData('Dec', 5)
                //       ],
                //       xValueMapper: (SalesData sales, _) => sales.year,
                //       yValueMapper: (SalesData sales, _) => sales.sales,
                // ),

                const SizedBox(
                  height: 25,
                ),
                const ReusableText(
                    text: "Latest Orders", fontSize: 17, fontcolor: blackColor),

                SizedBox(
                  height: 370,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      itemCount: lastOrders.length,
                      itemBuilder: (context, index) {
                        var current = lastOrders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 2, top: 10),
                          child: ReusableContainer(
                            height: 140,
                            width: 315,
                            color: whiteColor,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 17, top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            current['cart_details']
                                                ['product_image'],
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const CircleAvatar(
                                                  child: Icon(Icons.warning));
                                            },
                                            width:
                                                80, // set the width of the image
                                            height:
                                                60, // set the height of the image
                                            fit: BoxFit
                                                .cover, // set how the image should be scaled to fit its container
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                  text: current['cart_details']
                                                      ['product_name'],
                                                  fontSize: 11,
                                                  fontcolor: primaryColor),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              ReusableText(
                                                  text: current['cart_details']
                                                      ['company_name'],
                                                  fontSize: 10,
                                                  fontcolor: greyColor),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: index == 1
                                                      ? greenColor
                                                      : primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 3),
                                                child: Text(
                                                  index == 1
                                                      ? 'Custom'
                                                      : 'Normal',
                                                  style: const TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "MRP",
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          current['cart_details']
                                                  ['product_price']
                                              .toString(),
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "PTR",
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          current['cart_details']['pricing']
                                                  ['ptr']
                                              .toString(),
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Unit Sold",
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          current['cart_details']['quantity']
                                              .toString(),
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Date",
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          current['date']
                                              .toString()
                                              .substring(0, 10)
                                              .replaceAll('-', '/'),
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )

                // Card(

                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
