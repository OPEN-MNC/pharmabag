// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pharmabag/Bayer/My_order/order_page.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/components/cart/cart.dart';
import 'package:pharmabag/Bayer/request_&_responds/get_product_details.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // ignore: prefer_typing_uninitialized_variables
  Map<String, dynamic> productdetails = {};
  List<dynamic> similar = [];
  int _number = 0;
  void incrementNumber() {
    setState(() {
      _number++;
      _textEditingController.text = _number.toString();
    });
  }

  List<dynamic> finalList = [];
  getWishList() async {
    String url = "https://pharmabag.in:3000/buyer/auth/wishlist";
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    setState(() {
      finalList = jsonDecode(res.body);
    });
  }

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future addtoFavorite(String Id) async {
    String url = "https://pharmabag.in:3000/buyer/auth/wishlist/$Id";
    String authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    for (var element in finalList) {
      if (element['product_id'] == Id) {
        showAlert('The Product is already in your wishlist');
        break;
      } else {
        http.Response res =
            await http.post(Uri.parse(url), headers: {'auth-token': authToken});
        return res;
      }
    }
  }

  void decrementNumber() {
    setState(() {
      if (_number > 0) {
        _number--;
        _textEditingController.text = _number.toString();
      }
    });
  }

  void shareOnSocialMedia(String shareContent) {
    Share.share(shareContent);
  }

//==========================
  getProductDetails() async {
    var x = await http.get(Uri.parse(
        "https://pharmabag.in:3000/buyer/un/auth/products/per/${widget.productId}"));
    var data = jsonDecode(x.body);
    setState(() {
      imageUrls = data["result_products"]["image_list"].toList();
    });
    return data;
  }

  getsimilarproducts(sub) async {
    var x = await http.post(
        Uri.parse("https://pharmabag.in:3000/user/get/similar/product"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"subcategory": sub.toString()}));
    var data = jsonDecode(x.body);

    return data;
  }
//========================

  List imageUrls = [];
  bool isloding = true;
  final TextEditingController _textEditingController = TextEditingController();

  int numberOfStars = 4; // Provide the number of stars

  Color getIconColor(int index) {
    // Function to get the color based on the index
    if (index < numberOfStars) {
      return primaryColor; // Change the color as desired
    } else {
      return Colors.grey; // Change the color as desired
    }
  }

  int _currentImageIndex = 0;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    quantityController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getWishList();
    fetchCartItems();
    getProductDetails().then((value) {
      setState(() {
        productdetails = value["result_products"];
        isloding = false;
      });
      getsimilarproducts(productdetails["categories"]["sub_category_name"])
          .then((value) {
        setState(() {
          similar = value;
        });
      });
    });
    super.initState();
  }

  int cartcount = 0;
  Future<void> fetchCartItems() async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart');
    String authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'auth-token': authToken,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['result_cart'];

        setState(() {
          cartcount = data.length;
        });
      } else {
        showAlert(
            'Failed to fetch cart items. Please try again or contact admin.');
      }
    } catch (e) {
      showAlert(
          'An error occurred while fetching cart items. Please try again.$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isloding) {
      return const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          productdetails['product_name'].toString(),
          style: const TextStyle(color: primaryColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: primaryColor,
            ),
            onPressed: () {
              shareOnSocialMedia(
                  "Check out this medicine \n https://pharmabag.in/product.php?id=${widget.productId}");
              // Share functionality
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                  // Go to shopping cart functionality
                },
              ),
              Badge(
                label: Text(cartcount.toString()),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '3', // Replace with the actual count of items in the shopping cart
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                // Image.network(
                //   'https://thumbs.dreamstime.com/b/medicine-medicine-pharmacy-treatment-white-help-antibiotic-composition-white-white-tablets-same-size-composition-169085962.jpg',
                //   fit: BoxFit.contain,
                // ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Center(
                            child: Image.network(
                                imageUrls[index].replaceAll(
                                    "https://pharmabag03.s3.ap-south-1.amazonaws.com/",
                                    "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_"),
                                height: 220,
                                errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://pharmabag.in/image/logo/logo-edited.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              );
                            }),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: ((DateTime.now()
                              .difference(
                                  DateTime.parse(productdetails['date']))
                              .inDays)) >
                          60
                      ? const SizedBox(
                          height: 0,
                        )
                      : Container(
                          width: 55,
                          decoration: BoxDecoration(
                              color: greenColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                                child: ReusableText(
                                    text: "New",
                                    fontSize: 15,
                                    fontcolor: whiteColor)),
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 45),
                  child: Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                            child: ReusableText(
                                text:
                                    "-${productdetails["discount_form_details"]["discountOnPtrOnlyPercenatge"] ?? 0}%",
                                fontSize: 15,
                                fontcolor: whiteColor)),
                      )),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 65,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                            imageUrls[index].replaceAll(
                                "https://pharmabag03.s3.ap-south-1.amazonaws.com/",
                                "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_"),
                            height: 65,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://pharmabag.in/image/logo/logo-edited.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          );
                        }),
                      );
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: productdetails["product_name"],
                        fontSize: 20,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ReusableText(
                            text: "COMPANY: ${productdetails["company_name"]}",
                            fontSize: 13,
                            fontcolor: blackColor),
                        const SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text:
                                    "Expiry: ${productdetails["expire_date"].toString().substring(0, 7)}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Stock: ${productdetails["stock"]}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "Min qty: ${productdetails["min_order_qty"]}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "Max qty: ${productdetails["max_order_qty"]}",
                                fontSize: 13,
                                fontcolor: blackColor),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text:
                                    "Medicine Type: ${productdetails["categories"]["sub_category_name"]}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            const ReusableText(
                                text: "Country: India",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "Buy:${productdetails["discount_details"]["buy"] ?? ""}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "Get:${productdetails["discount_details"]["get"] ?? ""}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "GST: ${productdetails["discount_details"]["gst"].toString().replaceAll(".00", "%")}",
                                fontSize: 13,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text:
                                    "Expected Delivery: ${productdetails["extra_fields"].last}+3 Days",
                                fontSize: 13,
                                fontcolor: blackColor),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReusableText(
                        text:
                            "Chemical Combination: ${productdetails["chemical_combination"]}",
                        fontSize: 14,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableText(
                        text:
                            "Discount type: ${productdetails["discount_details"]["type"].toString().replaceAll("_", " ")}",
                        fontSize: 14,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      children: [
                        const ReusableText(
                            text: "Seller id:",
                            fontSize: 15,
                            fontcolor: primaryColor),
                        ReusableText(
                            text: "  ${productdetails["seller_id"]}",
                            fontSize: 15,
                            fontcolor: primaryColor),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const ReusableText(
                                text: "MRP: ",
                                fontSize: 20,
                                fontcolor: blackColor),
                            ReusableText(
                                text: "₹${productdetails["product_price"]}",
                                fontSize: 20,
                                fontcolor: primaryColor),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const ReusableText(
                                    text: "On PTR: ",
                                    fontSize: 20,
                                    fontcolor: blackColor),
                                ReusableText(
                                    text:
                                        "₹${productdetails["discount_details"]["final_ptr"]}",
                                    fontSize: 20,
                                    fontcolor: primaryColor),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹${productdetails["product_price"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    decoration: TextDecoration.lineThrough,
                                    color: greyColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const ReusableText(
                                    text: "(Rate without GST)",
                                    fontSize: 13,
                                    fontcolor: red)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    // next increment

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ReusableContainer(
                              color: const Color.fromARGB(108, 197, 197, 197),
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: decrementNumber,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            ReusableContainer(
                                height: 40,
                                width: 100,
                                color: primaryColor,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    cursorColor: whiteColor,
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    controller: _textEditingController,
                                    onChanged: (value) {
                                      _number = int.parse(value);
                                    },
                                    style: const TextStyle(color: whiteColor),
                                  ),
                                ))),
                            const SizedBox(
                              width: 3,
                            ),
                            ReusableContainer(
                              color: const Color.fromARGB(108, 197, 197, 197),
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: incrementNumber,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: IconButton(
                                  onPressed: () async {
                                    http.Response res =
                                        await addtoFavorite(widget.productId);
                                    if (res.statusCode == 200) {
                                      QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.info,
                                          title: 'Product Added to WishList',
                                          confirmBtnText: 'Okay',
                                          onConfirmBtnTap: () {
                                            Navigator.pop(context);
                                            dispatchCustomEvent(
                                                (finalList.length + 1)
                                                    .toString(),
                                                "wishlist_update");
                                          });
                                    } else {
                                      QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.info,
                                          title: 'Failed to add to Cart',
                                          confirmBtnText: 'Okay',
                                          onConfirmBtnTap: () =>
                                              Navigator.pop(context));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: red,
                                  ))),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        addtocart(
                            productdetails["_id"],
                            _number,
                            DateTime.now().toLocal().toString(),
                            "",
                            productdetails["stock"],
                            productdetails["min_order_qty"],
                            context);
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: whiteColor,
                                ),
                                ReusableText(
                                    text: " ADD TO BAG",
                                    fontSize: 17,
                                    fontcolor: whiteColor),
                              ]),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Enter Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: quantityController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Quantity',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 96, 2, 113),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      TextField(
                                        controller: dateController,
                                        decoration: InputDecoration(
                                          hintText: 'Expected date of delivery',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 96, 2, 113),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );

                                          if (pickedDate != null) {
                                            setState(() {
                                              dateController.text = pickedDate
                                                  .toLocal()
                                                  .toString()
                                                  .substring(0, 10);
                                            });
                                          } else {}
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor),
                                          onPressed: () {
                                            // Handle button click here
                                            String quantity =
                                                quantityController.text;
                                            String date = dateController.text;
                                            addCustomOrder(
                                                productdetails["_id"],
                                                int.parse(quantity),
                                                date,
                                                "",
                                                productdetails["stock"],
                                                productdetails["max_order_qty"],
                                                context);
                                            // Perform necessary actions with the entered data

                                            // Close the popup
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: whiteColor,
                                ),
                                ReusableText(
                                    text: "Place CUSTOM ORDER",
                                    fontSize: 17,
                                    fontcolor: primaryColor),
                              ]),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Center(
                        child: ReusableText(
                            text: "Related This Items",
                            fontSize: 20,
                            fontcolor: blackColor)),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: 400,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: similar.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(similar[index]["discount_form_details"]
                                ["discountOnPtrOnlyPercenatge"]);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Container(
                                height: 300,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                                  productId: similar[index]
                                                          ['_id']
                                                      .toString(),
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ), // Adjust the border radius as desired
                                          child: SizedBox(
                                            height: 150,
                                            child: Image.network(
                                                similar[index]["image_list"][0]
                                                    .replaceAll(
                                                        "https://pharmabag03.s3.ap-south-1.amazonaws.com/",
                                                        "https://pharmabag03.s3.ap-south-1.amazonaws.com/small_"),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                              return Image.network(
                                                "https://pharmabag.in/image/logo/logo-edited.png",
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.contain,
                                              );
                                            }),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1, top: 1),
                                          child: ((DateTime.now()
                                                      .difference(
                                                          DateTime.parse(
                                                              similar[index]
                                                                  ['date']))
                                                      .inDays)) >
                                                  60
                                              ? const SizedBox(
                                                  height: 0,
                                                )
                                              : Container(
                                                  width: 75,
                                                  decoration: BoxDecoration(
                                                      color: greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Center(
                                                        child: ReusableText(
                                                            text: "New",
                                                            fontSize: 13,
                                                            fontcolor:
                                                                whiteColor)),
                                                  )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 1, top: 45),
                                          child: Container(
                                              width: 75,
                                              decoration: BoxDecoration(
                                                  color: red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Center(
                                                    child: ReusableText(
                                                        text:
                                                            "-${similar[index]["discount_form_details"]["discountOnPtrOnlyPercenatge"] ?? 0}%",
                                                        fontSize: 12,
                                                        fontcolor: whiteColor)),
                                              )),
                                        ),
                                      ]),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            ReusableText(
                                                text: similar[index]
                                                        ["product_name"]
                                                    .toString(),
                                                fontSize: 16,
                                                fontcolor: blackColor),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            ReusableText(
                                                text:
                                                    "${similar[index]["categories"]["category_name"]} > ${similar[index]["categories"]["sub_category_name"]}",
                                                fontSize: 16,
                                                fontcolor: blackColor),
                                            ReusableText(
                                                text:
                                                    "Seller ${similar[index]["seller_id"].substring(0, 8)}xxxx",
                                                fontSize: 16,
                                                fontcolor: blackColor),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    const ReusableText(
                                                        text: "MRP",
                                                        fontSize: 16,
                                                        fontcolor:
                                                            primaryColor),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    ReusableText(
                                                        text:
                                                            "₹${similar[index]["product_price"]}",
                                                        fontSize: 16,
                                                        fontcolor:
                                                            primaryColor),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const ReusableText(
                                                        text: "PTR",
                                                        fontSize: 16,
                                                        fontcolor:
                                                            primaryColor),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    ReusableText(
                                                        text:
                                                            "₹${similar[index]["discount_details"]["final_ptr"]}",
                                                        fontSize: 16,
                                                        fontcolor:
                                                            primaryColor),
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
                                                            Color>(
                                                        Colors.transparent),
                                                elevation: MaterialStateProperty
                                                    .all<double>(0),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetails(
                                                              productId: similar[
                                                                          index]
                                                                      ['_id']
                                                                  .toString(),
                                                            )));
                                              },
                                              child: const ReusableContainer(
                                                height: 45,
                                                width: 180,
                                                color:
                                                    primaryColor, // Replace with your desired color
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors
                                                            .white, // Replace with your desired color
                                                      ),
                                                      Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .white, // Replace with your desired color
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 17,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    // list view section finish

                    const SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        onPressed: () {
                          debugPrint("pressed");
                        },
                        child: Container(
                          height: 45,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(19),
                          ), // Replace with your desired color
                          child: const Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color:
                                      primaryColor, // Replace with your desired color
                                ),
                                Text(
                                  " VIEW ALL RELATED",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        primaryColor, // Replace with your desired color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //write review section
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
