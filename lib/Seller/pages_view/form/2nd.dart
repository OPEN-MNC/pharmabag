import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

//  const List<String> list = <String>['Generic','Ethical', 'OTC', 'Ayurvedic'];
const List<String> list = <String>[
  'No Discount',
  'Discount on PTR only',
  'Same Product Bonus',
  'Same Product Bonus Plus Discount',
  'Different Product Bonus',
  'Diffarent Product Bonus Plus Discount'
];

class SecondForm extends StatefulWidget {
  const SecondForm({Key? key}) : super(key: key);

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  String? _selectedItem2;
  final TextEditingController _dropdownController2 = TextEditingController();
  final List<String> dropdownItems2 = ['6%', '12%', '18%'];

  @override
  void initState() {
    super.initState();
    _dropdownController2.addListener(() {
      _selectedItem2 = _dropdownController2.text;
    });
  }

  String _dropdownvalue = list.first;

  void dropdownCallback(String? selectedvalue) {
    if (selectedvalue is String) {
      setState(() {
        _dropdownvalue = selectedvalue;
      });
    }
  }

  double _currentvalue = 0;

  @override
  Widget build(BuildContext context) {
    // RangeLabels labels = RangeLabels(values.start.toString(), values.end.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),

            const ReusableText(
                text: "Total Avaliable Quantity",
                fontSize: 15,
                fontcolor: primaryColor),
            const SizedBox(
              height: 10,
            ),

            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter Quantity',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            const ReusableText(
                text: "Select Quantity", fontSize: 15, fontcolor: primaryColor),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                const ReusableText(
                    text: "Min", fontSize: 17, fontcolor: blackColor),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: '0',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 100),
                const ReusableText(
                    text: "Max", fontSize: 17, fontcolor: blackColor),
                const SizedBox(
                  width: 15,
                ), // Add some space between the two text fields
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: _currentvalue.toString(),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        )),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // Slider(
            //   value: _currentvalue,
            //   min: 0,
            //   max: 1000,
            //   divisions: 50,
            //   label: _currentvalue.toString(),
            //   activeColor: primaryColor,
            //   onChanged: (value){
            //     setState(() {
            //       _currentvalue == value;
            //     });
            //   }),

            Slider(
              value: _currentvalue,
              max: 100,
              min: 0,
              activeColor: primaryColor,
              divisions: 1000,
              label: _currentvalue.toString(),
              onChanged: (valuesl) {
                setState(() {
                  _currentvalue = valuesl;
                });
              },
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(text: "35", fontSize: 15, fontcolor: blackColor),
                ReusableText(text: "1000", fontSize: 15, fontcolor: blackColor),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            // RangeSlider(
            //   values: values,
            //   divisions: 5000,
            //   labels: labels,
            //   onChanged: (pvalues) {
            //     setState(() {
            //       values = pvalues;
            //     });
            //   },
            // ),

            const ReusableText(
                text: "Expected Delivary Time (in Days)",
                fontSize: 15,
                fontcolor: primaryColor),
            const SizedBox(
              height: 10,
            ),

            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter elivary Time',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            const ReusableText(
                text: "Discounts", fontSize: 15, fontcolor: primaryColor),
            const SizedBox(
              height: 10,
            ),

            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton<String>(
                value: _dropdownvalue,
                icon: const Icon(Icons.arrow_drop_down),
                hint: const ReusableText(
                    text: "Select discounts",
                    fontSize: 11,
                    fontcolor: greyColor),
                dropdownColor: whiteColor,
                isExpanded: true,
                // elevation: 16,
                style: const TextStyle(color: blackColor),
                underline: const SizedBox(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _dropdownvalue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ReusableText(
            //     text: "GST ", fontSize: 15, fontcolor: primaryColor),
            // SizedBox(
            //   height: 10,
            // ),

            // DropdownButtonFormField<String>(
            //         value: _selectedItem2,
            //         decoration: InputDecoration(

            //           hintText: 'gst Eg:2%',
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //         ),
            //         items: dropdownItems2.map((String item) {
            //           return DropdownMenuItem<String>(
            //             value: item,
            //             child: Text(item),
            //           );
            //         }).toList(),
            //         onChanged: (value) {
            //           setState(() {
            //             _selectedItem2 = value;
            //           });
            //         },
            //         validator: (value) {
            //           if (value == null || value.isEmpty) {
            //             return 'Please select an option';
            //           }
            //           return null;
            //         },
            //       ),
          ],
        ),
      ),
    );
  }
}
