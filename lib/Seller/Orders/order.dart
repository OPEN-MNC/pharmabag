// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// class OrderPage extends StatelessWidget {
//   final MyVariable myVariable = MyVariable();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FirstPage(myVariable: myVariable),
//     );
//   }
// }

// class FirstPage extends StatelessWidget {
//   final MyVariable myVariable;

//   FirstPage({required this.myVariable});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Page'),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<String>(
//             stream: myVariable.valueStream,
//             initialData: myVariable.value,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!);
//               } else {
//                 return Text('No data');
//               }
//             },
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondPage(myVariable: myVariable),
//                 ),
//               );
//             },
//             child: Text('Go to Second Page'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SecondPage extends StatefulWidget {
//   final MyVariable myVariable;

//   SecondPage({required this.myVariable});

//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   late StreamSubscription<String> _subscription;
//   String currentValue = '';
//   var x = 1;
//   @override
//   void initState() {
//     super.initState();
//     currentValue = widget.myVariable.value;
//     _subscription = widget.myVariable.valueStream.listen((value) {
//       setState(() {
//         currentValue = value; // Update the value in the second page
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: Column(
//         children: [
//           Text(currentValue),
//           ElevatedButton(
//             onPressed: () {
//               widget.myVariable.setValue((x++).toString());
//             },
//             child: Text('Update Value'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyVariable {
//   String _value = '';
//   StreamController<String> _valueController =
//       StreamController<String>.broadcast();

//   Stream<String> get valueStream => _valueController.stream;
//   String get value => _value;

//   void setValue(String newValue) {
//     _value = newValue;
//     _valueController.add(newValue);
//   }

//   void dispose() {
//     _valueController.close();
//   }
// }

// void main() {
//   runApp(OrderPage());
// }

//===========================================================================================================

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/Seller/Orders/cancelled_orders.dart';
import 'package:pharmabag/Seller/Orders/custom_orders.dart';
import 'package:pharmabag/Seller/Orders/normal_orders.dart';
import 'package:pharmabag/Seller/drawer.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/add_stocks_repo/add_stock.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Notifications/notifications.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

// List<String> _searchResults1 = [];

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // void _handleSearch(String query) {
  //   // TODO: implement search logic
  //   setState(() {
  //     _searchResults1 = ['Result 1', 'Result 2', 'Result 3'];
  //   });
  // }

  List<dynamic> stocks = [];

  getOrders() async {
    final res = await AddStock().getOrders().then((value) {
      setState(() {
        stocks = value;
      });
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var actions = [
      'Placed',
      'accepted',
      'awaiting confirmation',
      'way to warehouse',
      'Reached warehouse',
      'Order in Transit',
      'Out for Delivery',
      'Order Shipped',
      'Transport delay',
      'sucessfull',
      "clear filters"
    ];
    // String getStatus(String status) {
    //   String stat = 'accepted';
    //   for (int i = 0; i < actions.length; i++) {
    //     if (status == actions[i]) {
    //       stat = actions[i];
    //       return stat;
    //     }
    //   }
    //   return stat;
    // }

    String filterBy = "";
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBarpage(
                      gIndex: 1,
                    )));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          drawer: const Drawer(
            child: Drawers(),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              actions: [
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Notifications())),
                  child: const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
              iconTheme: const IconThemeData(color: primaryColor),
              title: ReusableText(
                  text: _selectedIndex == 0
                      ? "Orders"
                      : _selectedIndex == 1
                          ? 'Custom Orders'
                          : 'Cancelled Orders',
                  fontSize: 18,
                  fontcolor: primaryColor),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              //   leading: IconButton(
              //       onPressed: () {
              //         scaffoldKey.currentState!.openDrawer();
              //         debugPrint('side bar icon pressed do something');
              //       },
              //       icon: const Icon(
              //         Icons.sort,
              //         color: primaryColor,
              //         size: 30,
              //       )),
              // ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(22),
                        child: FlutterToggleTab(
                          // width in percent
                          width: 72,
                          borderRadius: 30,
                          height: 45,
                          selectedIndex: _selectedIndex,
                          selectedBackgroundColors: const [primaryColor],
                          unSelectedBackgroundColors: const [whiteColor],
                          selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          unSelectedTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          labels: const ['Orders', 'Customs ', 'Cancelled '],
                          selectedLabelIndex: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                            _storage
                                .write(key: 'filterBy', value: "clear filters")
                                .then((value) {
                              dispatchCustomEvent("clear filters");
                            });
                          },
                          isScroll: false,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 43,
                          width: 46,
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor, width: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(12),
                            type: MaterialType.card,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: const Text(
                                              'Filter by',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            content: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.6,
                                              width: 200,
                                              child: ListView.builder(
                                                itemCount: actions.length,
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                    height: 50,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                _storage
                                                                    .write(
                                                                        key:
                                                                            'filterBy',
                                                                        value: actions[
                                                                            index])
                                                                    .then(
                                                                        (value) {
                                                                  dispatchCustomEvent(
                                                                      actions[
                                                                          index]);
                                                                });

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color:
                                                                        primaryColor),
                                                                height: 40,
                                                                width: 180,
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .tune,
                                                                          color:
                                                                              whiteColor),
                                                                      const SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        actions[
                                                                            index],
                                                                        textScaleFactor:
                                                                            0.8,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                whiteColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ))
                                                        ]),
                                                  );
                                                },
                                              ),
                                            ));
                                      });
                                },
                                icon: const Icon(
                                  Icons.tune,
                                  size: 24,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        _storage
                            .write(key: 'filterBy', value: "clear filters")
                            .then((value) {
                          dispatchCustomEvent("clear filters");
                        });
                        if (_selectedIndex == 0) {
                          //do nothing if selectded index is 0
                        } else if (_selectedIndex == 1) {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        } else {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }
                      }
                      if (details.primaryVelocity! < 0) {
                        _storage
                            .write(key: 'filterBy', value: "clear filters")
                            .then((value) => print("Yup stored to filer"));
                        if (_selectedIndex == 0) {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        } else if (_selectedIndex == 1) {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        } else {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        }
                      }
                    },
                    child: _selectedIndex == 0
                        ? const NormalOrder()
                        : _selectedIndex == 1
                            ? const CustomOrder()
                            : const CancelledOrders(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
