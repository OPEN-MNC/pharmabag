import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/components_&_color/search_bar.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:quickalert/quickalert.dart';
import '../Inventory/edit_product.dart';
import '../Notifications/notifications.dart';
import '../drawer.dart';

class StokasPage extends StatefulWidget {
  const StokasPage({Key? key}) : super(key: key);

  @override
  State<StokasPage> createState() => _StokasPageState();
}

class _StokasPageState extends State<StokasPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // List<String> _searchResults = [];

  // void _handleSearch(String query) {
  //   setState(() {
  //     _searchResults = ['Result 1', 'Result 2', 'Result 3'];
  //   });
  // }

  @override
  void initState() {
    getStocks();
    super.initState();
  }

  List<dynamic> stocks = [];
  List<dynamic> Xstocks = [];
  List stocksNewArray = [];
  bool isLoading = false;
  Color bccolor = const Color(0xFFF9F9F9);
  Color bccolor1 = const Color(0xFFF9F9F9);
  double heightVar = 0.0;
  bool filterVisiable = false;
  getStocks() async {
    setState(() {
      isLoading = true;
    });
    await AddStock().getStocks().then((value) {
      _storage
          .write(key: "tempStock", value: jsonEncode(value).toString())
          .then((value) => debugPrint("Yup stored to local"));
      // debugPrint('The value is ${value['result_products']}');
      setState(() {
        stocks = value['result_products'];

        Xstocks = stocks.reversed.toList();
      });
      stocksNewArray = stocks;

      // debugPrint(stocks.toString());
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  deleteProduct(String id) async {
    // ignore: unused_local_variable
    final res = AddStock().deleteProduct(id).then((value) {
      // print(value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    heightVar = MediaQuery.of(context).size.height - 270.0;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavBarpage(
                        gIndex: 1,
                      )));
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            drawer: const Drawer(
              child: Drawers(),
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
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
                ],
                iconTheme: const IconThemeData(color: primaryColor),
                title: const ReusableText(
                    text: "Inventory", fontSize: 18, fontcolor: primaryColor),
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
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            body: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusebleSearchBar(
                          hintText: 'Search with name...',

                          // onChanged: (query) => _handleSearch(query),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              _storage.read(key: 'tempStock').then((elements) {
                                var Xvalue = jsonDecode(elements!);

                                // debugPrint('The value is ${value['result_products']}');
                                setState(() {
                                  stocks = Xvalue['result_products'];

                                  Xstocks = stocks.reversed.toList();
                                  stocksNewArray = Xstocks;
                                });

                                // debugPrint(stocks.toString());
                              });
                            }

                            setState(() {
                              Xstocks = stocksNewArray;
                            });
                            Xstocks.retainWhere((element) {
                              return element["product_name"]
                                  .toLowerCase()
                                  .toString()
                                  .contains(value.toLowerCase());

                              //you can add another filter conditions too
                            });
                            if (Xstocks.isEmpty) {
                              Xstocks = stocksNewArray;
                            }
                          },
                        ),
                        // ReusebleSearchBar(onSearch: _handleSearch),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // const Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     ReusableText(
                    //         text: "Complete uploading",
                    //         fontSize: 17,
                    //         fontcolor: blackColor),
                    //   ],
                    // ),

                    // const SizedBox(
                    //   height: 10,
                    // ),

                    // ReusableContainer(
                    //   height: 90,
                    //   width: 360,
                    //   color: whiteColor,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 17, top: 17),
                    //     child: Column(
                    //       // mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const SizedBox(width:10),,
                    //         Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Image.network(
                    //               'https://cpimg.tistatic.com/05312844/b/5/Itraconazole-200mg-Tab.jpg',
                    //               width: 80, // set the width of the image
                    //               height: 60, // set the height of the image
                    //               fit: BoxFit
                    //                   .cover, // set how the image should be scaled to fit its container
                    //             ),
                    //             const SizedBox(
                    //               width: 10,
                    //             ),
                    //             const Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               // mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 ReusableText(
                    //                     text: "Itrasys 100 Capsule",
                    //                     fontSize: 11,
                    //                     fontcolor: primaryColor),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 ReusableText(
                    //                     text: "MANUFACTURER Mankind Pharma Ltd",
                    //                     fontSize: 10,
                    //                     fontcolor: greyColor),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(width:10),,
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 15,
                    // ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                                width: 90,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.tune,
                                      size: 18,
                                      color: blackColor,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        "filter by",
                                        style: TextStyle(
                                            color: blackColor, fontSize: 16),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              width: 90,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle:
                                          const TextStyle(color: blackColor),
                                      backgroundColor: bccolor1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              width: 0.8,
                                              color: primaryColor))),
                                  onPressed: () {
                                    Xstocks.retainWhere((element) {
                                      return ((DateTime.now()
                                                  .difference(DateTime.parse(
                                                      element['expire_date']))
                                                  .inDays) *
                                              -1) <
                                          60;

                                      //you can add another filter conditions too
                                    });

                                    setState(() {
                                      bccolor1 = primaryColor;
                                      filterVisiable = true;
                                    });
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 18,
                                        color: blackColor,
                                      ),
                                      Text(
                                        "Expired",
                                        textScaleFactor: 0.8,
                                        style: TextStyle(color: blackColor),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle:
                                          const TextStyle(color: blackColor),
                                      backgroundColor: bccolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: const BorderSide(
                                              width: 0.8,
                                              color: primaryColor))),
                                  onPressed: () {
                                    Xstocks.retainWhere((element) {
                                      return element["stock"] <= 1;

                                      //you can add another filter conditions too
                                    });

                                    setState(() {
                                      bccolor = primaryColor;
                                      filterVisiable = true;
                                    });
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 18,
                                        color: blackColor,
                                      ),
                                      Text(
                                        "Out Of stock",
                                        textScaleFactor: 0.8,
                                        style: TextStyle(color: blackColor),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                                visible: filterVisiable,
                                child: SizedBox(
                                  width: 130,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          textStyle: const TextStyle(
                                              color: blackColor),
                                          backgroundColor:
                                              const Color(0xFFF9F9F9),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: const BorderSide(
                                                  width: 2,
                                                  color: primaryColor))),
                                      onPressed: () {
                                        _storage
                                            .read(key: 'tempStock')
                                            .then((elements) {
                                          var Xvalue = jsonDecode(elements!);

                                          // debugPrint('The value is ${value['result_products']}');
                                          setState(() {
                                            stocks = Xvalue['result_products'];

                                            Xstocks = stocks.reversed.toList();
                                            stocksNewArray = Xstocks;
                                          });

                                          // debugPrint(stocks.toString());
                                        });

                                        setState(() {
                                          bccolor = const Color(0xFFF9F9F9);
                                          bccolor1 = const Color(0xFFF9F9F9);
                                          filterVisiable = false;
                                        });
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.close,
                                            size: 18,
                                            color: blackColor,
                                          ),
                                          Text(
                                            "clear filters",
                                            textScaleFactor: 0.8,
                                            style: TextStyle(color: blackColor),
                                          )
                                        ],
                                      )),
                                ))
                          ]),
                    ),

                    // const Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     ReusableText(
                    //         text: "Inventory",
                    //         fontSize: 17,
                    //         fontcolor: blackColor),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: SizedBox(
                        height: heightVar,
                        child: ListView.builder(
                            reverse: false,
                            itemCount: Xstocks.length,
                            itemBuilder: (context, index) {
                              heightVar =
                                  MediaQuery.of(context).size.height - 270.0;
                              var currentItem = Xstocks[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ReusableContainer(
                                      height: 170,
                                      width: 360,
                                      color: whiteColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17, top: 17),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: ((DateTime.now()
                                                                    .difference(
                                                                        DateTime.parse(
                                                                            currentItem['expire_date']))
                                                                    .inDays) *
                                                                -1) >
                                                            60
                                                        ? greenColor
                                                        : red,
                                                    width: 1,
                                                  )),
                                              child: Center(
                                                  child: ReusableText(
                                                      text: ((DateTime.now()
                                                                      .difference(DateTime.parse(
                                                                          currentItem[
                                                                              'expire_date']))
                                                                      .inDays) *
                                                                  -1) >
                                                              60
                                                          ? "Valid"
                                                          : "Expired",
                                                      fontSize: 11.5,
                                                      fontcolor: ((DateTime
                                                                          .now()
                                                                      .difference(
                                                                          DateTime.parse(
                                                                              currentItem['expire_date']))
                                                                      .inDays) *
                                                                  -1) >
                                                              60
                                                          ? greenColor
                                                          : red)),
                                            ),
                                            const SizedBox(width: 10),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    currentItem['image_list']
                                                            .toString()
                                                            .isEmpty
                                                        ? Image.network(
                                                            'https://pharmabag.in/image/logo/logo-edited.png',
                                                            width:
                                                                80, // set the width of the image
                                                            height:
                                                                60, // set the height of the image
                                                            fit: BoxFit
                                                                .cover, // set how the image should be scaled to fit its container
                                                          )
                                                        : Image.network(
                                                            currentItem['image_list']
                                                                    [0]
                                                                .replaceAll(
                                                                    "https://pharmabag03.s3.ap-south-1.amazonaws.com/",
                                                                    "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_"),
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Image
                                                                  .network(
                                                                'https://pharmabag.in/image/logo/logo-edited.png',
                                                                width:
                                                                    80, // set the width of the image
                                                                height:
                                                                    60, // set the height of the image
                                                                fit: BoxFit
                                                                    .cover, // set how the image should be scaled to fit its container
                                                              );
                                                            },
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent?
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  value: loadingProgress
                                                                              .expectedTotalBytes !=
                                                                          null
                                                                      ? loadingProgress
                                                                              .cumulativeBytesLoaded /
                                                                          loadingProgress
                                                                              .expectedTotalBytes!
                                                                              .toDouble()
                                                                      : null,
                                                                ),
                                                              );
                                                            },
                                                            frameBuilder: (context,
                                                                child,
                                                                frame,
                                                                wasSynchronouslyLoaded) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(4),
                                                                child: child,
                                                              );
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        ReusableText(
                                                            text: currentItem[
                                                                'product_name'],
                                                            fontSize: 11,
                                                            fontcolor:
                                                                primaryColor),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        ReusableText(
                                                            text: currentItem[
                                                                            'company_name']
                                                                        .toString()
                                                                        .length >
                                                                    30
                                                                ? "${currentItem['company_name'].toString().substring(0, 25)}..."
                                                                : currentItem[
                                                                    'company_name'],
                                                            fontSize: 10,
                                                            fontcolor:
                                                                greyColor),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        ReusableText(
                                                            text: DateTime.parse(
                                                                    currentItem[
                                                                        'expire_date'])
                                                                .toLocal()
                                                                .toString()
                                                                .substring(
                                                                    0, 11),
                                                            fontSize: 10,
                                                            fontcolor:
                                                                greyColor),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () =>
                                                        QuickAlert.show(
                                                            context: context,
                                                            type: QuickAlertType
                                                                .confirm,
                                                            title:
                                                                'Are you sure?',
                                                            cancelBtnText: 'No',
                                                            onCancelBtnTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            confirmBtnColor:
                                                                primaryColor,
                                                            confirmBtnText:
                                                                'Yes',
                                                            onConfirmBtnTap:
                                                                () async {
                                                              await AddStock()
                                                                  .deleteProduct(
                                                                      currentItem[
                                                                          '_id'])
                                                                  .then(
                                                                      (value) {
                                                                getStocks();
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            }),
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: primaryColor,
                                                    ))
                                              ],
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
                                                    const ReusableText(
                                                        text: "MRP",
                                                        fontSize: 10,
                                                        fontcolor:
                                                            primaryColor),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    ReusableText(
                                                        text: currentItem[
                                                                'product_price']
                                                            .toString(),
                                                        fontSize: 11,
                                                        fontcolor: blackColor),
                                                  ],
                                                ),

                                                Column(
                                                  children: [
                                                    const ReusableText(
                                                        text: "PTR",
                                                        fontSize: 10,
                                                        fontcolor:
                                                            primaryColor),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    ReusableText(
                                                        text: currentItem[
                                                                    'discount_details']
                                                                ['ptr']
                                                            .toString(),
                                                        fontSize: 11,
                                                        fontcolor: blackColor),
                                                  ],
                                                ),

                                                Column(
                                                  children: [
                                                    const ReusableText(
                                                        text: "Stock left",
                                                        fontSize: 9,
                                                        fontcolor:
                                                            primaryColor),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    ReusableText(
                                                        text:
                                                            currentItem['stock']
                                                                .toString(),
                                                        fontSize: 11,
                                                        fontcolor: blackColor),
                                                  ],
                                                ),

                                                // Column(
                                                //   children: [

                                                //     ReusableText(text: "Total sale value", fontSize: 10, fontcolor: primaryColor),
                                                //     SizedBox(height: 8,),
                                                //     ReusableText(text: "1458526", fontSize: 11, fontcolor: blackColor),

                                                //   ],
                                                // ),

                                                ReusebleButton(
                                                  buttonText: "view/edit",
                                                  buttoncolor: primaryColor,
                                                  textcolor: whiteColor,
                                                  onPressed: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => EditProduct(
                                                              productId:
                                                                  currentItem['_id']
                                                                      .toString(),
                                                              productName:
                                                                  currentItem['product_name']
                                                                      .toString(),
                                                              price: currentItem['product_price']
                                                                  .toString(),
                                                              chemical: currentItem['chemical_combination']
                                                                  .toString(),
                                                              company: currentItem['company_name']
                                                                  .toString(),
                                                              category:
                                                                  currentItem['categories']['category_name']
                                                                      .toString(),
                                                              subcategory:
                                                                  currentItem['categories']['sub_category_name']
                                                                      .toString(),
                                                              min: currentItem['min_order_qty']
                                                                  .toString(),
                                                              max: currentItem['max_order_qty'].toString(),
                                                              date: currentItem['expire_date'].toString().substring(0, 7),
                                                              gst: currentItem['discount_details']['gst'].toString(),
                                                              deliverytime: currentItem['extra_fields'][5].toString(),
                                                              totalAvailableQuantity: currentItem['stock'].toString(),
                                                              everything: currentItem))),
                                                  height: 30,
                                                  width: 82,
                                                  fontSize: 11,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     ReusebleTextButton(
                    //         onPressed: () {},
                    //         child: const ReusableText(
                    //             text: "See all",
                    //             fontSize: 15,
                    //             fontcolor: greyColor)),
                    //   ],
                    // ),

                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // ReusebleButton(
                    //   buttonText: "Update inventory",
                    //   buttoncolor: primaryColor,
                    //   textcolor: whiteColor,
                    //   onPressed: () {},
                    //   fontSize: 17,
                    // ),

                    const SizedBox(
                      height: 30,
                    ),

                    //  ReusebleTextfield(hintText: "enter name", controller: TextEditingController())
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
