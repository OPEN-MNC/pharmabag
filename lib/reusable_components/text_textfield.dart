import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmabag/components_&_color/color.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color fontcolor;

  const ReusableText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: fontSize,
          color: fontcolor,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

// class ReusebleTextfield extends StatelessWidget {

//   final String hintText;
//   final IconData icon;
//   final TextEditingController controller;

//   const ReusebleTextfield({super.key ,
//     required this.hintText,
//      this.icon = Icons.person,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon),
//           hintText: hintText,
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
class ReusebleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const ReusebleTextField({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: labelText,
          border: const OutlineInputBorder(),
          focusColor: primaryColor),
      maxLines: null,
    );
  }
}

class ReusebleDateTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  const ReusebleDateTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a valid date';
          }
          return null;
        },
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            controller.text = '${date.month}/${date.day}/${date.year}';
          }
        },
      ),
    );
  }
}

class DateTextField extends StatefulWidget {
  @override
  _DateTextFieldState createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
