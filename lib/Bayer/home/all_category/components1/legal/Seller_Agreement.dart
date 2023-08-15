import 'package:flutter/material.dart';

import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

import '../../../../theme/custom_theme.dart';

class Seller_Agreement extends StatelessWidget {
  const Seller_Agreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Seller Agreement",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 15,
          itemBuilder: (context, index) {
            // var currentItem = productData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: CustomTheme.cardShadow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(children: [
                            ReusableText(
                                text: "enter the quations or points ?",
                                fontSize: 16,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 10,
                            ),
                            ReusableText(
                                text:
                                    "However, as the workaround description implies, this separate tracking carries the risk of someone still being served the same ad even after the limit has been exceeded.‘NO WAY TO PROPERLY MANAGE FREQUENCY ON TWO AD SERVERS: THE AD TECH HITCH IN DISNEYS AND VIACOMCBSS STREAMING UPFRONT PITCHES | TIM PETERSON | AUGUST 27, 2020 | DIGIDAY",
                                fontSize: 12,
                                fontcolor: greyColor),
                          ]),
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
