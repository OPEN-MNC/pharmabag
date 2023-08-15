import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:pharmabag/Bayer/home/category/category_wise.dart';
import 'package:http/http.dart' as http;
import 'package:pharmabag/Seller/pages_view/drawer.dart';
import 'package:pharmabag/components_&_color/color.dart';

class productPage extends StatefulWidget {
  const productPage({Key? key}) : super(key: key);

  @override
  State<productPage> createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  TextEditingController textController = TextEditingController();

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "white sneaker with adidas logo",
      "price": "₹255",
      "images":
          "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80",
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'false'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'false'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'false'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'false'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
    {
      "images":
          "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
      "title": "Tonact 5g tablets",
      "subtitle": "Sold by SLS farm",
      "MRP": "\$49.99",
      "PTR": "\$27.18",
      "isAccepted": 'true'
    },
  ];

  Future<void> showCatagorySelectionDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isSelect1 = false;
          bool isSelect2 = false;
          bool isSelect3 = false;
          bool isSelect4 = false;
          bool isSelect5 = false;
          bool isSelect6 = false;
          bool isSelect7 = false;
          bool isSelect8 = false;
          bool isSelect9 = false;

          // final TextEditingController _aleartTetController =
          //     TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // content: Form(
              //     child: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     // TextFormField(
              //     //   controller: _aleartTetController,
              //     //   validator: (value) {
              //     //     return value!.isNotEmpty ? null : "Invalid field";
              //     //   },
              //     //   decoration: InputDecoration(hintText: "Enter Your name"),
              //     // ),
              //   ],
              // )),

              actions: <Widget>[
                const Center(
                    child: Text(
                  "select medicine category",
                  style: TextStyle(
                      color: Color.fromARGB(255, 12, 110, 167), fontSize: 20),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("All category"),
                    Checkbox(
                        value: isSelect1,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect1 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Ethical"),
                    Checkbox(
                        value: isSelect2,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect2 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Generic"),
                    Checkbox(
                        value: isSelect3,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect3 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("OTC"),
                    Checkbox(
                        value: isSelect4,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect4 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Ayurvedic"),
                    Checkbox(
                        value: isSelect5,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect5 = value!;
                            },
                          );
                        })
                  ],
                ),
                const Center(
                    child: Text(
                  "Other",
                  style: TextStyle(
                      color: Color.fromARGB(255, 12, 110, 167), fontSize: 20),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("all"),
                    Checkbox(
                        value: isSelect9,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect9 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Expired or Near Expiry"),
                    Checkbox(
                        value: isSelect6,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect6 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Slow moving"),
                    Checkbox(
                        value: isSelect7,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect7 = value!;
                            },
                          );
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Out Of Stock"),
                    Checkbox(
                        value: isSelect8,
                        onChanged: (value) {
                          setState(
                            () {
                              isSelect8 = value!;
                            },
                          );
                        })
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Apply", style: TextStyle(fontSize: 20))),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          'All Products',
          // style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // iconTheme: const IconThemeData(color: Colors.black),
        // backgroundColor: Colors.transparent,
        backgroundColor: primaryColor,
        // elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
      ),
      drawer: const Drawer(
        child: drawerPage(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  AnimSearchBar(
                    width: 320,
                    textController: textController,
                    closeSearchOnSuffixTap: true,
                    // autoFocus: true,
                    onSuffixTap: () {},
                    onSubmitted: (String value) {
                      debugPrint("dbuck print $value");
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await showCatagorySelectionDialog(context);
                    },
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 320,
                ),
                itemCount: gridMap.length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                      color: Colors.amberAccent.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          child: Image.network(
                              "${gridMap.elementAt(index)['images']}",
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              "https://pharmabag.in/image/logo/logo-edited.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${gridMap.elementAt(index)['title']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "${gridMap.elementAt(index)['price']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(
                                      TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.heart,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.cart,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> categoryDate = [
  {
    "imageUrl":
        "https://icons.iconarchive.com/icons/medicalwp/medical/256/Pills-blue-icon.png",
    "title": "Ethical",
  },
  {
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmZvvphQBr_u11Hu5aNrRKlvbZBYC_fWTazQ&usqp=CAU",
    "title": "Generic",
  },
  {
    "imageUrl": "https://cdn-icons-png.flaticon.com/512/761/761130.png",
    "title": "OTC",
  },
  {
    "imageUrl": "https://cdn-icons-png.flaticon.com/512/761/761130.png",
    "title": "Ayurvedic",
  },
  {
    "imageUrl": "https://cdn-icons-png.flaticon.com/512/761/761130.png",
    "title": "Surgical",
  },
  {
    "imageUrl": "https://cdn-icons-png.flaticon.com/512/761/761130.png",
    "title": "Critical Care",
  },
  {
    "imageUrl": "https://cdn-icons-png.flaticon.com/512/761/761130.png",
    "title": "Others",
  },
];

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<dynamic> catData = [];
  static const String urlCat =
      "https://pharmabag.in:3000/user/get/all/category";
  getCats() async {
    http.Response res = await http.get(Uri.parse(urlCat));
    setState(() {
      catData = jsonDecode(res.body);
    });
  }

  @override
  void initState() {
    getCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catData.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var currentItem = catData[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryWise(category: currentItem['category_name']!);
                }));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 227, 227, 255),
                    ),
                    child: Center(
                      child: Image.network("${categoryDate[index]['imageUrl']}",
                          height: 30, width: 30,
                          errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://pharmabag.in/image/logo/logo-edited.png",
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        );
                      }),
                    ),
                  ),
                  Text(
                    "${currentItem['category_name']}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Subcategory extends StatefulWidget {
  const Subcategory({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  List<Map<String, dynamic>> data = [];

  get categoryData => null;

  @override
  void initState() {
    filter(widget.category);
    super.initState();
  }

  void filter(String categoryName) {
    List<Map<String, dynamic>> result = [];
    result = categoryData
        .where((data) => data['categoryName'].contains(categoryName))
        .toList();
    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: blackColor,
              )),
          backgroundColor: Colors.white,
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          )),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index]['subcategoryName'];
            return SizedBox(
              height: 750,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return const AllProducts();
                        // }));
                      },
                      child: Container(
                        height: 60,
                        width: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 227, 227, 255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            item[index],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
