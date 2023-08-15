import 'package:flutter/material.dart';




class ReusableContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  // final Widget OnTapFunction;

  const ReusableContainer({
    Key? key,
     this.width =10,
     this.height = 20,
    required this.color,
    required this.child,
    // required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
    //       boxShadow: [
    //         BoxShadow(
    //           color: greyColor,
    //           spreadRadius: 1,
    //           blurRadius: 15,
    //           offset: Offset(1,2),
    //         ),
    
    // ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}








