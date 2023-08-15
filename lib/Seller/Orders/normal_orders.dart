// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

import '../Tickets/ticket_show.dart';

class NormalOrder extends StatefulWidget {
  const NormalOrder({Key? key}) : super(key: key);

  @override
  State<NormalOrder> createState() => _NormalOrderState();
}

class _NormalOrderState extends State<NormalOrder> {
  late StreamSubscription<CustomEvent> _eventListener;
  String currentFilterOption = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<dynamic> stocks = [];
  List<dynamic> xstocks = [];
  List<String> actions = ['Accept', 'Reject', 'Set Milestone'];
  bool isLoading = false;
  String _image = "Upload invoice";
  File? imagex;

  getOrders() async {
    setState(() {
      isLoading = true;
    });
    var res = await AddStock().getOrders().then((value) {
      setState(() {
        stocks = value;
        xstocks = stocks;
      });
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  Future pickImage(ImageSource source, String id) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        imagex = imageTemporary;
        _image = "Uploading";
      });
      await AddStock().uploadImage(imagex!).then((imglink) {
        postInvoice() async {
          var res;
          String token = await _storage.read(key: 'token').then((value) {
            return value.toString();
          });
          var url =
              'https://pharmabag.in:3000/seller/auth/orders/seller/add/invoice/for/order/$id';
          res = await http
              .post(Uri.parse(url),
                  headers: {'auth-token': token},
                  body: jsonEncode({
                    "invoice": [imglink]
                  }).toString())
              .then((value) {
            res = value.body;
            setState(() {
              _image = "uploading done!";
            });
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: "Uploading Done",
                confirmBtnText: 'Okay',
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
            return res;
          });
          return res;
        }

        postInvoice();
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  TextEditingController box1 = TextEditingController();
  TextEditingController box2 = TextEditingController();
  TextEditingController box3 = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  TextEditingController dateController3 = TextEditingController();
  DateTime dateController1x = DateTime.now();
  DateTime dateController2x = DateTime.now();
  DateTime dateController3x = DateTime.now();

  decision(String id, int choice, int qty) async {
    box1.text = "0";
    box2.text = "0";
    box3.text = "0";
    dateController1.text = '';
    dateController2.text = '';
    dateController3.text = '';
    if (choice == 2) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Divide Order Qty ($qty)"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: box1,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelText: '1st Milestone',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dateController1,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 0.6)),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final selectedData = await showDatePicker(
                                        initialEntryMode:
                                            DatePickerEntryMode.calendar,
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(9999))
                                    .then((value) {
                                  dateController1.text =
                                      value.toString().substring(0, 10);
                                  dateController1x = value!;
                                });
                              },
                              icon: const Icon(Icons.calendar_month))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: box2,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelText: '2nd Milestone',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dateController2,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 0.6)),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final selectedData = await showDatePicker(
                                        initialEntryMode:
                                            DatePickerEntryMode.calendar,
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(9999))
                                    .then((value) {
                                  dateController2.text =
                                      value.toString().substring(0, 10);
                                  dateController2x = value!;
                                });
                              },
                              icon: const Icon(Icons.calendar_month))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: box3,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.numbers),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          labelText: '3rd Milestone',
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dateController3,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 0.6)),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final selectedData = await showDatePicker(
                                        initialEntryMode:
                                            DatePickerEntryMode.calendar,
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(9999))
                                    .then((value) {
                                  dateController3.text =
                                      value.toString().substring(0, 10);
                                  dateController3x = value!;
                                });
                              },
                              icon: const Icon(Icons.calendar_month))),
                    ),
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    String error = "";
                    var qtyget = 0;
                    try {
                      qtyget = int.parse(box1.text) +
                          int.parse(box2.text) +
                          int.parse(box3.text);
                    } catch (err) {
                      error += "please Fill details ";
                    }

//set milestone logic simple for now
                    try {
                      // if (int.parse(box1.text) +
                      //         int.parse(box2.text) +
                      //         int.parse(box3.text) ==
                      //     qty) {
                      if (box1.text != '0') {
                        if (dateController1.text == '' ||
                            DateTime.now().isAfter((dateController1x))) {
                          error +=
                              "1st Milestone date is not correct or empty \n";
                        }
                      }
                      if (box2.text != '0') {
                        if (dateController2.text == '' ||
                            DateTime.now().isAfter((dateController2x))) {
                          error +=
                              "2nd Milestone date is not correct or empty \n";
                        }
                      }
                      if (box3.text != '0') {
                        if (dateController3.text == '' ||
                            DateTime.now().isAfter((dateController3x))) {
                          error +=
                              "3rd Milestone date is not correct or empty \n";
                        }
                      }
                      if (qtyget != qty) {
                        error +=
                            "total milestone amount should be equal to Order Quantity $qty";
                      }

                      //}
                      if (error != "") {
                        assert(error == "");
                      } else {
                        var jsonx = {
                          dateController1.text: box1.text,
                          dateController2.text: box2.text,
                          dateController3.text: box3.text,
                        };
                        jsonx.removeWhere((key, value) =>
                            key == "" || (value == "" || value == "0"));
                        var reqBody = {
                          "milestone_details": jsonx,
                          "ispartial": 0
                        };

                        // QuickAlert.show(
                        //   context: context,
                        //   type: QuickAlertType.error,
                        //   title:
                        //       "total milestone amount should be equal to Order Quantity $qty",
                        //   confirmBtnText: 'Okay',
                        //   onConfirmBtnTap: () => Navigator.pop(
                        //     context,
                        //   ),
                        // );

                        vacation() async {
                          String token =
                              await _storage.read(key: 'token').then((value) {
                            return value.toString();
                          });
                          String url =
                              'https://pharmabag.in:3000/seller/auth/orders/seller/setmilestone/order/$id';
                          var body = reqBody;
                          var data = jsonEncode(body).toString();
                          var res = await http.post(Uri.parse(url),
                              body: data,
                              headers: {
                                'content-type': 'application/json',
                                'auth-token': token
                              }).then((value) {
                            var data = jsonDecode(value.body);
                            if (value.statusCode == 200) {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.info,
                                  title: 'Milestone Set sucesfully',
                                  text:
                                      'Wait till buyer accept your milestone request',
                                  confirmBtnText: 'Okay',
                                  onConfirmBtnTap: () {
                                    getOrders();
                                    Navigator.pop(context);
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.pop(context);
                                  });
                            }
                          });
                        }

                        vacation();
                      }
                    } catch (err) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: error,
                        confirmBtnText: 'Okay',
                        onConfirmBtnTap: () => Navigator.pop(
                          context,
                        ),
                      );
                    }
                  },
                  color: primaryColor,
                  child: const Text(
                    'Okay',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  color: red,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ],
            );
          });
    } else {
      Response res = await AddStock().decision(id, choice);
      if (res.statusCode == 200) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: choice == 0
              ? 'Order Accepted Successfully'
              : 'Order Rejected Successfully',
          confirmBtnText: 'Okay',
          onConfirmBtnTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavBarpage())),
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: choice == 0 ? 'Order Accept failed' : 'Order Rejection Failed',
          confirmBtnText: 'Okay',
          onConfirmBtnTap: () {
            getOrders();
            Navigator.pop(context);
          },
        );
      }
    }
  }

  List<String> statuses = [
    'Placed',
    'accepted',
    'awaiting confirmation',
    'way to warehouse',
    'Reached warehouse',
    'Order in Transit',
    'Out for Delivery',
    'Order Shipped',
    'Transport delay',
    'sucessfull'
  ];
  String getStatus(String status) {
    String stat = 'accepted';
    for (int i = 0; i < statuses.length; i++) {
      if (status == statuses[i]) {
        stat = statuses[i];
        return stat;
      }
    }
    return stat;
  }

  @override
  void initState() {
    getOrders();
    super.initState();

    _eventListener =
        EventManager().eventStream.listen((event) => handleEvent(event));
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleEvent(CustomEvent event) {
    String? filterBy = 'clear filters';
    _storage.read(key: 'filterBy').then((value) {
      filterBy = value;
      setState(() {
        xstocks = stocks;

        xstocks = stocks.where((element) {
          return filterBy == "clear filters"
              ? true
              : getStatus(element["order_status"]) == filterBy;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height - 225.0,
            child: ListView.builder(
                // reverse: true,
                itemCount: xstocks.length,
                itemBuilder: (context, index) {
                  var currentItem = xstocks[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 0.4),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          ReusableContainer(
                            height: 170,
                            width: 360,
                            color: whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 17, top: 17),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                        text: "#${currentItem['order_id']}",
                                        fontSize: 15,
                                        fontcolor: primaryColor,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: getStatus(currentItem[
                                                          'order_status']) ==
                                                      'successfull'
                                                  ? greenColor
                                                  : getStatus(currentItem[
                                                              'order_status']) ==
                                                          'accepted'
                                                      ? Colors.greenAccent
                                                      : getStatus(currentItem[
                                                                  'order_status']) ==
                                                              'awaiting confirmation'
                                                          ? const Color
                                                                  .fromRGBO(
                                                              216, 176, 14, 1)
                                                          : const Color
                                                                  .fromRGBO(
                                                              59, 101, 255, 1),
                                              width: 1,
                                            )),
                                        child: Center(
                                            child: ReusableText(
                                                text: getStatus(currentItem[
                                                    'order_status']),
                                                fontSize: 11.5,
                                                fontcolor: getStatus(currentItem[
                                                            'order_status']) ==
                                                        'successfull'
                                                    ? greenColor
                                                    : getStatus(currentItem[
                                                                'order_status']) ==
                                                            'accepted'
                                                        ? Colors.greenAccent
                                                        : getStatus(currentItem[
                                                                    'order_status']) ==
                                                                'awaiting confirmation'
                                                            ? const Color
                                                                    .fromRGBO(
                                                                216, 176, 14, 1)
                                                            : primaryColor)),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          currentItem['cart_details']
                                                      ['product_image']
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
                                                  currentItem['cart_details']
                                                          ['product_image']
                                                      .toString(),
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Image.network(
                                                    'https://pharmabag.in/image/logo/logo-edited.png',
                                                    width:
                                                        80, // set the width of the image
                                                    height:
                                                        60, // set the height of the image
                                                    fit: BoxFit
                                                        .fill, // set how the image should be scaled to fit its container
                                                  ),
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
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
                                                          const EdgeInsets.all(
                                                              4),
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
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                  text: currentItem[
                                                          'cart_details']
                                                      ['product_name'],
                                                  fontSize: 11,
                                                  fontcolor: primaryColor),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              ReusableText(
                                                  text: currentItem[
                                                          'cart_details']
                                                      ['company_name'],
                                                  fontSize: 10,
                                                  fontcolor: greyColor),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              ReusableText(
                                                  text: currentItem['date']
                                                      .toString()
                                                      .substring(0, 10),
                                                  fontSize: 10,
                                                  fontcolor: greyColor),
                                            ],
                                          ),
                                        ],
                                      ),
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
                                              fontcolor: primaryColor),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          ReusableText(
                                              text: currentItem['cart_details']
                                                      ['product_price']
                                                  .toString(),
                                              fontSize: 11,
                                              fontcolor: blackColor),
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          const ReusableText(
                                              text: "QTY",
                                              fontSize: 10,
                                              fontcolor: primaryColor),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          ReusableText(
                                              text: currentItem['cart_details']
                                                      ['quantity']
                                                  .toString(),
                                              fontSize: 11,
                                              fontcolor: blackColor),
                                        ],
                                      ),

                                      Column(
                                        children: [
                                          const ReusableText(
                                              text: "Total Price",
                                              fontSize: 9,
                                              fontcolor: primaryColor),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          ReusableText(
                                              text: currentItem['cart_details']
                                                          ['pricing']
                                                      ["final_order_value"]
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
                                        buttonText: "Action",
                                        buttoncolor: primaryColor,
                                        textcolor: whiteColor,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: currentItem[
                                                              "order_status"] !=
                                                          "Placed"
                                                      ? SizedBox(
                                                          height: 100,
                                                          child: Column(
                                                            children: [
                                                              MaterialButton(
                                                                minWidth: 150,
                                                                color:
                                                                    primaryColor,
                                                                onPressed:
                                                                    () async {
                                                                  pickImage(
                                                                      ImageSource
                                                                          .gallery,
                                                                      currentItem[
                                                                          "_id"]);

//var x=await fetch("https://pharmabag.in:3000/seller/auth/orders/seller/add/invoice/for/order/"+id,{method:"POST",headers:{"content-type":"application/json","auth-token":localStorage.getItem("auth-token")},body:JSON.stringify({invoice:buyer_licences_image})});
                                                                },
                                                                child: Text(
                                                                    _image
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                            whiteColor)),
                                                              ),
                                                              MaterialButton(
                                                                minWidth: 150,
                                                                color:
                                                                    primaryColor,
                                                                onPressed: () => Navigator.of(
                                                                        context)
                                                                    .pushReplacement(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const ShowTickets())),
                                                                child: const Text(
                                                                    "contact admin by tickets",
                                                                    style: TextStyle(
                                                                        color:
                                                                            whiteColor)),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 200,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                MaterialButton(
                                                                  minWidth: 150,
                                                                  color:
                                                                      primaryColor,
                                                                  onPressed: () => decision(
                                                                      currentItem[
                                                                          '_id'],
                                                                      0,
                                                                      currentItem['cart_details']
                                                                              [
                                                                              'quantity']
                                                                          as int),
                                                                  child: Text(
                                                                      actions[
                                                                          0],
                                                                      style: const TextStyle(
                                                                          color:
                                                                              whiteColor)),
                                                                ),
                                                                MaterialButton(
                                                                  minWidth: 150,
                                                                  color:
                                                                      primaryColor,
                                                                  onPressed: () => decision(
                                                                      currentItem[
                                                                          '_id'],
                                                                      1,
                                                                      currentItem['cart_details']
                                                                              [
                                                                              'quantity']
                                                                          as int),
                                                                  child: Text(
                                                                      actions[
                                                                          1],
                                                                      style: const TextStyle(
                                                                          color:
                                                                              whiteColor)),
                                                                ),
                                                                MaterialButton(
                                                                  minWidth: 150,
                                                                  color:
                                                                      primaryColor,
                                                                  onPressed: () => decision(
                                                                      currentItem[
                                                                          '_id'],
                                                                      2,
                                                                      currentItem['cart_details']
                                                                              [
                                                                              'quantity']
                                                                          as int),
                                                                  child: Text(
                                                                      actions[
                                                                          2],
                                                                      style: const TextStyle(
                                                                          color:
                                                                              whiteColor)),
                                                                ),
                                                                MaterialButton(
                                                                  minWidth: 150,
                                                                  color: red,
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child:
                                                                      const Text(
                                                                    'Exit',
                                                                    style: TextStyle(
                                                                        color:
                                                                            whiteColor),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                );
                                              });
                                        },
                                        height: 30,
                                        width: 70,
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
