// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/components_&_color/search_bar.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class helpPage extends StatefulWidget {
  const helpPage({Key? key}) : super(key: key);

  @override
  State<helpPage> createState() => _helpPageState();
}

class _helpPageState extends State<helpPage> {
  // List<String> _searchResults = [];

  void _handleSearch(String query) {
    // TODO: implement search logic
    setState(() {
      // _searchResults = ['Result 1', 'Result 2', 'Result 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const ReusableText(
            text: "Help", fontSize: 20, fontcolor: primaryColor),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: blackColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReusableText(
                  text: "Welcome to help center",
                  fontSize: 20,
                  fontcolor: primaryColor),
              const ReusableText(
                  text: "How can we help you today?",
                  fontSize: 12,
                  fontcolor: blackColor),
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ReusableText(
                  text: "Or select a category you are interested in",
                  fontSize: 15,
                  fontcolor: blackColor),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                              'https://img.freepik.com/free-vector/delivery-point-abstract-concept-vector-illustration-delivery-point-validation-courier-driver-app-shipping-company-post-office-tracking-application-pick-up-parcel-abstract-metaphor_335657-1746.jpg?w=2000',
                              width: 60, // set the width of the image
                              height: 60, // set the height of the image
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: "Shipping & Tracking",
                                  fontSize: 13,
                                  fontcolor: blackColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "Amet minim mollit non",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "deserunt ullamco,",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    color: greyColor,
                                  )),
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
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                              'https://img.freepik.com/free-vector/express-delivery-service-flat_335657-3152.jpg',
                              width: 60, // set the width of the image
                              height: 60, // set the height of the image
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: "Shipping & Tracking",
                                  fontSize: 13,
                                  fontcolor: blackColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "Amet minim mollit non",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "deserunt ullamco,",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    color: greyColor,
                                  )),
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
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                              'https://as1.ftcdn.net/v2/jpg/04/85/63/28/1000_F_485632861_e1QsniLyeDtEJVRUF8KYdbBXS54coWap.jpg',
                              width: 60, // set the width of the image
                              height: 60, // set the height of the image
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: "Shipping & Tracking",
                                  fontSize: 13,
                                  fontcolor: blackColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "Amet minim mollit non",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "deserunt ullamco,",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    color: greyColor,
                                  )),
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
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                              // 'https://img.freepik.com/free-vector/express-delivery-service-flat_335657-3152.jpg',
                              'https://cdni.iconscout.com/illustration/premium/thumb/buying-and-selling-online-and-e-commerce-6284115-5207340.png',
                              width: 60, // set the width of the image
                              height: 60, // set the height of the image
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                  text: "Shipping & Tracking",
                                  fontSize: 13,
                                  fontcolor: blackColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "Amet minim mollit non",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                              SizedBox(
                                height: 3,
                              ),
                              ReusableText(
                                  text: "deserunt ullamco,",
                                  fontSize: 11,
                                  fontcolor: greyColor),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    color: greyColor,
                                  )),
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
            ],
          ),
        ),
      ),
    );
  }
}
