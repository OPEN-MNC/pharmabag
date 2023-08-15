import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/reusable_button.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:image_picker/image_picker.dart';

class fourthForm extends StatefulWidget {
  const fourthForm({Key? key}) : super(key: key);

  @override
  State<fourthForm> createState() => _fourthFormState();
}

class _fourthFormState extends State<fourthForm> {
  File? _image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),

          const ReusableText(
              text: "Upload a picture of your product",
              fontSize: 14,
              fontcolor: primaryColor),
          const ReusableText(
              text: "Show how the product looks for better clarity,",
              fontSize: 10,
              fontcolor: blackColor),
          const ReusableText(
              text: "it is recommended to add a product description",
              fontSize: 10,
              fontcolor: blackColor),
          const SizedBox(
            height: 20,
          ),

          if (_image != null)
            Center(
              child: GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.file(
                    _image!,
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () => pickImage(ImageSource.gallery),
              ),
            )
          else
            Center(
              child: GestureDetector(
                child: Container(
                  height: 130,
                  width: 240,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: greyColor,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.folder,
                    size: 75,
                    color: greyColor,
                  )),
                ),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  debugPrint("open cammera section and file");
                },
              ),
            ),

          const SizedBox(
            height: 10,
          ),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableText(
                  text: "Drag drop ", fontSize: 11.5, fontcolor: primaryColor),
              ReusableText(
                  text: "your file here or Browse",
                  fontSize: 11.5,
                  fontcolor: blackColor),
              ReusableText(
                  text: "Browse", fontSize: 11.5, fontcolor: primaryColor),
            ],
          ),

          //  SizedBox(height: 25,),

          // ReusableText(text: "Product description", fontSize: 13, fontcolor: primaryColor),
          // SizedBox(height: 15,),
          // TextField(
          //             maxLines: 3,
          //             decoration: InputDecoration(
          //                 hintText: 'Explain your composition',

          //                 border: OutlineInputBorder(
          //                   borderSide: BorderSide(
          //                     color: primaryColor,
          //                   ),
          //                 )),
          //           ),

          const SizedBox(
            height: 20,
          ),

          Center(
              child: ReusebleButton(
            buttonText: "Submit",
            buttoncolor: primaryColor,
            textcolor: whiteColor,
            onPressed: () {},
            fontSize: 17,
          )),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
