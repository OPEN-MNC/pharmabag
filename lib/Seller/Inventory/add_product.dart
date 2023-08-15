// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final DateTime _selectedDate = DateTime.now();
  static const url = "https://pharmabag.in:3000/get/discount/details";
  String? _selectedItem;
  final TextEditingController _dropdownController = TextEditingController();
  String? gst;
  List<String> dropdownItems = [];
  Set<String> imagetoUpload = {};
  String? _selectedItem1;
  final TextEditingController _dropdownController1 = TextEditingController();
  List<String> dropdownItems1 = [];
  // final TextEditingController _dropdownController2 = TextEditingController();
  final List<String> dropdownItems2 = ['5%', '12%', '18%'];

  @override
  void dispose() {
    productController.dispose();
    productNameController.dispose();
    companyNameController.dispose();
    chemical.dispose();
    mrpController.dispose();
    minQuantityController.dispose();
    maxQuantityController.dispose();
    availableQuantityController.dispose();
    gstPercentController.dispose();
    super.dispose();
    expiry.dispose();
    netRateController.dispose();
    ptpController.dispose();
    first.dispose();
    second.dispose();
    third.dispose();
    fourth.dispose();
  }

  @override
  void initState() {
    // _dropdownController2.addListener(() {
    //   _selectedItem2 = _dropdownController2.text;
    // });
    getStocks();
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

  List<String> products = [];
  List<categories> cat = [];
  List<subcategories> sub = [];
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
              fifth = false;
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
              fifth = false;
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
              fifth = false;
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
              fifth = false;
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
              fifth = true;
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
              fifth = true;
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
        _storage.write(key: 'suggestions', value: value.body).then((value) {});

        final jsonResponse = jsonDecode(value.body);

        for (int i = 0; i < jsonResponse.length; i++) {
          products.add(jsonResponse[i]['name']);
        }
      }
    });
  }

  List<String> subName = [];
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
            for (int i = 0; i < sub.length; i++) {
              setState(() {
                subName.add(sub[i].subcategoryName);
              });
            }
          }
        }
      },
    );
  }

  String _dropdownvalue = list.first;

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
      "gstPercentage":
          gstPercentController.text.isEmpty ? '' : gstPercentController.text,
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
      "discountOnPtrOnlyPercenatge": first.text.isEmpty ? '0' : first.text,
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
        netRateController.text = res['final_ptr'].toString() == "NaN"
            ? ''
            : res['final_ptr'].toString();
        ptpController.text =
            res['per_ptr'].toString() == "NaN" ? '' : res['per_ptr'].toString();
      });
    });
  }

  pickDate() async {
    final selectedDate = await showMonthYearPicker(
            initialMonthYearPickerMode: MonthYearPickerMode.year,
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2099))
        .then((value) {
      if (value != null) {
        setState(() {
          debugPrint(value.toString());
          expiry.text = value.toString().substring(0, 7);
        });
      }
    });
  }

  bool showfirst = false;
  bool showsecond = false;
  bool showthird = false;
  bool showfourth = false;
  bool fifth = false;
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  final double _currentvalue = 0;
  List<DropdownMenuItem> items = [];
  TextEditingController productNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController subcategoryNameController = TextEditingController();
  TextEditingController chemical = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController availableQuantityController = TextEditingController();
  TextEditingController minQuantityController = TextEditingController();
  TextEditingController maxQuantityController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController gstPercentController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController netRateController = TextEditingController();
  TextEditingController ptpController = TextEditingController();
  TextEditingController productController = TextEditingController();
  File? _image;

  prepopulate(String product) async {
    final response = await _storage.read(key: 'suggestions').then((value) {
      if (value != '') {
        final jsonResponse = jsonDecode(value.toString());
        for (int i = 0; i < jsonResponse.length; i++) {
          var currentItem = jsonResponse[i];
          if (product == currentItem['name']) {
            setState(() {
              productNameController.text = currentItem['name'];
              companyNameController.text = currentItem['company_name'];
              chemical.text = currentItem['chemical'];
              categoryNameController.text =
                  currentItem['category_name'].toString().trim();
              subcategoryNameController.text =
                  currentItem['subcategory_name'].toString();
              if (currentItem['image'].isNotEmpty) {
                setState(() {
                  imagetoUpload.add(jsonResponse[i]['image'][0]);
                });
              }
            });
            // _selectedItem1 =
            //     jsonResponse[i]['subcategory_name'].toString().trim();
            for (int i = 0; i < cat.length; i++) {
              if (currentItem['category_name'] == cat[i].categoryName) {
                getsub(cat[i].sId);
              }
            }
          }
        }
        debugPrint('This list is $imagetoUpload');
      }
    });
  }

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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBarpage()));
        return true;
      },
      child: Padding(
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
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    productNameController.text = value;
                    prepopulate(productNameController.text);
                  }),
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
              EasyAutocomplete(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(13),
                      hintText: 'Sub Category',
                      hintStyle: const TextStyle(fontSize: 12)),
                  controller: subcategoryNameController,
                  suggestions: subName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    subcategoryNameController.text = value;
                  },
                  onSubmitted: (value) {}),
              const SizedBox(
                height: 10,
              ),
              const ReusableText(
                  text: "Expiry date", fontSize: 15, fontcolor: primaryColor),
              const SizedBox(
                height: 10,
              ),

              TextField(
                readOnly: true,
                controller: expiry,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        pickDate();
                      },
                      icon: const Icon(Icons.calendar_month)),
                  hintText: 'Expiry Date',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                ),
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
                        Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: DropdownButton(
                                underline: Container(
                                  color: primaryColor,
                                ),
                                value: gst,
                                icon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 25,
                                ),
                                hint: const Center(child: Text("GST")),
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
                                }),
                          ),
                        )
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
                          onEditingComplete: () => getDiscountDetails(),
                          onChanged: (value) {
                            Timer(const Duration(seconds: 1), () {
                              getDiscountDetails();
                            });
                          },
                          controller: mrpController,
                          keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
                      controller: minQuantityController,
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
                      keyboardType: TextInputType.number,
                      controller: maxQuantityController,
                      onEditingComplete: () => getDiscountDetails(),
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
                keyboardType: TextInputType.number,
                controller: deliveryTimeController,
                onChanged: (value) {
                  Timer(const Duration(seconds: 3), () {
                    getDiscountDetails();
                  });
                },
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
                    setBools(value
                        .toString()); // This is called when the user selects an item.
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
              Visibility(
                visible: showfirst || showsecond || showthird || showfourth,
                replacement: const SizedBox(
                  height: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Visibility(
                            visible: showfirst,
                            child: TextField(
                              onChanged: (x) => getDiscountDetails(),
                              decoration: const InputDecoration(
                                hintText: 'Enter discount %',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.6,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: first,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Visibility(
                            visible: showsecond,
                            child: TextField(
                              onChanged: (x) => getDiscountDetails(),
                              decoration: const InputDecoration(
                                hintText: 'Buy',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.6,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: second,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Visibility(
                            visible: showthird,
                            child: TextField(
                              onEditingComplete: () => getDiscountDetails(),
                              decoration: const InputDecoration(
                                hintText: 'Get',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.6,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              controller: third,
                            )),
                      ],
                    ),

                    // Column(
                    //   children: [
                    //     Visibility(
                    //         visible: showfourth,
                    //         child: TextField(
                    //           onEditingComplete: () => getDiscountDetails(),
                    //           decoration: const InputDecoration(
                    //               border: OutlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: primaryColor,
                    //                 ),
                    //               ),
                    //               hintText: 'Discount on PTR %'),
                    //           keyboardType: TextInputType.number,
                    //           controller: fourth,
                    //         )),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: fifth,
                      child: EasyAutocomplete(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: 'Product Name',
                              hintStyle: const TextStyle(fontSize: 12)),
                          controller: productController,
                          suggestions: stocks,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an option';
                            }
                            return null;
                          },
                          onSubmitted: (value) {
                            productController.text = value;
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
                ),
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
              // if (_image == null && imagetoUpload.isNotEmpty)
              //   Center(
              //       child: GestureDetector(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(30),
              //       child: Image.network(
              //         imagetoUpload.elementAt(0).toString(),
              //         errorBuilder: (context, error, stackTrace) => Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 8.0, vertical: 14),
              //           child: Image.network(
              //             'https://pharmabag.in/image/logo/logo-edited.png',
              //             width: 240, // set the width of the image
              //             height: 120, // set the height of the image
              //             fit: BoxFit
              //                 .fill, // set how the image should be scaled to fit its container
              //           ),
              //         ),
              //         height: 150,
              //         width: 200,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     onTap: () => pickImage(ImageSource.gallery),
              //   )),
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
                buttonText: "Add Product",
                buttoncolor: primaryColor,
                textcolor: whiteColor,
                onPressed: () async {
                  if (productNameController.text.isEmpty ||
                      chemical.text.isEmpty ||
                      mrpController.text.isEmpty ||
                      gstPercentController.text.isEmpty ||
                      deliveryTimeController.text.isEmpty ||
                      minQuantityController.text.isEmpty ||
                      maxQuantityController.text.isEmpty ||
                      availableQuantityController.text.isEmpty) {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Please fill all the details',
                        confirmBtnText: 'Okay',
                        onCancelBtnTap: () => Navigator.pop(context));
                    return;
                  }
                  if (imagetoUpload.isEmpty && _image == null) {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        confirmBtnColor: primaryColor,
                        title: 'Image required',
                        text: "Please upload an image",
                        confirmBtnText: "Okay",
                        onConfirmBtnTap: () => Navigator.pushReplacement(
                            context,
                            (MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavBarpage()))));
                    return;
                  }
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
                    "category_name": categoryNameController.text,
                    "sub_category_name": subcategoryNameController.text
                  }).toString();
                  var images = jsonEncode(imagetoUpload.toList()).toString();
                  debugPrint('the images are : $images');
                  String expiryDate = "${expiry.text.replaceAll('-', '/')}/26";

                  // When an image already exists and no new image is uploaded
                  if (_image == null && imagetoUpload.isNotEmpty) {
                    debugPrint(productNameController.text);
                    final res = await AddStock().addNewStock(
                        productNameController.text,
                        companyNameController.text,
                        chemical.text,
                        extrafields2,
                        categories,
                        availableQuantityController.text,
                        minQuantityController.text,
                        maxQuantityController.text.toString(),
                        mrpController.text,
                        expiryDate,
                        gstPercentController.text,
                        first.text.isEmpty ? '0' : first.text,
                        third.text.isEmpty ? '' : third.text,
                        second.text.isEmpty ? '' : second.text,
                        productController.text.isEmpty
                            ? ''
                            : productController.text,
                        images,
                        '1',
                        extrafields,
                        discountformDetails,
                        discountDetails);
                    final data = json.decode(res);
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.info,
                        confirmBtnColor: primaryColor,
                        title: data['status'].toString(),
                        text: data['message'],
                        confirmBtnText: "okay",
                        onConfirmBtnTap: () => Navigator.pushReplacement(
                            context,
                            (MaterialPageRoute(
                                builder: (context) => const BottomNavBarpage(
                                      gIndex: 3,
                                    )))));
                  }
                  // When an image does not exist and a new image is uploaded
                  else if (_image != null && imagetoUpload.isNotEmpty) {
                    var res = await AddStock()
                        .uploadImage(_image!)
                        .then((value) async {
                      imagetoUpload.add(value);
                      var images =
                          jsonEncode(imagetoUpload.toList()).toString();

                      final res = await AddStock().addNewStock(
                          productNameController.text,
                          companyNameController.text,
                          chemical.text,
                          extrafields2,
                          categories,
                          availableQuantityController.text,
                          minQuantityController.text,
                          maxQuantityController.text.toString(),
                          mrpController.text,
                          expiryDate,
                          gstPercentController.text,
                          first.text.isEmpty ? '0' : first.text,
                          third.text.isEmpty ? '' : third.text,
                          second.text.isEmpty ? '' : second.text,
                          productController.text.isEmpty
                              ? ''
                              : productController.text,
                          images,
                          '1',
                          extrafields,
                          discountformDetails,
                          discountDetails);
                      final data = json.decode(res);
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          confirmBtnColor: primaryColor,
                          title: data['status'].toString(),
                          text: data['message'],
                          confirmBtnText: "okay",
                          onConfirmBtnTap: () => Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const BottomNavBarpage(
                                        gIndex: 3,
                                      )))));
                    });
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
