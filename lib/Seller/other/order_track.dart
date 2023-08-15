import 'package:flutter/material.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  bool _state = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: CustomAppBar(
            title: 'OD200054579 | 501 | COD',
            subtitle: 'Confirmed order',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                // ReusableContainer(width: 500, height: 120, color: whiteColor,

                Container(
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: lightGrey),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'https://media.istockphoto.com/id/1252761829/photo/medical-objects-on-the-white-table.jpg?s=612x612&w=0&k=20&c=yxchn0Qej2lKOTUicATqcW2Iyk3MQ0ZxzK4csVICLQY=',
                                width: 60, // set the width of the image
                                height: 40, // set the height of the image
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://pharmabag.in/image/logo/logo-edited.png",
                                height: 80,
                                width: 80,
                                fit: BoxFit.contain,
                              );
                            } // set how the image should be scaled to fit its container
                                ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ReusableText(
                                text: "ESLO 2.5MG TABLET",
                                fontSize: 14,
                                fontcolor: blackColor),
                            ReusableText(
                                text: "Placed on 12/11/20",
                                fontSize: 10,
                                fontcolor: greyColor),
                            ReusableText(
                                text: "₹4062 | MRP ₹91",
                                fontSize: 13,
                                fontcolor: primaryColor),
                            ReusableText(
                                text: "7% disount",
                                fontSize: 12,
                                fontcolor: greenColor),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (_state == true) {
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: lightGrey),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.network(
                                                        'https://media.istockphoto.com/id/1252761829/photo/medical-objects-on-the-white-table.jpg?s=612x612&w=0&k=20&c=yxchn0Qej2lKOTUicATqcW2Iyk3MQ0ZxzK4csVICLQY=',
                                                        width:
                                                            60, // set the width of the image
                                                        height:
                                                            40, // set the height of the image
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                      return Image.network(
                                                        "https://pharmabag.in/image/logo/logo-edited.png",
                                                        height: 80,
                                                        width: 80,
                                                        fit: BoxFit.contain,
                                                      );
                                                    } // set how the image should be scaled to fit its container
                                                        ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            "ESLO 2.5MG TABLET",
                                                        fontSize: 14,
                                                        fontcolor: blackColor),
                                                    ReusableText(
                                                        text:
                                                            "Placed on 12/11/20",
                                                        fontSize: 10,
                                                        fontcolor: greyColor),
                                                    ReusableText(
                                                        text: "₹4062 | MRP ₹91",
                                                        fontSize: 13,
                                                        fontcolor:
                                                            primaryColor),
                                                    ReusableText(
                                                        text: "7% disount",
                                                        fontSize: 12,
                                                        fontcolor: greenColor),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          color: primaryColor,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            "Order placed by:",
                                                        fontSize: 12,
                                                        fontcolor: blackColor),
                                                    ReusableText(
                                                        text: "Packing:",
                                                        fontSize: 12,
                                                        fontcolor: blackColor),
                                                    ReusableText(
                                                        text: "GSTIN(or PAN):",
                                                        fontSize: 12,
                                                        fontcolor: blackColor),
                                                    ReusableText(
                                                        text: "GST:",
                                                        fontSize: 12,
                                                        fontcolor: blackColor),
                                                    ReusableText(
                                                        text: "Quantity:",
                                                        fontSize: 12,
                                                        fontcolor: blackColor),
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            "Bhagabati Enterprise",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            primaryColor),
                                                    ReusableText(
                                                        text: "Tablet",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            primaryColor),
                                                    ReusableText(
                                                        text: "6ACQPB1111K2ZX",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            primaryColor),
                                                    ReusableText(
                                                        text: "12%",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            primaryColor),
                                                    ReusableText(
                                                        text: "60",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            primaryColor),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _state = false;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: primaryColor,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                const traker(),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableContainer(
                          height: 40,
                          width: 140,
                          color: primaryColor,
                          child: ReusebleTextButton(
                              onPressed: () {},
                              child: const ReusableText(
                                  text: "Download Invoice",
                                  fontSize: 12,
                                  fontcolor: whiteColor))),
                      ReusableContainer(
                          height: 40,
                          width: 140,
                          color: primaryColor,
                          child: ReusebleTextButton(
                              onPressed: () {},
                              child: const ReusableText(
                                  text: "Need Help",
                                  fontSize: 12,
                                  fontcolor: whiteColor))),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: whiteColor,
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 40,
              ),
              const CircleAvatar(
                backgroundColor: whiteColor,
                radius: 16,
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: blackColor,
                  size: 16,
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3.4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class traker extends StatefulWidget {
  const traker({Key? key}) : super(key: key);

  @override
  State<traker> createState() => _trakerState();
}

class _trakerState extends State<traker> {
  @override
  Widget build(BuildContext context) {
    return OrderTrackerZen(
      success_color: primaryColor,
      screen_background_color: lightGrey,
      tracker_data: [
        TrackerData(
          title: "In transit",
          date: "Sat, 8 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Manifested uploaded, Kolkata_Entally_C West Bengal",
              datetime: "",
            ),
          ],
        ),
        TrackerData(
          title: "Intransit",
          date: "Sat, 9 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Order has been manifested",
              datetime: "",
            ),
          ],
        ),
        TrackerData(
          title: "Confirmed",
          date: "Sat,10 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Order has been confirmed",
              datetime: "",
            ),
          ],
        ),
        TrackerData(
          title: "Processed",
          date: "Sat,10 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Order has been placed",
              datetime: "",
            ),
          ],
        ),
        TrackerData(
          title: "Placed",
          date: "Sat,10 Apr '22",
          tracker_details: [
            TrackerDetails(
              title: "Order has been placed",
              datetime: "",
            ),
          ],
        ),
      ],
    );
  }
}

// class traker extends StatelessWidget {
//    traker({Key? key}) : super(key: key);

//   List<Map<String, String>> deliveryTimeline = [
//   {
//     'title': 'Order Placement',
//     'description': 'Customer places an order',
//     'status': 'Completed',
//   },
//   {
//     'title': 'Order Confirmation',
//     'description': 'Order acknowledged by seller',
//     'status': 'Completed',
//   },
//   // Add more milestones here
// ];

//   Widget buildTimeline() {
//   return ListView.builder(
//     itemCount: deliveryTimeline.length,
//     itemBuilder: (BuildContext context, int index) {
//       return  TimelineTile(
//         alignment: TimelineAlign.manual,
//         lineXY: 0.2,
//         isFirst: index == 0,
//         isLast: index == deliveryTimeline.length - 1,
//         indicatorStyle: IndicatorStyle(
//           width: 40,
//           color: _getStatusColor(deliveryTimeline[index]['status']!),
//           padding: EdgeInsets.all(8),
//           indicator: _getStatusIcon(deliveryTimeline[index]['status']!),
//         ),
//         rightChild: Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 deliveryTimeline[index]['title']!,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 deliveryTimeline[index]['description']!,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// // Helper method to get the color based on the status
// Color _getStatusColor(String status) {
//   if (status == 'Completed') {
//     return Colors.green;
//   } else if (status == 'In Progress') {
//     return Colors.orange;
//   } else {
//     return Colors.grey;
//   }
// }

// // Helper method to get the icon based on the status
// Icon _getStatusIcon(String status) {
//   if (status == 'Completed') {
//     return Icon(Icons.check, color: Colors.white);
//   } else if (status == 'In Progress') {
//     return Icon(Icons.timer, color: Colors.white);
//   } else {
//     return Icon(Icons.radio_button_unchecked, color: Colors.white);
//   }
// }

//    @override
//   Widget build(BuildContext context) {
//     return buildTimeline();
//   }
// }
