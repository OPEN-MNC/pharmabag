// import 'package:flutter/material.dart';
// var AddProductMultiStapForm =2;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

class productAddForm extends StatefulWidget {
  const productAddForm({Key? key}) : super(key: key);

  @override
  State<productAddForm> createState() => _productAddFormState();
}

class _productAddFormState extends State<productAddForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (1 == 1) {
      // Submit form
      const CircularProgressIndicator();
    }
  }

  // var _currentStep =1;

  // List <Widget> steps =[
  //   firstform(),
  //   SecondForm(),
  //   therdForm(),
  //   fourthForm(),

  // ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: StepProgressIndicator(
      //       totalSteps: 4,
      //       currentStep: _currentStep,
      //       selectedColor: Theme.of(context).primaryColor,
      //       unselectedColor: greyColor,
      //       roundedEdges: const Radius.circular(20)),
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () {}, icon: const Icon(Icons.fork_left_sharp)),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            // StepProgressIndicator(
            //   totalSteps: 4,
            //           currentStep: _currentStep,
            //           selectedColor: Theme.of(context).primaryColor,
            //           unselectedColor: greyColor,
            //           roundedEdges: Radius.circular(20)),

            // ReusableText(text: "Step 1: Product details", fontSize: 18, fontcolor: blackColor),

            SizedBox(
              height: 25,
            ),

            AddProduct(),
            // SecondForm(),
            // therdForm(),
            // fourthForm(),
          ],
        ),
      ),
    );
  }
}

// class productAddForm extends StatefulWidget {
//   const productAddForm({Key? key}) : super(key: key);

//   @override
//   State<productAddForm> createState() => _productAddFormState();
// }

// class _productAddFormState extends State<productAddForm> {
//  final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _pagename2 = TextEditingController();
//   final _pagrname3 = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   int _currentStep = 1;
//   int _totalSteps = 3;

// void _submitForm() {
//   if (_formKey.currentState!.validate()) {
//     // Submit form
//   }
// }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _pagename2.dispose();
//     _pagrname3.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Form'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             StepProgressIndicator(
// totalSteps: _totalSteps,
// currentStep: _currentStep,
// selectedColor: Theme.of(context).primaryColor,
// unselectedColor: greyColor,
// roundedEdges: Radius.circular(20),

//                     ),
//                     Expanded(
//               child: Form(
//                 // key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       controller: _pagrname3,
//                       decoration: InputDecoration(
//                         labelText: '3rd page',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),

//                   ],
//                 ),
//               ),
//             ),
//                     Expanded(
//               child: Form(
//                 // key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       controller: _pagename2,
//                       decoration: InputDecoration(
//                         labelText: 'second page',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),

//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!EmailValidator.validate(value)) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter a password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please confirm your password';
//                         }
//                         if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: <Widget>[
//     _currentStep > 1
//         ? ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _currentStep--;
//               });
//             },
//             child: Text('Previous'),
//           )
//         : SizedBox(),
//     TextButton(
//       onPressed: _submitForm,
//       child: Text(_currentStep == _totalSteps ? 'Submit' : 'Next'),
//         ),
//         ],
//         ),
//                     SizedBox(height: 16.0),

//                     ],
//                     ),
//                     ),
//                     );
//                     }
//                     }

class ManureDropdown extends StatefulWidget {
  const ManureDropdown({Key? key}) : super(key: key);

  @override
  _ManureDropdownState createState() => _ManureDropdownState();
}

class _ManureDropdownState extends State<ManureDropdown> {
  late String _selectedManure;

  final List<String> _manureOptions = [
    'Generic',
    'Ethical',
    'Ayurvedic',
    'OTC',
  ];

  @override
  void initState() {
    super.initState();
    _selectedManure = _manureOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedManure,
      items: _manureOptions.map((manure) {
        return DropdownMenuItem(
          value: manure,
          child: Text(manure),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedManure = value.toString();
        });
      },
    );
  }
}

class DateSelectionMenu extends StatefulWidget {
  const DateSelectionMenu({Key? key}) : super(key: key);

  @override
  _DateSelectionMenuState createState() => _DateSelectionMenuState();
}

class _DateSelectionMenuState extends State<DateSelectionMenu> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 10),
            Text(
              DateFormat('MMMM dd, yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
