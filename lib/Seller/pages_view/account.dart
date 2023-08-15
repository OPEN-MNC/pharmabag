import 'package:flutter/material.dart';
import 'package:pharmabag/Seller/pages_view/tickets.dart';

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

class addStock extends StatelessWidget {
  const addStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryDate.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var currentItem = categoryDate[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Subcategory(category: currentItem['title']!);
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
                      child: Image.network("${currentItem['imageUrl']}",
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
                    "${currentItem['title']}",
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
