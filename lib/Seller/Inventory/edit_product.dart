// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/model/data.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:http/http.dart' as http;
import '../../components_&_color/color.dart';
import 'package:quickalert/quickalert.dart';

const List<String> list = <String>[
  'No Discount',
  'Discount on PTR only',
  'Same Product Bonus',
  'Same Product Bonus Plus Discount',
  'Different Product Bonus',
  'Different Product Bonus Plus Discount'
];

class EditProduct extends StatefulWidget {
  final String productId;
  final String productName;
  final String company;
  final String chemical;
  final String category;
  final String subcategory;
  final String date;
  final String gst;
  final String price;
  final String totalAvailableQuantity;
  final String min;
  final String max;
  final String deliverytime;
  final Map<String, dynamic> everything;

  // final String netRate;
  // final String ptr;
  const EditProduct({
    Key? key,
    required this.productId,
    required this.productName,
    required this.company,
    required this.chemical,
    required this.category,
    required this.subcategory,
    required this.date,
    required this.gst,
    required this.price,
    required this.totalAvailableQuantity,
    required this.min,
    required this.max,
    required this.deliverytime,
    required this.everything,
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  void initState() {
    _dropdownController2.addListener(() {
      _selectedItem2 = _dropdownController2.text;
    });
    // getStocks();
    setDetails();
    getSuggestion();
    getCategories();
    _dropdownController.addListener(() {
      _selectedItem = _dropdownController.text;
    });
    _dropdownController1.addListener(() {
      _selectedItem1 = _dropdownController1.text;
    });

    super.initState();
  }

  setDetails() {
    setState(() {
      productNameController.text = widget.productName.toString();
      companyNameController.text = widget.company.toString();
      chemical.text = widget.chemical.toString();
      categoryNameController.text = widget.category.toString();
      SubcategoryNameController.text = widget.subcategory.toString();
      expiry.text = widget.date.toString();
      maxQuantityController.text = widget.max.toString();
      minQuantityController.text = widget.min.toString();
      String receivedGST = widget.gst.replaceAll('.00', '%').toString();
      gstPercentController.text = receivedGST.toString();
      gst = receivedGST.toString();
      // gstPercentController.text = widget.gst;
      // gst = widget.gst;
      availableQuantityController.text =
          widget.totalAvailableQuantity.toString();
      mrpController.text = widget.price.toString();
      deliveryTimeController.text = widget.deliverytime.toString();
      setDiscount(
          widget.everything["discount_details"]["type"], widget.everything);
      ptpController.text =
          widget.everything["discount_details"]["per_ptr"].toString();
      netRateController.text =
          widget.everything["discount_details"]["final_ptr"].toString();
      imageToUplod = widget.everything['image_list'];
    });
  }

  pickDate() async {
    final selectedDate = await showMonthYearPicker(
            initialMonthYearPickerMode: MonthYearPickerMode.year,
            context: context,
            initialDate: DateTime(int.parse(expiry.text.substring(0, 4))),
            firstDate: DateTime.now(),
            lastDate: DateTime(9999))
        .then((value) {
      if (value != null) {
        setState(() {
          debugPrint(value.toString());
          expiry.text = value.toString().substring(0, 7);
        });
      }
    });
  }

  setBools(String value) {
    setState(() {
      _dropdownvalue = value;
      switch (_dropdownvalue) {
        case 'No Discount':
          {
            setState(() {
              showfirst = false;
              showsecond = false;
              showthird = false;
              showfourth = false;
            });
          }
          break;
        case 'Discount on PTR only':
          {
            setState(() {
              showfirst = true;
              showsecond = false;
              showthird = false;
              showfourth = false;
              showfifth = false;
            });
          }
          break;
        case 'Same Product Bonus':
          {
            setState(() {
              showfirst = false;
              showsecond = true;
              showthird = true;
              showfourth = false;
              showfifth = false;
            });
          }
          break;
        case 'Same Product Bonus Plus Discount':
          {
            setState(() {
              showfirst = true;
              showsecond = true;
              showthird = true;
              showfourth = false;
              showfifth = false;
            });
          }
          break;
        case 'Different Product Bonus':
          {
            setState(() {
              showfirst = false;
              showsecond = true;
              showthird = true;
              showfourth = true;
              showfifth = true;
            });
          }
          break;
        case 'Different Product Bonus Plus Discount':
          {
            setState(() {
              showfirst = true;
              showsecond = true;
              showthird = true;
              showfourth = true;
              showfifth = true;
            });
          }
          break;
      }
    });
  }

  final DateTime _selectedDate = DateTime.now();
  static const url = "https://pharmabag.in:3000/get/discount/details";
  String? gst;
  String? _selectedItem;
  String? _selectedItem1;
  String? _selectedItem2;
  String _dropdownvalue = list.first;
  List<String> dropdownItems = [];
  List<String> dropdownItems1 = [];
  List<String> products = [];
  List<categories> cat = [];
  List<subcategories> sub = [];
  List imageToUplod = [];
  final List<String> dropdownItems2 = ['5%', '12%', '18%'];
  final double _currentvalue = 0;
  bool showfirst = false;
  bool showsecond = false;
  bool showthird = false;
  bool showfourth = false;
  bool showfifth = false;
  final TextEditingController _dropdownController1 = TextEditingController();
  final TextEditingController _dropdownController2 = TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  TextEditingController fifth = TextEditingController();

  List<DropdownMenuItem> items = [];
  TextEditingController expiry = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController chemical = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController SubcategoryNameController = TextEditingController();
  TextEditingController availableQuantityController = TextEditingController();
  TextEditingController minQuantityController = TextEditingController();
  TextEditingController maxQuantityController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController gstPercentController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController netRateController = TextEditingController();
  TextEditingController ptpController = TextEditingController();
  TextEditingController productsController = TextEditingController();
  File? _image;

  var stock;

  List<String> stocks = [];
  getStocks() async {
    await AddStock().getStocks().then((value) {
      debugPrint('The value is ${value['result_products']}');

      List<Products> stock = [];

      for (int i = 0; i < value['result_products'].toList()!.length; i++) {
        stocks.add(
            value["result_products"].toList()[i]["product_name"].toString());
      }
      setState(() {
        stocks = stocks;
      });
    });
    // debugPrint(stocks.toString());
  }

  // getProduct(String id) async {
  //   final response = await AddStock().getStocks().then((value) {
  //     debugPrint('The value is ${value['result_products'].runtimeType}');
  //     debugPrint(value['result_products'].length.toString());
  //     List<dynamic> products = value['result_products'];
  //     for (int i = 0; i < products.length; i++) {
  //       if (products[i]['_id'] == id) {
  //         setState(() {
  //           stock = products[i];
  //           productNameController.text = stock['product_name'];
  //           companyNameController.text = stock['company_name'];
  //           chemical.text = stock['chemical_combination'];
  //           minQuantityController.text = stock['min_order_qty'].toString();
  //           maxQuantityController.text = stock['max_order_qty'].toString();
  //           categoryNameController.text =
  //               stock['categories']['category_name'].toString();
  //           deliveryTimeController.text = stock['extra_fields'][5];
  //           setDiscount(
  //               stock['discount_details']['type'], stock['discount_details']);
  //           mrpController.text = stock['product_price'].toString();

  //           expiry.text = stock['expire_date'].toString().substring(0, 7);
  //           debugPrint(stock.runtimeType.toString());
  //           setDiscount(stock['type'], stock);
  //         });
  //         debugPrint('The product is $stock');
  //       }
  //     }
  //   });
  // }

  setDiscount(String type, Map<String, dynamic> discountdetails) {
    setState(() {
      switch (type) {
        case 'ptr_discount':
          {
            if (double.parse(discountdetails["discount_form_details"]
                    ["discountOnPtrOnlyPercenatge"]) <=
                0.0) {
              {
                showfirst = false;
                showsecond = false;
                showthird = false;
                showfourth = false;
                showfifth = false;
                first.text = '';
                second.text = '';
                third.text = '';
                fourth.text = '';
              }
              break;
            } else {
              setState(() {
                _dropdownvalue = list[1];
                showfirst = true;
                showsecond = false;
                showthird = false;
                showfourth = false;
                showfifth = false;
                first.text = discountdetails["discount_form_details"]
                        ["discountOnPtrOnlyPercenatge"]
                    .toString();
              });
            }
          }
          break;
        case 'same_product_bonus':
          {
            setState(() {
              _dropdownvalue = list[2];
              showfirst = false;
              showsecond = true;
              showthird = true;
              showfourth = false;
              showfifth = false;

              second.text = discountdetails['discount_form_details']['buy'];
              third.text = discountdetails['discount_form_details']['get'];
            });
          }
          break;
        case 'ptr_discount_and_same_product_bonus':
          {
            setState(() {
              _dropdownvalue = list[3];
              showfirst = true;
              showsecond = true;
              showthird = true;
              showfourth = false;
              showfifth = false;

              first.text = discountdetails["discount_form_details"]
                      ["discountOnPtrOnlyPercenatge"]
                  .toString();
              second.text = discountdetails['discount_form_details']['buy'];
              third.text = discountdetails['discount_form_details']['get'];
            });
          }
          break;
        case 'different_product_bonus':
          {
            setState(() {
              _dropdownvalue = list[4];
              showfirst = false;
              showsecond = true;
              showthird = true;
              showfourth = true;
              showfifth = true;
              second.text = discountdetails['discount_form_details']['buy'];
              third.text = discountdetails['discount_form_details']['get'];
            });
          }
          break;
        case 'different_ptr_discount_and_same_product_bonus':
          {
            setState(() {
              _dropdownvalue = list[5];
              showfirst = true;
              showsecond = true;
              showthird = true;
              showfourth = false;
              showfifth = true;
            });
          }
          break;
      }
    });
  }

  List<String> categoryName = [];
  getCategories() async {
    final response = await http
        .get(Uri.parse('https://pharmabag.in:3000/user/get/all/category'))
        .then(
      (value) {
        if (value.statusCode == 200) {
          final data = jsonDecode(value.body);
          final list = data as List<dynamic>;

          for (int i = 0; i < list.length; i++) {
            setState(() {
              cat.add(categories.fromJson(list[i]));
            });
          }
          for (int i = 0; i < cat.length; i++) {
            setState(() {
              categoryName.add(cat[i].categoryName);
            });
          }
        }
      },
    );
  }

  getSuggestion() async {
    final response = await http
        .get(Uri.parse('https://pharmabag.in:3000/user/get/all/suggestion'))
        .then((value) {
      if (value.statusCode == 200) {
        final jsonResponse = jsonDecode(value.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          products.add(jsonResponse[i]['name']);
        }
      }
    });
  }

  getsub(String id) async {
    final response = await http
        .get(
            Uri.parse('https://pharmabag.in:3000/user/get/all/subcategory/$id'))
        .then(
      (value) {
        if (value.statusCode == 200) {
          final data = jsonDecode(value.body);
          final list = data as List<dynamic>;
          if (value.body.isEmpty) {
            setState(() {
              sub = [];
            });
          } else {
            for (int i = 0; i < list.length; i++) {
              setState(() {
                sub.add(subcategories.fromJson(list[i]));
              });
            }
          }
        }
      },
    );
  }

  void dropdownCallback(String? selectedvalue) {
    if (selectedvalue is String) {
      setState(() {
        _dropdownvalue = selectedvalue;
      });
    }
  }

  var discountformDetails;
  var discountDetails;
  getDiscountDetails() async {
    int number = 0;
    if (_dropdownvalue == 'No Discount') {
      number = 1;
      fourth.text = '0';
    } else {
      number = list.indexOf(_dropdownvalue);
    }
    final body = {
      "gstPercentage": gstPercentController.text.isEmpty
          ? ''
          : gstPercentController.text.replaceAll("%", ''),
      "mrp": mrpController.text.isEmpty ? '' : mrpController.text,
      "buy": second.text.isEmpty ? '' : second.text,
      "get": third.text.isEmpty ? '' : third.text,
      "producName": "",
      "maxQtySale": maxQuantityController.text.isEmpty
          ? 100
          : int.parse(maxQuantityController.text),
      "minQtySale": minQuantityController.text.isEmpty
          ? 10
          : int.parse(minQuantityController.text),
      "discountOnPtrOnlyPercenatge": first.text.isEmpty ? '' : first.text,
      "userBuy": maxQuantityController.text
    };
    setState(() {
      discountformDetails = jsonEncode(body).toString();
    });
    final data = jsonEncode(body);
    final response = await http.post(Uri.parse('$url/$number'),
        body: data,
        headers: {'content-type': 'application/json'}).then((value) {
      debugPrint(value.body);
      setState(() {
        discountDetails = value.body;
      });
      debugPrint(value.statusCode.toString());
      final res = jsonDecode(value.body);
      debugPrint(res['final_ptr']);
      setState(() {
        netRateController.text =
            res['final_ptr'].toString() == "0" ? '' : res['final_ptr'];
        ptpController.text =
            res['per_ptr'].toString() == "0" ? '' : res['per_ptr'];
      });
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const ReusableText(
                  text: "Name", fontSize: 15, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              EasyAutocomplete(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13),
                      hintText: 'Product Name',
                      hintStyle: const TextStyle(fontSize: 12)),
                  controller: productNameController,
                  suggestions: products,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    productNameController.text = value;
                  },
                  onSubmitted: (value) {}),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Company name", fontSize: 15, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: companyNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Company name"',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Chemical Combination",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: chemical,
                decoration: const InputDecoration(
                  hintText: 'Chemical Combination',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Select Category",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              // DropdownButtonFormField<String>(
              //   value: _selectedItem,
              //   decoration: InputDecoration(
              //     hintText: 'Select an option',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   items: cat.map((var cat) {
              //     return DropdownMenuItem(
              //       value: cat.categoryName,
              //       onTap: () {
              //         getsub(cat.sId);
              //         setState(() {});
              //       },
              //       child: Text(cat.categoryName),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedItem = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select an option';
              //     }
              //     return null;
              //   },
              // ),
              EasyAutocomplete(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13),
                      hintText: 'Category',
                      hintStyle: const TextStyle(fontSize: 12)),
                  controller: categoryNameController,
                  suggestions: categoryName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    categoryNameController.text = value;
                    for (int i = 0; i < cat.length; i++) {
                      if (cat[i].categoryName == value) {
                        getsub(cat[i].sId);
                      }
                    }
                  },
                  onSubmitted: (value) {}),
              const SizedBox(
                height: 15,
              ),
              const ReusableText(
                  text: "Select Sub-Category",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              EasyAutocomplete(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13),
                      hintText: 'Sub Category',
                      hintStyle: const TextStyle(fontSize: 12)),
                  controller: SubcategoryNameController,
                  suggestions: const [],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    categoryNameController.text = value;
                    for (int i = 0; i < cat.length; i++) {
                      if (cat[i].categoryName == value) {
                        getsub(cat[i].sId);
                      }
                    }
                  },
                  onSubmitted: (value) {}),

              // DropdownButtonFormField<String>(
              //   value: _selectedItem1,
              //   decoration: InputDecoration(
              //     hintText: 'Select an option',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              //   items: sub.map((var cat) {
              //     return DropdownMenuItem(
              //       value: cat.subcategoryName,
              //       onTap: () async {
              //         setState(() {});
              //       },
              //       child: Text(cat.subcategoryName),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedItem1 = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select an option';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(
                height: 10,
              ),
              const ReusableText(
                  text: "Expiry date", fontSize: 15, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: expiry,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: 'Expiry Date',
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: primaryColor, width: 0.6)),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final selectedData = await showDatePicker(
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(9999))
                              .then((value) {
                            expiry.text = value.toString().substring(0, 7);
                          });
                        },
                        icon: const Icon(Icons.calendar_month))),
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                            text: "GST", fontSize: 13, fontcolor: primaryColor),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton(
                            value: gst,
                            hint: const Text("GST"),
                            items: dropdownItems2.map((var option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                gst = value.toString();
                                gstPercentController.text =
                                    value.toString().replaceAll('%', '');
                                getDiscountDetails();
                              });
                            })
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 125,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ReusableText(
                            text: "MRP", fontSize: 13, fontcolor: primaryColor),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          onChanged: (value) => getDiscountDetails(),
                          keyboardType: TextInputType.number,
                          controller: mrpController,
                          decoration: const InputDecoration(
                              hintText: 'Amt in Rs.',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Total Available Quantity",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              TextField(
                controller: availableQuantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Quantity',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Select Quantity",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  const ReusableText(
                      text: "Min", fontSize: 17, fontcolor: blackColor),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: minQuantityController,
                      keyboardType: TextInputType.number,
                      onChanged: (x) => getDiscountDetails(),
                      decoration: const InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(width: 100),
                  const ReusableText(
                      text: "Max", fontSize: 17, fontcolor: blackColor),
                  const SizedBox(
                    width: 15,
                  ), // Add some space between the two text fields
                  Expanded(
                    child: TextField(
                      controller: maxQuantityController,
                      keyboardType: TextInputType.number,
                      onChanged: (x) => getDiscountDetails(),
                      decoration: const InputDecoration(
                          hintText: "0",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          )),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // Slider(
              //   value: _currentvalue,
              //   min: 0,
              //   max: 1000,
              //   divisions: 50,
              //   label: _currentvalue.toString(),
              //   activeColor: primaryColor,
              //   onChanged: (value){
              //     setState(() {
              //       _currentvalue == value;
              //     });
              //   }),

              // Slider(
              //   value: _currentvalue,
              //   max: 100,
              //   min: 0,
              //   activeColor: primaryColor,
              //   divisions: 1000,
              //   label: _currentvalue.toString(),
              //   onChanged: (valuesl) {
              //     setState(() {
              //       _currentvalue = valuesl;
              //     });
              //   },
              // ),

              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ReusableText(text: "35", fontSize: 15, fontcolor: blackColor),
              //     ReusableText(text: "1000", fontSize: 15, fontcolor: blackColor),
              //   ],
              // ),

              const SizedBox(
                height: 15,
              ),

              // RangeSlider(
              //   values: values,
              //   divisions: 5000,
              //   labels: labels,
              //   onChanged: (pvalues) {
              //     setState(() {
              //       values = pvalues;
              //     });
              //   },
              // ),

              const ReusableText(
                  text: "Expected Delivary Time (in Days)",
                  fontSize: 15,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              TextField(
                controller: deliveryTimeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Delivery Time',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Discounts", fontSize: 15, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  value: _dropdownvalue,
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const ReusableText(
                      text: "Select discounts",
                      fontSize: 11,
                      fontcolor: greyColor),
                  dropdownColor: whiteColor,
                  isExpanded: true,
                  // elevation: 16,
                  style: const TextStyle(color: blackColor),
                  underline: const SizedBox(),
                  onChanged: (String? value) {
                    setBools(value.toString());
                    getDiscountDetails();
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Visibility(
                          visible: showfirst,
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Enter discount %'),
                            keyboardType: TextInputType.number,
                            controller: first,
                            onChanged: (value) => getDiscountDetails(),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Visibility(
                          visible: showsecond,
                          child: TextField(
                            onChanged: (x) => getDiscountDetails(),
                            decoration: const InputDecoration(hintText: 'Buy'),
                            keyboardType: TextInputType.number,
                            controller: second,
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      Visibility(
                          visible: showthird,
                          child: TextField(
                            onChanged: (x) => getDiscountDetails(),
                            decoration: const InputDecoration(hintText: 'Get'),
                            keyboardType: TextInputType.number,
                            controller: third,
                          )),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Visibility(
                  //         visible: showfourth,
                  //         child: TextFormField(
                  //           onChanged: (value) {
                  //             print(value);
                  //             print(fourth.text);
                  //             getDiscountDetails();
                  //           },
                  //           decoration: const InputDecoration(
                  //               hintText: 'Discount on PTR %'),
                  //           keyboardType: TextInputType.number,
                  //           controller: fourth,
                  //         )),
                  //   ],
                  // ),
                  Visibility(
                    visible: showfifth,
                    child: EasyAutocomplete(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: 'Product Name',
                            hintStyle: const TextStyle(fontSize: 12)),
                        controller: productsController,
                        suggestions: stocks,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          productNameController.text = value;
                        }),

                    //  DropdownButton(
                    //     value: _selectedItem2,
                    //     items: stocks[0].resultProducts!.map((var cat) {
                    //       return DropdownMenuItem(
                    //         value: _selectedItem2,
                    //         onTap: () async {
                    //           setState(() {});
                    //         },
                    //         child: Text(cat.productName.toString()),
                    //       );
                    //     }).toList(),
                    //     onChanged: (value) {
                    //       _selectedItem2 = value;
                    //     })
                  )
                ],
              )

              // const ReusableText(
              //     text: "GST ", fontSize: 15, fontcolor: primaryColor),
              // const SizedBox(
              //   height: 10,
              // ),

              // DropdownButtonFormField<String>(
              //         value: _selectedItem2,
              //         decoration: InputDecoration(

              //           hintText: 'gst Eg:2%',
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(5),
              //           ),
              //         ),
              //         items: dropdownItems2.map((String item) {
              //           return DropdownMenuItem<String>(
              //             value: item,
              //             child: Text(item),
              //           );
              //         }).toList(),
              //         onChanged: (value) {
              //           setState(() {
              //             _selectedItem2 = value;
              //           });
              //         },
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please select an option';
              //           }
              //           return null;
              //         },
              //       ),
              ,
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Net Rate", fontSize: 13, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: netRateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Amt in Rs.',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "PTR", fontSize: 13, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ptpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Amt in Rs.',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                      ),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Already uploaded Images",
                  fontSize: 13,
                  fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageToUplod.length,
                  itemBuilder: (context, index) {
                    var currentItem = imageToUplod[index];
                    return Container(
                      height: MediaQuery.of(context).size.width - 220,
                      width: MediaQuery.of(context).size.width - 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(currentItem.replaceAll(
                                "https://pharmabag03.s3.ap-south-1.amazonaws.com/",
                                "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_")),
                            fit: BoxFit.cover),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          //padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 37, 33),
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                              onPressed: () {
                                imageToUplod.removeAt(index);
                                imageToUplod.insert(index, null);
                                setState(() {
                                  imageToUplod.retainWhere((element) {
                                    return element != null;
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Upload a picture of your product",
                  fontSize: 14,
                  fontcolor: primaryColor),
              const ReusableText(
                  text: "Show how the product looks for better clarity,",
                  fontSize: 10,
                  fontcolor: blackColor),
              const ReusableText(
                  text: "it is recommended to add a product description",
                  fontSize: 10,
                  fontcolor: blackColor),
              const SizedBox(
                height: 20,
              ),

              if (_image != null)
                Center(
                  child: GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.file(
                        _image!,
                        height: 150,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () => pickImage(ImageSource.gallery),
                  ),
                )
              else
                Center(
                  child: GestureDetector(
                    child: Container(
                      height: 130,
                      width: 240,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor,
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.folder,
                        size: 75,
                        color: greyColor,
                      )),
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      debugPrint("open cammera section and file");
                    },
                  ),
                ),

              const SizedBox(
                height: 10,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                      text: "Drag drop ",
                      fontSize: 11.5,
                      fontcolor: primaryColor),
                  ReusableText(
                      text: "your file here or Browse",
                      fontSize: 11.5,
                      fontcolor: blackColor),
                  ReusableText(
                      text: "Browse", fontSize: 11.5, fontcolor: primaryColor),
                ],
              ),

              //  const SizedBox(height: 25,),

              // ReusableText(text: "Product description", fontSize: 13, fontcolor: primaryColor),
              // const SizedBox(height: 15,),
              // TextField(
              //             maxLines: 3,
              //             decoration: InputDecoration(
              //                 hintText: 'Explain your composition',

              //                 border: OutlineInputBorder(
              //                   borderSide: BorderSide(
              //                     color: primaryColor,
              //                   ),
              //                 )),
              //           ),

              const SizedBox(
                height: 20,
              ),

              Center(
                  child: ReusebleButton(
                buttonText: "Submit",
                buttoncolor: primaryColor,
                textcolor: whiteColor,
                onPressed: () async {
                  // if (productNameController.text.isEmpty ||
                  //     companyNameController.text.isEmpty ||
                  //     mrpController.text.isEmpty ||
                  //     gstPercentController.text.isEmpty ||
                  //     deliveryTimeController.text.isEmpty ||
                  //     minQuantityController.text.isEmpty ||
                  //     maxQuantityController.text.isEmpty ||
                  //     availableQuantityController.text.isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //       content: Text('Please complete the details')));
                  // } else {
                  List<String> extrafields2 = [
                    "India",
                    "0",
                    "12345",
                    "Product is sold by Pharmabag.",
                    "Tube",
                    deliveryTimeController.text
                  ];
                  var extrafields = jsonEncode(extrafields2).toString();
                  var categories = jsonEncode({
                    "category_name": categoryNameController.text.toString(),
                    "sub_category_name":
                        SubcategoryNameController.text.toString()
                  }).toString();
                  var images = jsonEncode(imageToUplod).toString();
                  if (_image != null) {
                    var res = await AddStock()
                        .uploadImage(_image!)
                        .then((value) async {
                      imageToUplod.add(value);
                      var images = jsonEncode(imageToUplod).toString();
                      final res = await AddStock().editStock(
                        widget.productId,
                        productNameController.text,
                        companyNameController.text,
                        chemical.text,
                        extrafields2,
                        categories,
                        availableQuantityController.text,
                        minQuantityController.text,
                        maxQuantityController.text,
                        mrpController.text,
                        expiry.text,
                        gstPercentController.text,
                        first.text.isEmpty ? '' : first.text,
                        third.text.isEmpty ? '' : third.text,
                        second.text.isEmpty ? '' : second.text,
                        '',
                        images,
                        '1',
                        extrafields,
                        discountformDetails ??
                            jsonEncode(
                                    widget.everything['discount_form_details'])
                                .toString(),
                        discountDetails ??
                            jsonEncode(widget.everything['discount_details'])
                                .toString(),
                      );
                      final data = json.decode(res);
                      if (data['status'] == 403) {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            confirmBtnColor: primaryColor,
                            text: data['message'],
                            confirmBtnText: "okay",
                            onConfirmBtnTap: () => Navigator.pushReplacement(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavBarpage()))));
                      } else {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            confirmBtnColor: primaryColor,
                            text: "Sucessfully Edited!",
                            confirmBtnText: "okay",
                            onConfirmBtnTap: () => Navigator.pushReplacement(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavBarpage()))));
                      }
                    });
                  } else {
                    final res = await AddStock().editStock(
                      widget.productId,
                      productNameController.text,
                      companyNameController.text,
                      chemical.text,
                      extrafields2,
                      categories,
                      availableQuantityController.text,
                      minQuantityController.text,
                      maxQuantityController.text,
                      mrpController.text,
                      expiry.text,
                      gstPercentController.text,
                      first.text.isEmpty ? '' : first.text,
                      third.text.isEmpty ? '' : third.text,
                      second.text.isEmpty ? '' : second.text,
                      '',
                      images,
                      '1',
                      extrafields,
                      discountformDetails ??
                          jsonEncode(widget.everything['discount_form_details'])
                              .toString(),
                      discountDetails ??
                          jsonEncode(widget.everything['discount_details'])
                              .toString(),
                    );
                    final data = json.decode(res);
                    if (data['status'] == 403) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.warning,
                          confirmBtnColor: primaryColor,
                          text: data,
                          confirmBtnText: "okay",
                          onConfirmBtnTap: () => Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const BottomNavBarpage(
                                        gIndex: 3,
                                      )))));
                    } else {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          confirmBtnColor: primaryColor,
                          text: "Sucessfully Edited!",
                          confirmBtnText: "okay",
                          onConfirmBtnTap: () => Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBarpage(gIndex: 3)))));
                    }
                  }
                },
                // },
                fontSize: 17,
              )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
