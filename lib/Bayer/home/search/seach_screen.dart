import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/components/productdetails.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  getData(String value) async {
    if (value != '') {
      String token = await _storage.read(key: 'buyertoken').then((value) {
        return value.toString();
      });
      String url = "https://pharmabag.in:3000/buyer/un/auth/products/";
      if (chosenCategory == "All Categories") {
        http.Response res = await http.get(Uri.parse('$url$value'),
            headers: {'auth-token': token, 'content-type': 'Application/json'});
        setState(() {
          var data = jsonDecode(res.body);
          finalData = data['result_products'];
        });
        debugPrint('The final data is $finalData');
      } else {
        http.Response res = await http.post(Uri.parse('$url$value'), body: {
          'category': chosenCategory
        }, headers: {
          'auth-token': token,
        });

        setState(() {
          var data = jsonDecode(res.body);
          finalData = data['result_products'];
        });
      }
    }
  }

  //  https://pharmabag.in:3000/buyer/un/auth/products
  String chosenCategory = "All Categories";
  List<String> category = [
    'All Categories',
    'Ethical',
    'Generic',
    'OTC',
    'Ayurvedic',
    'Halo'
  ];
  TextEditingController search = TextEditingController();
  List<dynamic> finalData = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Search',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SizedBox(
              width: 350,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      onChanged: (value) async {
                        getData(value);
                      },
                      controller: search,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Color.fromARGB(255, 93, 90, 241),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 93, 90, 241),
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 93, 90, 241),
                            width: 1.0,
                          ),
                        ),
                        // suffixIcon: Icon(
                        //   Icons.camera_enhance,
                        //   color: Color.fromARGB(255, 93, 90, 241),
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 2,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      color: const Color.fromARGB(255, 227, 227, 255),
                      child: DropdownButton(
                        underline: Container(),
                        value: chosenCategory,
                        items: category.map((var cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                            onTap: () {},
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            chosenCategory = value.toString();
                            setState(() {
                              search.text = '';
                              finalData = [];
                            });
                            debugPrint(chosenCategory);
                          });
                        },
                      ),
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return  FilterProductsScreen(
                        //     isSeller: false,
                        //   );
                        // }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.81,
            child: ListView.builder(
              itemCount: finalData.length,
              itemBuilder: (context, index) {
                var currentItem = finalData[index];
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(productId: currentItem['_id']))),
                  leading: currentItem['image_list'][0].toString().isNotEmpty
                      ? Image.network(currentItem['image_list'][0],
                          errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://pharmabag.in/image/logo/logo-edited.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          );
                        })
                      : const Icon(Icons.medication_liquid),
                  title: Text(currentItem['product_name']),
                  subtitle: Text(currentItem['company_name']),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
