// import 'package:flutter/material.dart';
// import 'package:pharmabag/components_&_color/color.dart';
// import 'package:pharmabag/reusable_components/text_textfield.dart';

// class firstform extends StatefulWidget {
//   const firstform({Key? key}) : super(key: key);

//   @override
//   State<firstform> createState() => _firstformState();
// }

// class _firstformState extends State<firstform> {
//   String? _selectedItem;
//   final TextEditingController _dropdownController = TextEditingController();
//   final List<String> dropdownItems = [
//     'Ethical',
//     'Generic',
//     'OTC',
//     'Ayurvedic',
//     'halo'
//   ];

//   String? _selectedItem1;
//   final TextEditingController _dropdownController1 = TextEditingController();
//   final List<String> dropdownItems1 = [
//     'Syrups',
//     'Capsule',
//     'Creams',
//     'Lotions',
//     'Oinment',
//     'Powders/Granules',
//     'Body Wash',
//     'Test',
//     'ihh'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _dropdownController.addListener(() {
//       _selectedItem = _dropdownController.text;
//     });
//     _dropdownController1.addListener(() {
//       _selectedItem1 = _dropdownController1.text;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             const ReusableText(
//                 text: "Name", fontSize: 15, fontcolor: primaryColor),
//             const SizedBox(
//               height: 10,
//             ),
//             const TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter Product name',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const ReusableText(
//                 text: "Company name", fontSize: 15, fontcolor: primaryColor),
//             const SizedBox(
//               height: 10,
//             ),
//             const TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter Company name"',
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const ReusableText(
//                 text: "Select Category", fontSize: 15, fontcolor: primaryColor),
//             const SizedBox(
//               height: 10,
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedItem,
//               decoration: InputDecoration(
//                 hintText: 'Select an option',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               items: dropdownItems.map((String item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedItem = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select an option';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const ReusableText(
//                 text: "Select Sub-Category",
//                 fontSize: 15,
//                 fontcolor: primaryColor),
//             const SizedBox(
//               height: 10,
//             ),
//             DropdownButtonFormField<String>(
//               value: _selectedItem1,
//               decoration: InputDecoration(
//                 hintText: 'Select an option',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               items: dropdownItems1.map((String item) {
//                 return DropdownMenuItem<String>(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedItem1 = value;
//                 });
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please select an option';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const ReusableText(
//                 text: "Expiry date", fontSize: 15, fontcolor: primaryColor),
//             const SizedBox(
//               height: 10,
//             ),
//             const DateTextField(),
//           ],
//         ),
//       ),
//     );
//   }
// }
