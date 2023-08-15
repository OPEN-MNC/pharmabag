import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:quickalert/quickalert.dart';

class CancelledOrders extends StatefulWidget {
  const CancelledOrders({Key? key}) : super(key: key);

  @override
  State<CancelledOrders> createState() => CancelledOrdersState();
}

class CancelledOrdersState extends State<CancelledOrders> {
  List<dynamic> stocks = [];

  bool isLoading = false;
  getOrders() async {
    setState(() {
      isLoading = true;
    });
    final res = await AddStock().getCancelledOrders().then((value) {
      setState(() {
        stocks = value;
      });
      setState(() {
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
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
                primary: true,
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  var currentItem = stocks.reversed.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                Container(
                                  height: 20,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: red,
                                        width: 0.6,
                                      )),
                                  child: const Center(
                                      child: ReusableText(
                                          text: 'Cancelled',
                                          fontSize: 11.5,
                                          fontcolor: red)),
                                ),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // currentItem['cart_details']['product_image']
                                        //             .toString() ==
                                        //         'null'
                                        //     ? Image.network(
                                        //         'https://cpimg.tistatic.com/05312844/b/5/Itraconazole-200mg-Tab.jpg',
                                        //         width:
                                        //             80, // set the width of the image
                                        //         height:
                                        //             60, // set the height of the image
                                        //         fit: BoxFit
                                        //             .cover, // set how the image should be scaled to fit its container
                                        //       )
                                        //     : Image.network(
                                        //         currentItem['cart_details']
                                        //                 ['product_image']
                                        //             .toString(),
                                        //         loadingBuilder:
                                        //             (BuildContext context,
                                        //                 Widget child,
                                        //                 ImageChunkEvent?
                                        //                     loadingProgress) {
                                        //           if (loadingProgress == null)
                                        //             return child;
                                        //           return Center(
                                        //             child:
                                        //                 CircularProgressIndicator(
                                        //               value: loadingProgress
                                        //                           .expectedTotalBytes !=
                                        //                       null
                                        //                   ? loadingProgress
                                        //                           .cumulativeBytesLoaded /
                                        //                       loadingProgress
                                        //                           .expectedTotalBytes!
                                        //                           .toDouble()
                                        //                   : null,
                                        //             ),
                                        //           );
                                        //         },
                                        //         frameBuilder: (context, child,
                                        //             frame, wasSynchronouslyLoaded) {
                                        //           return Padding(
                                        //             padding:
                                        //                 const EdgeInsets.all(4),
                                        //             child: child,
                                        //           );
                                        //         },
                                        //         width:
                                        //             80, // set the width of the image
                                        //         height:
                                        //             60, // set the height of the image
                                        //         fit: BoxFit
                                        //             .cover, // set how the image should be scaled to fit its container
                                        //       ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const ReusableText(
                                                text: 'Product ID',
                                                fontSize: 11,
                                                fontcolor: primaryColor),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            ReusableText(
                                                text: currentItem['product_id'],
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
                                            text: "Message",
                                            fontSize: 10,
                                            fontcolor: primaryColor),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                textStyle: const TextStyle(
                                                    color: whiteColor),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: const BorderSide(
                                                        width: 2,
                                                        color: primaryColor))),
                                            onPressed: () {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.info,
                                                title: currentItem["message"],
                                                onConfirmBtnTap: () =>
                                                    Navigator.pop(context),
                                                confirmBtnColor: primaryColor,
                                                confirmBtnText: 'Okay',
                                              );
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.remove_red_eye,
                                                  size: 18,
                                                  color: whiteColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "view message",
                                                  textScaleFactor: 0.8,
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        const ReusableText(
                                            text: "Date",
                                            fontSize: 10,
                                            fontcolor: primaryColor),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        ReusableText(
                                            text: currentItem['date']
                                                .toString()
                                                .substring(0, 10)
                                                .replaceAll('-', '/'),
                                            fontSize: 11,
                                            fontcolor: blackColor),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                    // Column(
                                    //   children: [

                                    //     ReusableText(text: "Total sale value", fontSize: 10, fontcolor: primaryColor),
                                    //     SizedBox(height: 8,),
                                    //     ReusableText(text: "1458526", fontSize: 11, fontcolor: blackColor),

                                    //   ],
                                    // ),

                                    // ReusebleButton(
                                    //   buttonText: "Action",
                                    //   buttoncolor: primaryColor,
                                    //   textcolor: whiteColor,
                                    //   onPressed: () {},
                                    //   height: 30,
                                    //   width: 70,
                                    //   fontSize: 12,
                                    // ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
