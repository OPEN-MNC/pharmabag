// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/Seller/Account/account.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/Seller/Tickets/ticket_show.dart';
import 'package:pharmabag/Seller/authentication/login.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/swich/switch.dart';
import 'package:quickalert/quickalert.dart';

import '../../repositories/auth_repo/auth_repo.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  TextEditingController dateController = TextEditingController();
  String mode = 'Off';
  String vacationvariable = 'Vacation Mode';

  getMode() async {
    mode = await _storage.read(key: 'Vacation').then((value) {
      return value.toString();
    });
    setState(() {
      mode = mode;
      // print(sellerData.runtimeType);
    });
    return mode;
  }

  @override
  void initState() {
    getMode();
    getDetails();
    super.initState();
  }

  Map<String, dynamic> sellerData = {};
  getDetails() async {
    Response res = await AuthRepo().getSellerProfile();
    // print(res.body);
    setState(() {
      sellerData = jsonDecode(res.body);
      // print(sellerData.runtimeType);
    });
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  vacation() async {
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    const String url = 'https://pharmabag.in:3000/seller/go/for/vacation';
    var body = {"expire_date": dateController.text};
    var data = jsonEncode(body).toString();
    var res = await http.post(Uri.parse(url), body: data, headers: {
      'content-type': 'application/json',
      'auth-token': token
    }).then((value) {
      setState(() {
        dateController.text = '';
        mode = "On";
      });
      var data = jsonDecode(value.body);
      if (value.statusCode == 200) {
        _storage.write(key: 'Vacation', value: 'on');

        QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            title: 'Vacation Mode is On',
            text:
                'You are on vacation till ${data['expire_date'].toString().substring(0, 10)}',
            confirmBtnText: 'Okay',
            onConfirmBtnTap: () => Navigator.pop(context));
      }
    });
  }

  end() async {
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    const String url = 'https://pharmabag.in:3000/seller/end/vacation';

    var res = await http.post(Uri.parse(url), headers: {
      'content-type': 'application/json',
      'auth-token': token
    }).then((value) {
      // print(value.statusCode);
      // print(value.body);
      if (value.statusCode == 200) {
        _storage.write(key: 'Vacation', value: 'off');
        setState(() {
          mode = "Off";
        });

        var data = jsonDecode(value.body);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: 'Vacation Mode is Off',
          confirmBtnText: 'Okay',
          onConfirmBtnTap: () => Navigator.pop(context),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String x = '$vacationvariable: $mode';
    return Scaffold(
      body: sellerData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : ListView(
              children: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accounts(data: sellerData))),
                  child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: primaryColor),
                      accountEmail: Text(
                          sellerData['seller_details']['email'].toString()),
                      accountName:
                          Text(sellerData['seller_details']['name'].toString()),
                      currentAccountPicture: const CircleAvatar(
                          foregroundImage:
                              AssetImage("assets/images/avatar-1.png"))),
                ),

                ListTile(
                  // leading: const Icon(Icons.local_mall),
                  leading: const Icon(Icons.all_inbox),
                  title: const Text(
                    'Inventory',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const BottomNavBarpage(
                              gIndex: 3,
                            ))));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.support_agent),
                  title: const Text(
                    'Tickets',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowTickets(
                              user: sellerData['seller_details']['name']
                                  .toString()))),
                ),

                ListTile(
                  leading: const Icon(Icons.fact_check),
                  title: const Text(
                    'Settlement',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const BottomNavBarpage(
                              gIndex: 2,
                            ))));
                  },
                ),

                // ListTile(
                //   leading: const Icon(Icons.notifications),
                //   title: const Text(
                //     'Notifications',
                //     style: TextStyle(fontSize: 17),
                //   ),
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: ((context) => const notificationPage())));
                //   },
                // ),

                ListTile(
                  leading: const Icon(Icons.auto_graph),
                  title: const Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBarpage(
                                  gIndex: 1,
                                )));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    'Account',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accounts(
                                data: sellerData,
                              ))),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 100),
                  child: ElevatedButton(
                    onPressed: () async {
                      String mode =
                          await _storage.read(key: 'Vacation').then((value) {
                        return value.toString();
                      });
                      if (mode == 'on') {
                        _storage.read(key: 'Vacation').then((value) {
                          end();
                        });
                      } else {
                        _storage.read(key: 'Vacation').then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        const Text(
                                            'How many days you will go for vacation'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              hintText: 'dd/mm/yyyy',
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColor,
                                                      width: 0.6)),
                                              suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    final selectedData =
                                                        await showDatePicker(
                                                                initialEntryMode:
                                                                    DatePickerEntryMode
                                                                        .calendar,
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime
                                                                        .now(),
                                                                lastDate:
                                                                    DateTime(
                                                                        9999))
                                                            .then((value) {
                                                      dateController.text =
                                                          value
                                                              .toString()
                                                              .substring(0, 10);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.calendar_month))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      color: primaryColor,
                                      onPressed: () => vacation(),
                                      child: const Text(
                                        'Okay',
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: red,
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    )
                                  ],
                                );
                              });
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 40),
                      backgroundColor: primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    child: Text(
                      x,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                //sing Out button
                const SizedBox(height: 10),

                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () {
                    _storage
                        .delete(key: 'token')
                        .then((value) => QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              title: 'Do You really want to logout?',
                              confirmBtnText: 'Okay',
                              onConfirmBtnTap: () => {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()))
                              },
                            ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text(
                    'Login as Buyer',
                    style: TextStyle(fontSize: 17),
                  ),
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => buyerHomePage())),
                ),

                // Center(
                //   child: ElevatedButton(

                //     child: const Text('Log out',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17,
                //     ),
                //     ),
                //     onPressed: () {
                //       print('button pressed');

                //      },
                //      style: ElevatedButton.styleFrom(
                //       minimumSize: const Size(200, 40),
                //       backgroundColor: const Color.fromARGB(245, 86, 180, 57),
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(50)),
                //       ),
                //   ),
                // ),
                // ),

                //  ------------ Add More option in drawer ------------
              ],
            ),
    );
  }
}
