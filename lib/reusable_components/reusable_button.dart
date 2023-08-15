import 'package:flutter/material.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

// class ReusebleButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color buttoncolor;
//   final Color textcolor;

//   const ReusebleButton({
//     Key? key,
//     required this.text,
//     required this.buttoncolor,
//     required this.textcolor,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(

//       onPressed: onPressed,
//       style: ButtonStyle(

//         fixedSize:

//         // primary: buttoncolor, // background color
//         // onPrimary: textcolor, // text color
//         // shape: RoundedRectangleBorder(
//         //   borderRadius: BorderRadius.circular(9), // rounded corners
//         // ),
//         // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // button padding
//       ),

//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 16, // text size
//           fontWeight: FontWeight.bold, // text weight
//         ),
//       ),
//     );
//   }
// }

class ReusebleButton extends StatelessWidget {
  final String buttonText;
  final double height;
  final double width;
  final VoidCallback onPressed;
  final Color buttoncolor;
  final Color textcolor;
  final double fontSize;
  final double borderRadius;

  const ReusebleButton({
    Key? key,
    required this.buttonText,
    required this.buttoncolor,
    required this.textcolor,
    required this.onPressed,
    this.height = 50.0,
    this.width = 200.0,
    this.borderRadius = 4.9,
    this.fontSize = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: buttoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2.0,
        ),
        child: ReusableText(
          text: buttonText,
          fontSize: fontSize,
          fontcolor: textcolor,
        ),
      ),
    );
  }
}

class ReusebleTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ReusebleTextButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: child);
  }
}
