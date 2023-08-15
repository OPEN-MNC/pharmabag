import 'package:pharmabag/Seller/pages_view/drawer.dart';
import 'package:pharmabag/Seller/pages_view/product_page.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';

import 'package:pharmabag/reusable_components/containers.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({Key? key}) : super(key: key);

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(5, 12, 9, 214),
      key: scaffoldKey,
      drawer: const Drawer(
        child: drawerPage(),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
            title: const ReusableText(
                text: "Home", fontSize: 18, fontcolor: primaryColor),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                  debugPrint('side bar icon pressed do sonthing');
                },
                icon: const Icon(
                  Icons.sort,
                  color: primaryColor,
                  size: 30,
                )),
            actions: const [
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    "https://www.tatatrusts.org/images/Ratan_N_Tata_sm.jpg"),
              ),
            ]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
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
              const ReusableText(
                  text: "Total Sales This month",
                  fontSize: 17,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 6,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: "₹1,52,933", fontSize: 22, fontcolor: blackColor),
                  ReusableText(text: "-12.7%", fontSize: 22, fontcolor: red),
                ],
              ),

              const SizedBox(
                height: 6,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                      text: "Last Update 12min ago ",
                      fontSize: 11,
                      fontcolor: blackColor),
                  ReusableText(
                      text: "Since last month", fontSize: 11, fontcolor: red),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableContainer(
                    width: 150.0,
                    height: 150.0,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22, top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: greenColor,
                          ),
                          Spacer(),
                          ReusableText(
                              text: "47", fontSize: 22, fontcolor: blackColor),
                          Spacer(),
                          ReusableText(
                              text: "Pending order",
                              fontSize: 13,
                              fontcolor: primaryColor),
                          Spacer(),
                          ReusableText(
                              text: "Tap to view",
                              fontSize: 12,
                              fontcolor: greyColor),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                  // -----------------------------------------------------------------------------------------

                  ReusableContainer(
                    width: 150.0,
                    height: 150.0,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22, top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: red,
                          ),
                          Spacer(),
                          ReusableText(
                              text: "6", fontSize: 22, fontcolor: blackColor),
                          Spacer(),
                          ReusableText(
                              text: "Out of stock",
                              fontSize: 13,
                              fontcolor: primaryColor),
                          Spacer(),
                          ReusableText(
                              text: "Tap to view",
                              fontSize: 12,
                              fontcolor: greyColor),
                          Spacer(),
                        ],
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
                  ReusableContainer(
                    width: 150.0,
                    height: 150.0,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22, top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: orangeColor,
                          ),
                          Spacer(),
                          ReusableText(
                              text: "17", fontSize: 22, fontcolor: blackColor),
                          Spacer(),
                          ReusableText(
                              text: "Slow moving",
                              fontSize: 13,
                              fontcolor: primaryColor),
                          Spacer(),
                          ReusableText(
                              text: "Tap to view",
                              fontSize: 12,
                              fontcolor: greyColor),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),

                  // -----------------------------------------------------------------------------------------

                  ReusableContainer(
                    width: 150.0,
                    height: 150.0,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 22, top: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: primaryColor,
                          ),
                          Spacer(),
                          ReusableText(
                              text: "7", fontSize: 22, fontcolor: blackColor),
                          Spacer(),
                          ReusableText(
                              text: "Close to expiry",
                              fontSize: 13,
                              fontcolor: primaryColor),
                          Spacer(),
                          ReusableText(
                              text: "Tap to view",
                              fontSize: 12,
                              fontcolor: greyColor),
                          Spacer(),
                        ],
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
                  ReusableText(
                      text: "View more", fontSize: 15, fontcolor: greyColor),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              SfCartesianChart(

                  // plotAreaBorderColor: primaryColor,
                  borderColor: primaryColor,
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        // Bind data source
                        dataSource: <SalesData>[
                          SalesData('Jan', 18),
                          SalesData('Feb', 28),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 25),
                          SalesData('Jun', 10),
                          SalesData('Jul', 38),
                          SalesData('Aug', 48),
                          SalesData('Sep', 15),
                          SalesData('Oct', 20),
                          SalesData('Nov', 10),
                          SalesData('Dec', 5)
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales)
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
                  text: "Top selling products",
                  fontSize: 17,
                  fontcolor: blackColor),

              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //   padding: const EdgeInsets.only(top: 20,bottom: 15),
              //   itemCount: 2,
              //   itemBuilder: (context , index) {
              //   return Padding(
              //     padding: const EdgeInsets.only(bottom: 2,top: 20),
              //     child: Expanded(
              //       child: ReusableContainer(

              //         height: 140,
              //         width: 315,
              //         color: whiteColor,
              //         child: Column(
              //           children: [

              //             Padding(
              //               padding: const EdgeInsets.only(left: 17,top: 20),
              //               child: Row(

              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Image.network(
              //                     'https://suidawai.com/wp-content/uploads/2022/09/aml0045.webp',
              //                     width: 80, // set the width of the image
              //                     height: 60, // set the height of the image
              //                     fit: BoxFit.cover, // set how the image should be scaled to fit its container
              //                   ),

              //                   SizedBox(width: 10,),

              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     // mainAxisAlignment: MainAxisAlignment.start,
              //                     children:  [

              //                       ReusableText(text: "Amlokind 5mg Tablet", fontSize: 11, fontcolor: primaryColor),
              //                       SizedBox(height: 4,),

              //                       ReusableText(text: "MANUFACTURER Mankind Pharma Ltd", fontSize: 10, fontcolor: greyColor),

              //                     ],
              //                   ),

              //                 ],
              //               ),
              //             ),

              //             SizedBox(height: 10,),

              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               children: [
              //                 Column(
              //                   children: [
              //                     Text("MRP",style: GoogleFonts.inter(textStyle: const TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 10),),),
              //                     SizedBox(height: 8,),
              //                     Text("₹67.18",style: GoogleFonts.inter(textStyle: const TextStyle(color: blackColor,fontWeight: FontWeight.w500,fontSize: 11),),),
              //                   ],
              //                 ),

              //                 Column(
              //                   children: [
              //                     Text("PTR",style: GoogleFonts.inter(textStyle: const TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 10),),),
              //                     SizedBox(height: 8,),
              //                     Text("₹25.3",style: GoogleFonts.inter(textStyle: const TextStyle(color: blackColor,fontWeight: FontWeight.w500,fontSize: 11),),),
              //                   ],
              //                 ),

              //                 Column(
              //                   children: [
              //                     Text("Unit Sold",style: GoogleFonts.inter(textStyle: const TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 10),),),
              //                     SizedBox(height: 8,),
              //                     Text("6542",style: GoogleFonts.inter(textStyle: const TextStyle(color: blackColor,fontWeight: FontWeight.w500,fontSize: 11),),),
              //                   ],
              //                 ),

              //                 Column(
              //                   children: [
              //                     Text("Total sale value",style: GoogleFonts.inter(textStyle: const TextStyle(color: primaryColor,fontWeight: FontWeight.w500,fontSize: 10),),),
              //                     SizedBox(height: 8,),
              //                     Text("1458526",style: GoogleFonts.inter(textStyle: const TextStyle(color: blackColor,fontWeight: FontWeight.w500,fontSize: 11),),),
              //                   ],
              //                 ),

              //               ],
              //             ),

              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // })

              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 20),
                      child: Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductImagesPage()),
                            );
                          },
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
                                    children: [
                                      Image.network(
                                        'https://suidawai.com/wp-content/uploads/2022/09/aml0045.webp',
                                        width: 80,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ReusableText(
                                              text: "Amlokind 5mg Tablet",
                                              fontSize: 11,
                                              fontcolor: primaryColor),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          ReusableText(
                                              text:
                                                  "MANUFACTURER Mankind Pharma Ltd",
                                              fontSize: 10,
                                              fontcolor: greyColor),
                                        ],
                                      ),
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
                                        Text("MRP",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("₹67.18",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11))),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("PTR",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("₹25.3",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11))),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Unit Sold",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("6542",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11))),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Total sale value",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text("1458526",
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
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
