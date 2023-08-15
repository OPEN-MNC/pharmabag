import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/components_&_color/search_bar.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class StokasPage extends StatefulWidget {
  const StokasPage({Key? key}) : super(key: key);

  @override
  State<StokasPage> createState() => _StokasPageState();
}

class _StokasPageState extends State<StokasPage> {
  List<String> _searchResults = [];

  void _handleSearch(String query) {
    // TODO: implement search logic
    setState(() {
      _searchResults = ['Result 1', 'Result 2', 'Result 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
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

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "Complete uploading",
                        fontSize: 17,
                        fontcolor: blackColor),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                ReusableContainer(
                  height: 90,
                  width: 360,
                  color: whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, top: 17),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Itrasys 100 Capsule",
                                    fontSize: 11,
                                    fontcolor: primaryColor),
                                SizedBox(
                                  height: 4,
                                ),
                                ReusableText(
                                    text: "MANUFACTURER Mankind Pharma Ltd",
                                    fontSize: 10,
                                    fontcolor: greyColor),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "Inventory", fontSize: 17, fontcolor: blackColor),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

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
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: red,
                                width: 1,
                              )),
                          child: const Center(
                              child: ReusableText(
                                  text: "Expired",
                                  fontSize: 11.5,
                                  fontcolor: red)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ReusableText(
                                    text: "Itrasys 100 Capsule",
                                    fontSize: 11,
                                    fontcolor: primaryColor),
                                SizedBox(
                                  height: 4,
                                ),
                                ReusableText(
                                    text: "MANUFACTURER Mankind Pharma Ltd",
                                    fontSize: 10,
                                    fontcolor: greyColor),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Column(
                              children: [
                                ReusableText(
                                    text: "MRP",
                                    fontSize: 10,
                                    fontcolor: primaryColor),
                                SizedBox(
                                  height: 8,
                                ),
                                ReusableText(
                                    text: "₹67.18",
                                    fontSize: 11,
                                    fontcolor: blackColor),
                              ],
                            ),

                            const Column(
                              children: [
                                ReusableText(
                                    text: "PTR",
                                    fontSize: 10,
                                    fontcolor: primaryColor),
                                SizedBox(
                                  height: 8,
                                ),
                                ReusableText(
                                    text: "₹67.18",
                                    fontSize: 11,
                                    fontcolor: blackColor),
                              ],
                            ),

                            const Column(
                              children: [
                                ReusableText(
                                    text: "Units remaining",
                                    fontSize: 9,
                                    fontcolor: primaryColor),
                                SizedBox(
                                  height: 8,
                                ),
                                ReusableText(
                                    text: "6542",
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
                              buttonText: "Edit",
                              buttoncolor: primaryColor,
                              textcolor: whiteColor,
                              onPressed: () {},
                              height: 30,
                              width: 60,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // itemCount: _searchResults.length,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2, top: 20),
                      child: Expanded(
                        child: ReusableContainer(
                          height: 170,
                          width: 315,
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 17, top: 17),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: greenColor,
                                        width: 1,
                                      )),
                                  child: const Center(
                                      child: ReusableText(
                                          text: "Usable",
                                          fontSize: 11.5,
                                          fontcolor: greenColor)),
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
                                            fontSize: 11,
                                            fontcolor: primaryColor),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        ReusableText(
                                            text:
                                                "MANUFACTURER Mankind Pharma Ltd",
                                            fontSize: 10,
                                            fontcolor: greyColor),
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
                                            text: "MRP",
                                            fontSize: 10,
                                            fontcolor: primaryColor),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        ReusableText(
                                            text: "₹67.18",
                                            fontSize: 11,
                                            fontcolor: blackColor),
                                      ],
                                    ),

                                    const Column(
                                      children: [
                                        ReusableText(
                                            text: "PTR",
                                            fontSize: 10,
                                            fontcolor: primaryColor),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        ReusableText(
                                            text: "₹67.18",
                                            fontSize: 11,
                                            fontcolor: blackColor),
                                      ],
                                    ),

                                    const Column(
                                      children: [
                                        ReusableText(
                                            text: "Units remaining",
                                            fontSize: 9,
                                            fontcolor: primaryColor),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        ReusableText(
                                            text: "6542",
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
                                      buttonText: "Edit",
                                      buttoncolor: primaryColor,
                                      textcolor: whiteColor,
                                      onPressed: () {},
                                      height: 30,
                                      width: 60,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ReusebleTextButton(
                        onPressed: () {},
                        child: const ReusableText(
                            text: "See all",
                            fontSize: 15,
                            fontcolor: greyColor)),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                ReusebleButton(
                  buttonText: "Update inventory",
                  buttoncolor: primaryColor,
                  textcolor: whiteColor,
                  onPressed: () {},
                  fontSize: 17,
                ),

                const SizedBox(
                  height: 30,
                ),

                //  ReusebleTextfield(hintText: "enter name", controller: TextEditingController())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
