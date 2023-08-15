// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:http/http.dart' as http;

class FilterProductsScreen extends StatefulWidget {
  final String dropdown;
  final String dropdown1;
  final String offset;
  const FilterProductsScreen(
      {Key? key,
      required this.isSeller,
      required this.dropdown,
      required this.dropdown1,
      required this.offset})
      : super(key: key);
  final bool isSeller;
  @override
  State<FilterProductsScreen> createState() => _FilterProductsScreenState();
}

class _FilterProductsScreenState extends State<FilterProductsScreen> {
  bool isClicked = false;
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;
  bool isClicked5 = false;
  bool isClicked6 = false;
  bool isClicked7 = false;
  bool isClicked8 = false;
  bool showonlynew = false;
  bool showonlybest = false;
  bool showonlydiscount = false;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // var _dropDownValue;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getCats();
    getSubs();
    super.initState();
  }

  setJSON() async {
    Map<String, dynamic> finalData = {
      "gte": minController.text.isEmpty ? '' : minController.text,
      "lte": maxController.text.isEmpty ? '' : maxController.text,
      "city": cityController.text.isEmpty ? '' : cityController.text,
      "showonlynew": showonlynew.toString(),
      "showonlybest": showonlybest.toString(),
      "showonlydiscount": showonlydiscount.toString(),
      "disctype": distype.length == 1 ? distype.first : distype,
      "category": categories.length == 1 ? categories.first : categories,
      "subcategory": subcategories.length == 1
          ? subcategories.first.toString()
          : subcategories,
      "limit": widget.dropdown,
      "sort": widget.dropdown1,
    };

    finalData.removeWhere((key, value) {
      return value == "false";
    });
    if (categories.isEmpty) {
      finalData.remove('category');
    }
    if (subcategories.isEmpty) {
      finalData.remove('subcategory');
    }
    if (distype.isEmpty) {
      finalData.remove('disctype');
    }

    var data = jsonEncode(finalData).toString();
    // String url = "https://pharmabag.in:3000/filter?skip=0&q=$data";

    // http.Response res = await http.get(Uri.parse(url));
    // List<dynamic> Data = [];
    // Data = jsonDecode(res.body);
    // print(Data);
    // _storage.write(key: 'query', value: data);
    dispatchCustomEvent(data, "filter_change");
    Navigator.pop(context);
  }

  List<String> distype = [];
  List<String> categories = [];
  List<String> subcategories = [];
  List<dynamic> catData = [];
  static const String urlCat =
      "https://pharmabag.in:3000/user/get/all/category";
  getCats() async {
    http.Response res = await http.get(Uri.parse(urlCat));
    setState(() {
      catData = jsonDecode(res.body);
      for (int i = 0; i < catData.length; i++) {
        catbools.add(false);
      }
      debugPrint(catData.runtimeType.toString());
    });
  }

  List<dynamic> subData = [];
  static const String urlsub =
      "https://pharmabag.in:3000/user/get/all/subcategory";
  getSubs() async {
    http.Response res = await http.get(Uri.parse(urlsub));
    setState(() {
      debugPrint(res.body);
      subData = jsonDecode(res.body);
      for (int i = 0; i < subData.length; i++) {
        subBools.add(false);
      }
      debugPrint(subData.runtimeType.toString());
    });
  }

  List<bool> catbools = [];

  List<bool> subBools = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
        child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            onPressed: () => setJSON(),
            label: Center(
                child: Container(
              height: 45,
              width: 150,
              color: primaryColor,
              child: const Center(
                  child: ReusableText(
                      text: "Apply", fontSize: 20, fontcolor: whiteColor)),
            ))),
      ),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: primaryColor,
              )),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Filter products',
            style: TextStyle(color: primaryColor),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FILTER BY PRICE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Min-00',
                        fillColor: Colors.grey,
                        border: OutlineInputBorder()),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: maxController,
                      decoration: const InputDecoration(
                          hintText: 'Max-5k',
                          fillColor: Colors.grey,
                          border: OutlineInputBorder()),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 10,
            ),
            widget.isSeller
                ? Container()
                : const Text(
                    'FILTER BY ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            widget.isSeller
                ? Container()
                : const Divider(
                    color: Colors.grey,
                  ),
            widget.isSeller
                ? Container()
                : ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: Checkbox(
                        value: isClicked,
                        onChanged: (v) {
                          setState(() {
                            isClicked = !isClicked;
                            showonlynew = !showonlynew;
                          });
                        }),
                    title: const Text(
                      'New Items',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
            widget.isSeller
                ? Container()
                : ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: Checkbox(
                        value: isClicked1,
                        onChanged: (v) {
                          setState(() {
                            isClicked1 = !isClicked1;
                            showonlybest = !showonlybest;
                          });
                        }),
                    title: const Text(
                      'Best Selling',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
            widget.isSeller
                ? Container()
                : ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: Checkbox(
                        value: isClicked2,
                        onChanged: (v) {
                          setState(() {
                            isClicked2 = !isClicked2;
                            showonlydiscount = !showonlydiscount;
                          });
                        }),
                    title: const Text(
                      'Discount Items',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              'LOCATION',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                  hintText: 'Kolkata',
                  fillColor: Colors.grey,
                  border: OutlineInputBorder()),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   decoration: InputDecoration(
            //       hintText: 'Pincode - 700 001',
            //       fillColor: Colors.grey,
            //       border: OutlineInputBorder()),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'DISCOUNT TYPE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // TextFormField(
            //   decoration: InputDecoration(
            //       hintText: 'Search ...',
            //       fillColor: Colors.grey,
            //       border: OutlineInputBorder()),
            // ),
            // ListTile(
            //   contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            //   leading: Checkbox(
            //       value: isClicked3,
            //       onChanged: (v) {
            //         setState(() {
            //           isClicked3 = v!;
            //         });
            //       }),
            //   title: const Text(
            //     'All',
            //     style: TextStyle(color: Colors.grey),
            //   ),
            // ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Checkbox(
                  value: isClicked4,
                  onChanged: (v) {
                    setState(() {
                      isClicked4 = !isClicked4;
                      if (distype.contains('ptr_discount')) {
                        distype.remove('ptr_discount');
                      } else {
                        distype.add('ptr_discount');
                      }
                    });
                  }),
              title: const Text(
                'Discount PTR Only',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Checkbox(
                  value: isClicked5,
                  onChanged: (v) {
                    setState(() {
                      isClicked5 = !isClicked5;
                      if (distype.contains('same_product_bonus')) {
                        distype.remove('same_product_bonus');
                      } else {
                        distype.add('same_product_bonus');
                      }
                    });
                  }),
              title: const Text(
                'Same Product Bonus',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Checkbox(
                  value: isClicked6,
                  onChanged: (v) {
                    setState(() {
                      isClicked6 = !isClicked6;
                      if (distype
                          .contains('ptr_discount_and_same_product_bonus')) {
                        distype.remove('ptr_discount_and_same_product_bonus');
                      } else {
                        distype.add('ptr_discount_and_same_product_bonus');
                      }
                    });
                  }),
              title: const Text(
                'Same Product Bonus & Discount',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              leading: Checkbox(
                  value: isClicked7,
                  onChanged: (v) {
                    setState(() {
                      isClicked7 = !isClicked7;
                      if (distype.contains('different_product_bonus')) {
                        distype.remove('different_product_bonus');
                      } else {
                        distype.add('different_product_bonus');
                      }
                    });
                  }),
              title: const Text(
                'Different Product Bonus & DisCount',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'CATEGORY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 280,
              width: 140,
              child: ListView.builder(
                itemCount: catData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: Checkbox(
                        value: catbools[index],
                        onChanged: (v) {
                          setState(() {
                            catbools[index] = !catbools[index];
                            if (categories
                                .contains(catData[index]['category_name'])) {
                              categories.removeWhere((element) =>
                                  element == catData[index]['category_name']);
                            } else {
                              categories.add(catData[index]['category_name']);
                            }
                          });
                        }),
                    title: Text(
                      catData[index]['category_name'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            const Text(
              ' SUB CATEGORY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 56.0 * subData.length,
              width: 160,
              child: ListView.builder(
                itemCount: subData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: Checkbox(
                        value: subBools[index],
                        onChanged: (v) {
                          subBools[index] = !subBools[index];
                          setState(() {
                            if (subcategories
                                .contains(subData[index]['subcategory_name'])) {
                              subcategories.removeWhere((element) =>
                                  element ==
                                  subData[index]['subcategory_name']);
                            } else {
                              subcategories
                                  .add(subData[index]['subcategory_name']);
                            }
                          });
                        }),
                    title: Text(
                      subData[index]['subcategory_name'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
