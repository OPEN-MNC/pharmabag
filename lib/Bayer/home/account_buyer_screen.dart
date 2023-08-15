import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/buyer_repositories/Auth_repo/auth_repo.dart';
import 'package:pharmabag/Bayer/components/ordersScreen_test.dart';
import 'package:pharmabag/Bayer/home/all_category/components1/legal/legal.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/Bayer/home/ticket/ticket_screen.dart';
import 'package:pharmabag/Bayer/profile/profile.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/swich/switch.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    getBuyerProfile();
    super.initState();
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Map<String, dynamic> finalData = {};
  getBuyerProfile() async {
    http.Response res = await BuyerAuth().getBuyerProfile();
    var data = jsonDecode(res.body);
    setState(() {
      finalData = data;
    });
    debugPrint('the final data is $finalData');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BuyerHome(isLoggedIn: true)));
        return true;
      },
      child: Scaffold(
        body: finalData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : ListView(
                children: [
                  Container(
                    color: primaryColor,
                    height: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi ${finalData['buyer_details']['name'].toString()},",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Buyer Id: ${finalData['buyer_details']['buyer_id'].toString().substring(0, 6)}xxxx",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Container(
                            //   height: 30,
                            //   width: 150,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(35),
                            //   ),
                            //   child: const Center(
                            //     child: Text(
                            //       'verification pending',
                            //       style: TextStyle(
                            //           color: Color.fromARGB(255, 116, 68, 64),
                            //           fontSize: 14),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              "https://media.istockphoto.com/id/1302783988/vector/the-embarrassed-man.jpg?s=612x612&w=0&k=20&c=bIPvdEHEGAP0RnSH5n45dvHfsqvZKv8NwG5qjRWCNTg="),
                          // backgroundColor: Colors.white,
                          // child: Icon(
                          //   Icons.person_outline,
                          //   size: 60,
                          //   color: Colors.black,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 30.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const OrderScreen(
                                camefromaccount: true,
                              );
                            }));
                          },
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/post-service-tracking-abstract-concept-vector-illustration-parcel-monitor-track-trace-your-shipment-package-tracking-number-express-delivery-online-shopping-mail-box-abstract-metaphor_335657-1777.jpg',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Orders",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  // Text(
                                  //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 155,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios,
                              //   size: 16,
                              // )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      // title: Text('Popup Title'),
                                      content: const LegalPage(),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://media.istockphoto.com/id/1227193799/vector/concept-law-justice-legal-service-services-of-a-lawyer-notary-men-against-the-backdrop-of.jpg?s=612x612&w=0&k=20&c=Us3rMq0B6ntAida8v9IO0dFiSUESjqOFMxowlXOLmwE=',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Legal",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      // Text(
                                      //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                      //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 180,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Accounts(
                                data: finalData,
                              );
                            }));
                          },
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/id/1188245735/vector/pay-fine-concept-vector-flat-graphic-design-illustration.jpg?s=612x612&w=0&k=20&c=VH_LN6mFqbkxpUs4rqI6Kvs5MXomrrJaAYWeRmrxC54=',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Profile",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  // Text(
                                  //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios,
                              //   size: 16,
                              // )
                            ],
                          ),
                        ),

                        const Divider(
                          color: Colors.grey,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShowTicket()));
                          },
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/id/1227193799/vector/concept-law-justice-legal-service-services-of-a-lawyer-notary-men-against-the-backdrop-of.jpg?s=612x612&w=0&k=20&c=Us3rMq0B6ntAida8v9IO0dFiSUESjqOFMxowlXOLmwE=',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tickets",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  // Text(
                                  //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 180,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          },
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/gdpr-concept-illustration_114360-1028.jpg?w=360',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login as Seller",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  // Text(
                                  //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 115,
                              ),
                              // const Icon(
                              //   Icons.arrow_forward_ios,
                              //   size: 16,
                              // )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        // const Row(
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 30,
                        //       backgroundImage: NetworkImage(
                        //         'https://img.freepik.com/premium-vector/mobile-commerce-concept-with-people-scene-flat-cartoon-design-woman-sells-goods-shop-website-customer-buys-them-online-using-mobile-application-vector-illustration-visual-story-web_9209-9419.jpg',
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Buying & Selling",
                        //           style: TextStyle(
                        //               color: Colors.black, fontSize: 14),
                        //         ),
                        //         // Text(
                        //         //   "wfkhfiur reifjbrueibf i \nrifuierbf rufhreuf",
                        //         //   style: TextStyle(color: Colors.grey, fontSize: 12),
                        //         // ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       width: 115,
                        //     ),
                        //     // const Icon(
                        //     //   Icons.arrow_forward_ios,
                        //     //   size: 16,
                        //     // )
                        //   ],
                        // ),
                        // const Divider(
                        //   color: Colors.grey,
                        // ),
                        // // const Divider(
                        // //   color: Colors.grey,
                        // // ),
                        // const Row(
                        //   children: [
                        //     CircleAvatar(
                        //       radius: 30,
                        //       backgroundImage: NetworkImage(
                        //         'https://img.freepik.com/premium-vector/delivery-tracking-concept-3d-illustration-icon-composition-with-mobile-app-interface-with-pins-map-route-parcels-boxes-clock-fast-shipping-service-vector-illustration-modern-web-design_198565-1679.jpg?w=2000',
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Shipping & Tracking",
                        //           style: TextStyle(
                        //               color: Colors.black, fontSize: 14),
                        //         ),
                        //         // Text(
                        //         //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                        //         //   style: TextStyle(color: Colors.grey, fontSize: 12),
                        //         // ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       width: 90,
                        //     ),
                        //     // const Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        // )
                        //   ],
                        // ),
                        // const Divider(
                        //   color: Colors.grey,
                        // ),

                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-vector/flat-design-illustration-customer-support_23-2148887720.jpg',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact Us",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                // Text(
                                //   "wfkhfiur reifjbrueibf \ni rifuierbf rufhreuf",
                                //   style: TextStyle(color: Colors.grey, fontSize: 12),
                                // ),
                              ],
                            ),
                            // const SizedBox(
                            //   width: 90,
                            // ),
                            // const Icon(
                            //   Icons.arrow_forward_ios,
                            //   size: 16,
                            // )
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: CupertinoButton(
                      color: const Color.fromARGB(255, 93, 90, 241),
                      child: const Text("Log Out"),
                      onPressed: () {
                        _storage.delete(key: 'buyertoken');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const swich()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }
}
