import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/components_&_color/search_bar.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class orderPage extends StatefulWidget {
  const orderPage({Key? key}) : super(key: key);

  @override
  State<orderPage> createState() => _orderPageState();
}

List<String> _searchResults1 = [];

class _orderPageState extends State<orderPage> with TickerProviderStateMixin {
  void _handleSearch(String query) {
    // TODO: implement search logic
    setState(() {
      _searchResults1 = ['Result 1', 'Result 2', 'Result 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(
      length: 3,
      vsync: this,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              //  ReusableContainer(
              //    width: 350, height: 50, color: Colors.transparent,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: TabBar(
              //      indicator: BoxDecoration(
              //        color: primaryColor,
              //        borderRadius: BorderRadius.circular(25.5),
              //      ),
              //      labelColor: whiteColor,
              //      unselectedLabelColor: primaryColor,
              //      tabs: const [
              //       Tab(text: 'Pending order',),
              //       Tab(text: 'Past orders',),
              //      ]),

              // toggle bar section
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(19, 76, 49, 226)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const ReusableContainer(
                            width: 130,
                            height: 45,
                            color: primaryColor,
                            child: Center(
                                child: ReusableText(
                                    text: "Pending order",
                                    fontSize: 12,
                                    fontcolor: whiteColor))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const orderPage()),
                          );
                        },
                      ),
                      GestureDetector(
                        child: const ReusableContainer(
                            width: 130,
                            height: 45,
                            color: whiteColor,
                            child: Center(
                                child: ReusableText(
                                    text: "Past orders",
                                    fontSize: 12,
                                    fontcolor: primaryColor))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Past_orders()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              //  )),

              // const TabBarView(
              //  children: [
              //    // Chats(),
              //    Center(child: ReusableText(text: "text", fontSize: 22, fontcolor: red)),//Pending_order(),),
              //    Center(child: ReusableText(text: "text 2", fontSize: 22, fontcolor: greenColor)),//Past_orders(),),
              //                ]),

              const SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusebleSearchBar(
                    hintText: 'Search...',
                    onChanged: (query) => _handleSearch(query),
                  ),
                  // ReusebleSearchBar(onSearch: _handleSearch),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.tune)),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // itemCount: _searchResults.length,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2, top: 20),
                    child: Expanded(
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17, top: 17),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 25,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: greenColor,
                                      width: 1,
                                    )),
                                child: const Center(
                                    child: ReusableText(
                                        text: "Order in Transit",
                                        fontSize: 11.5,
                                        fontcolor: primaryColor)),
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'https://cpimg.tistatic.com/05312844/b/5/Itraconazole-200mg-Tab.jpg',
                                    width: 80, // set the width of the image
                                    height: 60, // set the height of the image
                                    fit: BoxFit
                                        .cover, // set how the image should be scaled to fit its container
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: "Itrasys 100 Capsule",
                                          fontSize: 13,
                                          fontcolor: primaryColor),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      ReusableText(
                                          text: "20/07/2023",
                                          fontSize: 12,
                                          fontcolor: greyColor),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          ReusableText(
                                              text: "Total Price",
                                              fontSize: 12,
                                              fontcolor: blackColor),
                                          ReusableText(
                                              text: " ₹189626259569.25",
                                              fontSize: 12,
                                              fontcolor: primaryColor),
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
                                  const Column(
                                    children: [
                                      ReusableText(
                                          text: "Order ID",
                                          fontSize: 11,
                                          fontcolor: primaryColor),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      ReusableText(
                                          text: "1256",
                                          fontSize: 10,
                                          fontcolor: blackColor),
                                    ],
                                  ),

                                  const Column(
                                    children: [
                                      ReusableText(
                                          text: "Order Qty",
                                          fontSize: 11,
                                          fontcolor: primaryColor),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      ReusableText(
                                          text: "123456222555",
                                          fontSize: 10,
                                          fontcolor: blackColor),
                                    ],
                                  ),

                                  //  Column(
                                  //    children: const [

                                  //      ReusableText(text: "Units remaining", fontSize: 9, fontcolor: primaryColor),
                                  //      SizedBox(height: 8,),
                                  //      ReusableText(text: "6542", fontSize: 11, fontcolor: blackColor),

                                  //    ],
                                  //  ),

                                  // Column(
                                  //   children: [

                                  //     ReusableText(text: "Total sale value", fontSize: 10, fontcolor: primaryColor),
                                  //     SizedBox(height: 8,),
                                  //     ReusableText(text: "1458526", fontSize: 11, fontcolor: blackColor),

                                  //   ],
                                  // ),

                                  ElevatedButton(
                                    onPressed: () {
                                      // Button onPressed action
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          primaryColor, // Set the text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the border radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),

                                  ReusebleButton(
                                    buttonText: "Replay",
                                    buttoncolor: primaryColor,
                                    textcolor: whiteColor,
                                    onPressed: () {},
                                    height: 36,
                                    width: 80,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Past_orders extends StatefulWidget {
  const Past_orders({Key? key}) : super(key: key);

  @override
  State<Past_orders> createState() => _Past_ordersState();
}

List<String> _searchResults3 = [];

class _Past_ordersState extends State<Past_orders> {
  void _handleSearch(String query) {
    // TODO: implement search logic
    setState(() {
      _searchResults3 = ['Result 1', 'Result 2', 'Result 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(19, 76, 49, 226)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const ReusableContainer(
                            width: 130,
                            height: 45,
                            color: whiteColor,
                            child: Center(
                                child: ReusableText(
                                    text: "Pending order",
                                    fontSize: 12,
                                    fontcolor: primaryColor))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const orderPage()),
                          );
                        },
                      ),
                      GestureDetector(
                        child: const ReusableContainer(
                            width: 130,
                            height: 45,
                            color: primaryColor,
                            child: Center(
                                child: ReusableText(
                                    text: "Past orders",
                                    fontSize: 12,
                                    fontcolor: whiteColor))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Past_orders()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusebleSearchBar(
                    hintText: 'Search...',
                    onChanged: (query) => _handleSearch(query),
                  ),
                  // ReusebleSearchBar(onSearch: _handleSearch),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.tune)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 20),
                      child: ReusableContainer(
                        height: 100,
                        width: 315,
                        color: whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                          text: "Amlokind 5mg Tablet",
                                          fontSize: 11,
                                          fontcolor: primaryColor),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      ReusableText(
                                          text: "OD200053697 | 453 | Prepaid",
                                          fontSize: 10,
                                          fontcolor: greyColor),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 50),
                                        child: Row(
                                          children: [
                                            ReusableText(
                                                text: "₹2345",
                                                fontSize: 15,
                                                fontcolor: blackColor),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            ReusableContainer(
                                                width: 90,
                                                height: 25,
                                                color: greenColor,
                                                child: Center(
                                                    child: ReusableText(
                                                        text: "Delivered",
                                                        fontSize: 12,
                                                        fontcolor:
                                                            whiteColor))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: orangeColor,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.download,
                                                color: greenColor,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // SizedBox(),
                              // ReusableText(text: "Placed on 12/12/21", fontSize: 11, fontcolor: greyColor),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class Past_orders1 extends StatefulWidget {
  const Past_orders1({Key? key}) : super(key: key);

  @override
  State<Past_orders1> createState() => _Past_orders1State();
}

List<String> _searchResults2 = [];

class _Past_orders1State extends State<Past_orders1> {
  void _handleSearch(String query) {
    // TODO: implement search logic
    setState(() {
      _searchResults2 = ['Result 1', 'Result 2', 'Result 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const ReusableContainer(
                      width: 130,
                      height: 45,
                      color: whiteColor,
                      child: Center(
                          child: ReusableText(
                              text: "Pending order",
                              fontSize: 12,
                              fontcolor: primaryColor))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const orderPage()),
                    );
                  },
                ),
                GestureDetector(
                  child: const ReusableContainer(
                      width: 130,
                      height: 45,
                      color: primaryColor,
                      child: Center(
                          child: ReusableText(
                              text: "Past orders",
                              fontSize: 12,
                              fontcolor: whiteColor))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Past_orders1()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusebleSearchBar(
                  hintText: 'Search...',
                  onChanged: (query) => _handleSearch(query),
                ),
                // ReusebleSearchBar(onSearch: _handleSearch),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.tune)),
                  ),
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 2, top: 20),
                    child: ReusableContainer(
                      height: 100,
                      width: 315,
                      color: whiteColor,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Amlokind 5mg Tablet",
                                    fontSize: 11,
                                    fontcolor: primaryColor),
                                SizedBox(),
                                ReusableText(
                                    text: "Placed on 12/12/21",
                                    fontSize: 11,
                                    fontcolor: greyColor),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            ReusableText(
                                text: "OD200053697 | Prepaid",
                                fontSize: 10,
                                fontcolor: greyColor),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(
                                      text: "₹2345",
                                      fontSize: 15,
                                      fontcolor: blackColor),
                                  ReusableContainer(
                                      width: 100,
                                      height: 25,
                                      color: greenColor,
                                      child: Center(
                                          child: ReusableText(
                                              text: "Confirmed",
                                              fontSize: 12,
                                              fontcolor: whiteColor))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
