import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class settlementPage extends StatelessWidget {
  const settlementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: blackColor,
            )),
        title: const Text(
          "Settlements",
          style: TextStyle(color: greyColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 20),
                      child: ReusableContainer(
                        height: 100,
                        width: 315,
                        color: whiteColor,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(29, 47, 2, 207),
                                    radius: 18,
                                    child: Icon(
                                      Icons.shopping_bag_outlined,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  ReusableText(
                                      text: "Order date",
                                      fontSize: 10,
                                      fontcolor: greyColor),
                                  ReusableText(
                                      text: "12/11/20",
                                      fontSize: 9,
                                      fontcolor: greyColor),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: "OD200054579 | 501 | COD",
                                      fontSize: 11,
                                      fontcolor: primaryColor),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ReusableText(
                                      text: "₹4062 | 2% | ₹50",
                                      fontSize: 10,
                                      fontcolor: greyColor),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ReusableText(
                                      text: "Net Amt - ₹3607",
                                      fontSize: 17,
                                      fontcolor: blackColor),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReusebleTextButton(
                      onPressed: () {},
                      child: const ReusableText(
                          text: "See all", fontSize: 13, fontcolor: greyColor)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ReusableText(
                      text: "Remmitance Advice",
                      fontSize: 15,
                      fontcolor: blackColor),
                  ReusableContainer(
                      width: 60,
                      height: 35,
                      color: greenColor,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Center(
                              child: Icon(
                            Icons.download,
                            color: whiteColor,
                            size: 22,
                          )))),
                ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(29, 47, 2, 207),
                                    radius: 18,
                                    child: Icon(
                                      Icons.shopping_bag_outlined,
                                      color: primaryColor,
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  ReusableText(
                                      text: "Order date",
                                      fontSize: 10,
                                      fontcolor: greyColor),
                                  ReusableText(
                                      text: "12/11/20",
                                      fontSize: 9,
                                      fontcolor: greyColor),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                      text: "OD200054579 | 501 | COD",
                                      fontSize: 11,
                                      fontcolor: primaryColor),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ReusableText(
                                      text: "₹4062 | 2% | ₹50",
                                      fontSize: 10,
                                      fontcolor: greyColor),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ReusableText(
                                      text: "Net Amt - ₹3607",
                                      fontSize: 17,
                                      fontcolor: blackColor),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
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
