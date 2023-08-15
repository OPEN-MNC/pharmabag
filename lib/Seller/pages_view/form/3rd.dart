import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class therdForm extends StatelessWidget {
  const therdForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "GST", fontSize: 13, fontcolor: primaryColor),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'GST in %',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 125,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "MRP", fontSize: 13, fontcolor: primaryColor),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Amt in Rs.',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ReusableText(
              text: "Final PTR", fontSize: 13, fontcolor: primaryColor),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Amt in Rs.',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
