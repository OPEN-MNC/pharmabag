// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:pharmabag/Bayer/components/filter_homepage.dart';
import 'package:pharmabag/Bayer/components/productdetails.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/Bayer/theme/custom_theme.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:http/http.dart' as http;

class AllProducts extends StatefulWidget {
  final List<dynamic> data;
  const AllProducts({Key? key, this.data = const []}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<dynamic>> products;
  var _dropDownValue = "12";
  var _dropDownValue1 = "_id";
  int nextoffset = 0;
  bool isloading = true;
  List<dynamic> finalData = [];
  String dataQ =
      "{\"gte\":\"\",\"lte\":\"\",\"city\":\"\",\"limit\":\"12\",\"sort\":\"_id\"}";
  @override
  void initState() {
    super.initState();

    getFilters();

    debugPrint("initstate");
    // if (widget.data.isEmpty) {
    //   initialFilters(0);
    // } else {
    //   setState(() {
    //     finalData = widget.data;
    //     nextoffset = widget.data.last['nextoffset'];
    //   });
    // }
    // product = getProducts();
    // check(widget.fromFilters);
    addCustomEventListener("filter_change", (data) {
      // print("jgvhjgj cadded ");
      dataQ = data;
      nextoffset = 0;
      finalData = [];

      getFilters();
    });
  }

  // check(bool filters) {
  //   if (filters == true) {
  //     addCustomEventListener("filter_change", (data) => getFilters(data));
  //   } else {
  //     initialFilters;
  //   }
  // }

  getFilters() async {
    String url = "https://pharmabag.in:3000/filter?skip=$nextoffset&q=$dataQ";
    http.Response res = await http.get(Uri.parse(url));
    List<dynamic> Data = [];
    Data = jsonDecode(res.body);

    nextoffset = int.parse(Data.last['nextoffset'].toString());
    Data.removeLast();
    for (var element in Data) {
      finalData.add(element);
    }
    setState(() {
      finalData = finalData;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BuyerHome(isLoggedIn: true)));
        return true;
      },
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: FloatingActionButton.extended(
              backgroundColor: primaryColor,
              onPressed: () {},
              label: Column(
                children: [
                  InkWell(
                    onTap: () => getFilters(),
                    child: Visibility(
                      visible: finalData.isNotEmpty,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        color: primaryColor,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'See More',
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isloading = true;
                      dataQ =
                          "{\"gte\":\"\",\"lte\":\"\",\"city\":\"\",\"limit\":\"12\",\"sort\":\"_id\"}";
                      getFilters();
                    },
                    child: Visibility(
                      visible: finalData.isEmpty,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        color: primaryColor,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'Clear Filters',
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: null,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'All Products',
            style: TextStyle(color: primaryColor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FilterProductsScreen(
                      isSeller: false,
                      dropdown: _dropDownValue,
                      dropdown1: _dropDownValue1,
                      offset: nextoffset.toString(),
                    );
                  }));
                },
                child: const Icon(
                  Icons.tune_outlined,
                  color: primaryColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
            height: 900,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: greyColor, width: 0.6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            underline: Container(),
                            borderRadius: BorderRadius.circular(6),
                            value: _dropDownValue,
                            hint: const Text('12'),
                            items: const [
                              DropdownMenuItem<String>(
                                value: '12',
                                child: Text('12'),
                              ),
                              DropdownMenuItem<String>(
                                value: '24',
                                child: Text('24'),
                              ),
                              DropdownMenuItem<String>(
                                value: '36',
                                child: Text('36'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                print("dataqis then ${jsonDecode(dataQ)}}");
                                var x = jsonDecode(dataQ);
                                x["limit"] = value.toString();
                                dataQ = jsonEncode(x);

                                _dropDownValue = value.toString();
                                debugPrint(_dropDownValue);
                              });
                              nextoffset = 0;
                              finalData = [];
                              getFilters();
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: greyColor, width: 0.6)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton(
                            underline: Container(),
                            value: _dropDownValue1,
                            hint: const Text('Default'),
                            items: const [
                              DropdownMenuItem<String>(
                                value: '_id',
                                child: Text('Relevance'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'product_name',
                                child: Text('Product Name'),
                              ),
                              DropdownMenuItem<String>(
                                value: '4',
                                child: Text('Discount(High-Low)'),
                              ),
                              DropdownMenuItem<String>(
                                value: '5',
                                child: Text('Discount(Low-High)'),
                              ),
                              DropdownMenuItem<String>(
                                value: '6',
                                child: Text('Price(High-Low)'),
                              ),
                              DropdownMenuItem<String>(
                                value: '7',
                                child: Text('Price(Low-High)'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                var x = jsonDecode(dataQ);
                                x["sort"] = value.toString();
                                dataQ = jsonEncode(x);
                                _dropDownValue1 = value.toString();
                                debugPrint(_dropDownValue1);
                              });
                              nextoffset = 0;
                              finalData = [];
                              getFilters();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 225,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: isloading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  0.62, // Adjust this value as needed
                            ),
                            itemCount: finalData.length,
                            itemBuilder: (context, index) {
                              var currentData = finalData[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProductDetails(
                                      productId: currentData['_id'],
                                    );
                                  }));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: CustomTheme.cardShadow,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Stack(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: currentData["image_list"] !=
                                                  null
                                              ? Image.network(
                                                  currentData["image_list"][0],
                                                  height: 80,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                  return Image.network(
                                                    "https://pharmabag.in/image/logo/logo-edited.png",
                                                    height: 80,
                                                    width: 80,
                                                    fit: BoxFit.contain,
                                                  );
                                                })
                                              : Container(
                                                  height: 60,
                                                  color: greyColor,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: const Center(
                                                      child: Text('no image')),
                                                ),
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                            child: ReusableText(
                                                text:
                                                    currentData['product_name']
                                                        .toString(),
                                                fontSize: 13,
                                                fontcolor: blackColor)),
                                        const SizedBox(height: 10),
                                        Center(
                                            child: ReusableText(
                                                text:
                                                    "${currentData['categories']['category_name']} > ${currentData['categories']['sub_category_name']}",
                                                fontSize: 13,
                                                fontcolor: blackColor)),
                                        Center(
                                            child: ReusableText(
                                                text:
                                                    "seller ${currentData['seller_id'].substring(0, 8)}xxxxx",
                                                fontSize: 11,
                                                fontcolor: primaryColor)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  'PTR',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ReusableText(
                                                    text:
                                                        "₹${currentData['discount_details']['per_ptr']}",
                                                    fontSize: 13,
                                                    fontcolor: blackColor),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  'MRP',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: primaryColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ReusableText(
                                                    text:
                                                        "₹${currentData['product_price']}",
                                                    fontSize: 13,
                                                    fontcolor: blackColor),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.transparent),
                                            elevation: MaterialStateProperty
                                                .all<double>(0),
                                          ),
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ProductDetails(
                                                productId: currentData['_id'],
                                              );
                                            }));
                                          },
                                          child: const ReusableContainer(
                                            height: 40,
                                            width: 180,
                                            color:
                                                primaryColor, // Replace with your desired color
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.shopping_bag,
                                                    color: whiteColor,
                                                    size:
                                                        18, // Replace with your desired color
                                                  ),
                                                  Text(
                                                    " View Details",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .white, // Replace with your desired color
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(left: 10, top: 10,bottom: 205),
                                    //   child: Container(
                                    //       width: 55,
                                    //       decoration: BoxDecoration(
                                    //           color: greenColor,
                                    //           borderRadius: BorderRadius.circular(5)),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.all(2.0),
                                    //         child: Center(
                                    //             child: ReusableText(
                                    //                 text: "New",
                                    //                 fontSize: 13,
                                    //                 fontcolor: whiteColor)),
                                    //       )),
                                    // ),
                                    Visibility(
                                      visible: ((DateTime.now()
                                              .difference(DateTime.parse(
                                                  currentData['date']))
                                              .inDays)) <
                                          60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 233),
                                        child: Container(
                                            width: 45,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Center(
                                                  child: ReusableText(
                                                      text: "New",
                                                      fontSize: 11,
                                                      fontcolor: whiteColor)),
                                            )),
                                      ),
                                    ),

                                    Visibility(
                                      visible: currentData[
                                                      "discount_form_details"]
                                                  ["buy"] !=
                                              "" &&
                                          currentData["discount_form_details"]
                                                  ["get"] !=
                                              '',
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 38, bottom: 206),
                                        child: Container(
                                            width: 45,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: orangeColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Center(
                                                  child: ReusableText(
                                                      text:
                                                          "${currentData["discount_form_details"]["buy"]}+${currentData["discount_form_details"]["get"]}",
                                                      fontSize: 11,
                                                      fontcolor: whiteColor)),
                                            )),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 68, bottom: 176),
                                      child: Container(
                                          width: 45,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Center(
                                                child: ReusableText(
                                                    text:
                                                        "-${currentData["discount_form_details"]["discountOnPtrOnlyPercenatge"] ?? 0}%",
                                                    fontSize: 11,
                                                    fontcolor: whiteColor)),
                                          )),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )
            // } else if (snapshot.hasError) {
            //   return Center(child: Text('Error: ${snapshot.error}'));
            // } else {
            //   return const Center(child: CircularProgressIndicator());
            // }

            ),
      ),
    );
  }
}
