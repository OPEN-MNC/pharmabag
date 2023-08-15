// // import 'package:flutter/material.dart';
// // var AddProductMultiStapForm =2;
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:pharmabag/Seller/pages_view/form/2nd.dart';
// import 'package:pharmabag/Seller/pages_view/form/3rd.dart';
// import 'package:pharmabag/Seller/pages_view/form/4th.dart';

// // var stateOfkey = GlobalKey<ScaffoldState>();

// // class productAddForm extends StatefulWidget {

// //   @override
// //   _productAddFormState createState() => _productAddFormState();
// // }

// // class _productAddFormState extends State<productAddForm> {
// //   int _currentStep = 0;
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _addressController = TextEditingController();

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     _phoneController.dispose();
// //     _addressController.dispose();
// //     super.dispose();
// //   }

// //   List<Step> _buildSteps() {
// //     return [
// //       Step(
// //         title: Text('Product details'),
// //         content: Column(
// //           children: [
// //             TextFormField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter product name',
// //               ),
// //               validator: (value) {
// //                 if (value!.isEmpty) {
// //                   return 'Please enter your valide name';
// //                 }
// //                 return null;
// //               },
// //             ),
// //             TextFormField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Company name',
// //               ),
// //               validator: (value) {
// //                 if (value!.isEmpty) {
// //                   return 'Please enter';
// //                 }
// //                 return null;
// //               },
// //             ),

// //             ManureDropdown(),
// //             DateSelectionMenu(),

// //             // TextFormField(
// //             //   controller: _nameController,
// //             //   decoration: InputDecoration(
// //             //     hintText: 'Medicine type',
// //             //   ),
// //             //   validator: (value) {
// //             //     if (value!.isEmpty) {
// //             //       return 'Please enter';
// //             //     }
// //             //     return null;
// //             //   },
// //             // ),
// //           ],
// //         ),
// //         isActive: _currentStep == 0,
// //       ),
// //       Step(
// //         title: Text('Quantity and discounts'),
// //         content: TextFormField(
// //           controller: _emailController,
// //           decoration: InputDecoration(
// //             hintText: 'Enter your email',
// //           ),
// //           validator: (value) {
// //             if (value!.isEmpty) {
// //               return 'Please enter your email';
// //             }
// //             if (!value.contains('@')) {
// //               return 'Please enter a valid email';
// //             }
// //             return null;
// //           },
// //         ),
// //         isActive: _currentStep == 1,
// //       ),
// //       Step(
// //         title: Text('Password'),
// //         content: TextFormField(
// //           controller: _passwordController,
// //           decoration: InputDecoration(
// //             hintText: 'Enter your password',
// //           ),
// //           obscureText: true,
// //           validator: (value) {
// //             if (value!.isEmpty) {
// //               return 'Please enter your password';
// //             }
// //             if (value.length < 6) {
// //               return 'Password must be at least 6 characters';
// //             }
// //             return null;
// //           },
// //         ),
// //         isActive: _currentStep == 2,
// //       ),
// //       Step(
// //         title: Text('Phone Number'),
// //         content: TextFormField(
// //           controller: _phoneController,
// //           decoration: InputDecoration(
// //             hintText: 'Enter your phone number',
// //           ),
// //           validator: (value) {
// //             if (value!.isEmpty) {
// //               return 'Please enter your phone number';
// //             }
// //             if (value.length < 10) {
// //               return 'Please enter a valid phone number';
// //             }
// //             return null;
// //           },
// //         ),
// //         isActive: _currentStep == 3,
// //       ),
// //       Step(
// //         title: Text('Address'),
// //         content: TextFormField(
// //           controller: _addressController,
// //           decoration: InputDecoration(
// //             hintText: 'Enter your address',
// //           ),
// //           validator: (value) {
// //             if (value!.isEmpty) {
// //               return 'Please enter your address';
// //             }
// //             return null;
// //           },
// //         ),
// //         isActive: _currentStep == 4,
// //       ),
// //     ];
// //   }

// //   void _submitForm() {
// //     if (_formKey.currentState!.validate()) {
// //       // Form is valid, do something with the data
// //       String name = _nameController.text;
// //       String email = _emailController.text;
// //       String password = _passwordController.text;
// //       String phone = _phoneController.text;
// //       String address = _addressController.text;
// //       print(
// //           'Name: $name\nEmail: $email\nPassword: $password\nPhone: $phone\nAddress: $address}');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: stateOfkey,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //             onPressed: () {
// //               stateOfkey.currentState!.openDrawer();
// //             },
// //             icon: Icon(
// //               Icons.more_horiz_outlined,
// //               color: primaryColor,
// //             )),
// //       ),
// //       drawer: Drawer(
// //         child: drawerPage(),
// //       ),
// //       body: Form(
// //         key: _formKey,
// //         child: Stepper(
// //           currentStep: _currentStep,
// //           onStepContinue: () {
// //             setState(() {
// //               if (_currentStep < _buildSteps().length - 1) {
// //                 _currentStep++;
// //               } else {
// //                 _submitForm();
// //               }
// //             });
// //           },
// //           onStepCancel: () {
// //             setState(() {
// //               if (_currentStep > 0) {
// //                 _currentStep--;
// //               }
// //             });
// //           },
// //           steps: _buildSteps(),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class StepProcessForm extends StatefulWidget {
// //   const StepProcessForm({Key? key}) : super(key: key);

// //   @override
// //   State<StepProcessForm> createState() => _StepProcessFormState();
// // }

// // class _StepProcessFormState extends State<StepProcessForm> {

// //   typedef VoidCallback = void Function();

// //   int _currentStep = 0;
// //   final List<Step> _steps = [

// //     Step(
// //       title: Text('Step 1'),
// //       content: TextFormField(
// //         decoration: InputDecoration(labelText: 'Enter your name'),
// //       ),
// //       isActive: true,
// //     ),
// //     Step(
// //       title: Text('Step 2'),
// //       content: TextFormField(
// //         decoration: InputDecoration(labelText: 'Enter your email'),
// //       ),
// //       isActive: false,
// //     ),
// //     Step(
// //       title: Text('Step 3'),
// //       content: TextFormField(
// //         decoration: InputDecoration(labelText: 'Enter your password'),
// //         obscureText: true,
// //       ),
// //       isActive: false,
// //     ),
// //   ];

// //   void _goToNextStep() {
// //     setState(() {
// //       _currentStep += 1;
// //     });
// //   }

// //   void _goToPreviousStep() {
// //     setState(() {
// //       _currentStep -= 1;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Multi-Step Form with Step Progress Indicator'),
// //       ),
// //       body: Column(
// //         children: [
// //           Container(
// //             padding: EdgeInsets.all(16.0),
// //             child: StepProgressIndicator(
// //               totalSteps: _steps.length,
// //               currentStep: _currentStep + 1,
// //               selectedColor: Colors.blue,
// //               unselectedColor: Colors.grey,
// //               size: 10,
// //               padding: 0,
// //             ),
// //           ),
// //           Expanded(
// //             child: Stepper(
// //               currentStep: _currentStep,
// //               steps: _steps,
// //               onStepContinue: _goToNextStep,
// //               onStepCancel: _goToPreviousStep,
// //               controlsBuilder: (BuildContext context,
// //                   {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
// //                 return Row(
// //                   children: [
// //                     ElevatedButton(
// //                       onPressed: onStepCancel,
// //                       child: Text('Previous'),
// //                     ),
// //                     SizedBox(width: 16.0),
// //                     ElevatedButton(
// //                       onPressed: onStepContinue,
// //                       child: Text(_currentStep == _steps.length - 1
// //                           ? 'Submit'
// //                           : 'Next'),
// //                     ),
// //                   ],
// //                 ),
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class productAddForm extends StatefulWidget {
// //    productAddForm ({Key? key}) : super(key: key);

// //   @override
// //   State<productAddForm> createState() => _productAddFormState();
// // }

// // class _productAddFormState extends State<productAddForm> {
// //   var _currentSteps = 0;

// //   List<Step> _steps = [
// //   Step(
// //     title: Text('Step 1'),
// //     content: Column(
// //       children: <Widget>[
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Name'),
// //         ),
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Email'),
// //         ),
// //       ],
// //     ),
// //   ),
// //   Step(
// //     title: Text('Step 1'),
// //     content: Column(
// //       children: <Widget>[
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Name'),
// //         ),
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Email'),
// //         ),
// //       ],
// //     ),
// //   ),
// //   Step(
// //     title: Text('Step 2'),
// //     content: Column(
// //       children: <Widget>[
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Password'),
// //         ),
// //       ],
// //     ),
// //   ),
// //   Step(
// //     title: Text('Step 3'),
// //     content: Column(
// //       children: <Widget>[
// //         TextField(
// //           decoration: InputDecoration(labelText: 'Confirm Password'),
// //         ),
// //       ],
// //     ),
// //   ),
// // ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 15),
// //       child: Column(
// //         children: <Widget>[

// //           SizedBox(height: 35,),
// //           StepProgressIndicator(
// //             totalSteps: _steps.length,
// //             currentStep: _currentSteps + 1,
// //             selectedColor: primaryColor,
// //             size: 10,
// //             padding: 4,
// //             unselectedColor: greyColor,
// //             roundedEdges: Radius.circular(19),

// //           ),

// //           Expanded(
// //       child: Stepper(
// //         currentStep: _currentSteps,
// //         steps: _steps,
// //         onStepContinue: () {
// //           setState(() {
// //             if (_currentSteps < _steps.length - 1) {
// //               _currentSteps++;
// //             } else {
// //               // Submit form
// //             }
// //           });
// //         },
// //         onStepCancel: () {
// //           setState(() {
// //             if (_currentSteps > 0) {
// //               _currentSteps--;
// //             } else {
// //               _currentSteps = 0;
// //             }
// //           });
// //         },
// //       ),
// //     ),
// //     // StepProgressIndicator(
// //     //   totalSteps: _steps.length,
// //     //   currentStep: _currentSteps + 1,
// //     //   size: 16,
// //     //   padding: 4,
// //     //   selectedColor: Colors.blue,
// //     //   unselectedColor: whiteColor,
// //     // ),

// //         ],
// //       ),
// //     );
// //   }
// // }

// class productAddForm extends StatefulWidget {
//   const productAddForm({Key? key}) : super(key: key);

//   @override
//   State<productAddForm> createState() => _productAddFormState();
// }

// class _productAddFormState extends State<productAddForm> {
//   final _formKey = GlobalKey<FormState>();

//   void _submitForm() {
//     if (1 == 1) {
//       // Submit form
//       const CircularProgressIndicator();
//     }
//   }

//   // var _currentStep =1;

//   // List <Widget> steps =[
//   //   firstform(),
//   //   SecondForm(),
//   //   therdForm(),
//   //   fourthForm(),

//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       // appBar: AppBar(
//       //   title:  StepProgressIndicator(
//       //         totalSteps: 4,
//       //                 currentStep: _currentStep,
//       //                 selectedColor: Theme.of(context).primaryColor,
//       //                 unselectedColor: greyColor,
//       //                 roundedEdges: Radius.circular(20)),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.transparent,
//       //   elevation: 0,
//       // // leading: IconButton(onPressed: () {}, icon: Icon(Icons.fork_left_sharp)),
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),

//             // StepProgressIndicator(
//             //   totalSteps: 4,
//             //           currentStep: _currentStep,
//             //           selectedColor: Theme.of(context).primaryColor,
//             //           unselectedColor: greyColor,
//             //           roundedEdges: Radius.circular(20)),

//             // ReusableText(text: "Step 1: Product details", fontSize: 18, fontcolor: blackColor),

//             SizedBox(
//               height: 25,
//             ),

//             firstform(),
//             SecondForm(),
//             therdForm(),
//             fourthForm(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class productAddForm extends StatefulWidget {
// //   const productAddForm({Key? key}) : super(key: key);

// //   @override
// //   State<productAddForm> createState() => _productAddFormState();
// // }

// // class _productAddFormState extends State<productAddForm> {
// //  final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _pagename2 = TextEditingController();
// //   final _pagrname3 = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();
// //   int _currentStep = 1;
// //   int _totalSteps = 3;

// // void _submitForm() {
// //   if (_formKey.currentState!.validate()) {
// //     // Submit form
// //   }
// // }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     _confirmPasswordController.dispose();
// //     _pagename2.dispose();
// //     _pagrname3.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('My Form'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: <Widget>[
// //             StepProgressIndicator(
// // totalSteps: _totalSteps,
// // currentStep: _currentStep,
// // selectedColor: Theme.of(context).primaryColor,
// // unselectedColor: greyColor,
// // roundedEdges: Radius.circular(20),

// //                     ),
// //                     Expanded(
// //               child: Form(
// //                 // key: _formKey,
// //                 child: Column(
// //                   children: <Widget>[
// //                     TextFormField(
// //                       controller: _pagrname3,
// //                       decoration: InputDecoration(
// //                         labelText: '3rd page',
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please enter your name';
// //                         }
// //                         return null;
// //                       },
// //                     ),

// //                   ],
// //                 ),
// //               ),
// //             ),
// //                     Expanded(
// //               child: Form(
// //                 // key: _formKey,
// //                 child: Column(
// //                   children: <Widget>[
// //                     TextFormField(
// //                       controller: _pagename2,
// //                       decoration: InputDecoration(
// //                         labelText: 'second page',
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please enter your name';
// //                         }
// //                         return null;
// //                       },
// //                     ),

// //                   ],
// //                 ),
// //               ),
// //             ),
// //             Expanded(
// //               child: Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   children: <Widget>[
// //                     TextFormField(
// //                       controller: _nameController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Name',
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please enter your name';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     TextFormField(
// //                       controller: _emailController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Email',
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please enter your email';
// //                         }
// //                         if (!EmailValidator.validate(value)) {
// //                           return 'Please enter a valid email address';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     TextFormField(
// //                       controller: _passwordController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Password',
// //                       ),
// //                       obscureText: true,
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please enter a password';
// //                         }
// //                         if (value.length < 6) {
// //                           return 'Password must be at least 6 characters long';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                     TextFormField(
// //                       controller: _confirmPasswordController,
// //                       decoration: InputDecoration(
// //                         labelText: 'Confirm Password',
// //                       ),
// //                       obscureText: true,
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Please confirm your password';
// //                         }
// //                         if (value != _passwordController.text) {
// //                           return 'Passwords do not match';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// // Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: <Widget>[
// //     _currentStep > 1
// //         ? ElevatedButton(
// //             onPressed: () {
// //               setState(() {
// //                 _currentStep--;
// //               });
// //             },
// //             child: Text('Previous'),
// //           )
// //         : SizedBox(),
// //     TextButton(
// //       onPressed: _submitForm,
// //       child: Text(_currentStep == _totalSteps ? 'Submit' : 'Next'),
// //         ),
// //         ],
// //         ),
// //                     SizedBox(height: 16.0),

// //                     ],
// //                     ),
// //                     ),
// //                     );
// //                     }
// //                     }

// class ManureDropdown extends StatefulWidget {
//   const ManureDropdown({Key? key}) : super(key: key);

//   @override
//   _ManureDropdownState createState() => _ManureDropdownState();
// }

// class _ManureDropdownState extends State<ManureDropdown> {
//   late String _selectedManure;

//   final List<String> _manureOptions = [
//     'Generic',
//     'Ethical',
//     'Ayurvedic',
//     'OTC',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedManure = _manureOptions.first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//       value: _selectedManure,
//       items: _manureOptions.map((manure) {
//         return DropdownMenuItem(
//           value: manure,
//           child: Text(manure),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _selectedManure = value.toString();
//         });
//       },
//     );
//   }
// }

// class DateSelectionMenu extends StatefulWidget {
//   const DateSelectionMenu({Key? key}) : super(key: key);

//   @override
//   _DateSelectionMenuState createState() => _DateSelectionMenuState();
// }

// class _DateSelectionMenuState extends State<DateSelectionMenu> {
//   DateTime _selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         _selectDate(context);
//       },
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.calendar_today),
//             const SizedBox(width: 10),
//             Text(
//               DateFormat('MMMM dd, yyyy').format(_selectedDate),
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
