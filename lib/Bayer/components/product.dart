import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmabag/Bayer/components/productdetails.dart';
import '../../components_&_color/color.dart';
import '../request_&_responds/get_product_details.dart';

List<Map<String, String>> productDate = [
  {
    "imageUrl":
        "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
    "title": "Tonact 5g tablets",
    "subtitle": "Sold by SLS farm",
    "MRP": "Rs.67.19",
    "PTR": "Rs.27.18"
  },
  {
    "imageUrl":
        "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
    "title": "Tonact 5g tablets",
    "subtitle": "Sold by SLS farm",
    "MRP": "Rs.67.19",
    "PTR": "Rs.27.18"
  },
  {
    "imageUrl":
        "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
    "title": "Tonact 5g tablets",
    "subtitle": "Sold by SLS farm",
    "MRP": "Rs.67.19",
    "PTR": "Rs.27.18"
  },
  {
    "imageUrl":
        "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
    "title": "Tonact 5g tablets",
    "subtitle": "Sold by SLS farm",
    "MRP": "Rs.67.19",
    "PTR": "Rs.27.18"
  },
  {
    "imageUrl":
        "https://newassets.apollo247.com/pub/media/catalog/product/t/o/ton0012.jpg",
    "title": "Tonact 5g tablets",
    "subtitle": "Sold by SLS farm",
    "MRP": "Rs.67.19",
    "PTR": "Rs.27.18"
  },
];

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Future<List<dynamic>> product;

  @override
  void initState() {
    super.initState();
    product = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FutureBuilder<List<dynamic>>(
          future: product,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ;
              List<dynamic>? productsData = snapshot.data;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: productsData!.length,
                  itemBuilder: (context, index) {
                    var currentData = productsData[index];
                    // print(
                    //     '${productsData!.length} $index dataFROM---->>${currentData}');
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      productId: currentData['_id'].toString(),
                                    )));
                      },
                      child: Container(
                        width: 320,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyColor, width: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                currentData["image_list"][0] != null
                                    ? Image.network(
                                        currentData["image_list"][0],
                                        height: 60,
                                        width: 60, errorBuilder:
                                            (context, error, stackTrace) {
                                        return Image.network(
                                          "https://pharmabag.in/image/logo/logo-edited.png",
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.contain,
                                        );
                                      })
                                    : Container(
                                        height: 60,
                                        color: greyColor,
                                        padding: const EdgeInsets.all(10),
                                        child: const Center(
                                            child: Text('no image')),
                                      ),
                                SizedBox(
                                  height: 50,
                                  width: 180,
                                  child: ListTile(
                                      title: Text(
                                        currentData["product_name"],
                                        // "${currentItem['title']}",
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 93, 90, 241),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19,
                                        ),
                                      ),
                                      subtitle: SizedBox(
                                        width: 50,
                                        child: Text(
                                          currentData['categories']
                                              ['category_name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "MRP",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 202, 255),
                                      ),
                                    ),
                                    Text(
                                      currentData['product_price'].toString(),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "PTR",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 202, 202, 255),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        currentData['discount_details']
                                                ['final_ptr']
                                            .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(0),
                                    color:
                                        const Color.fromARGB(255, 93, 90, 241),
                                    child: const Text(
                                      'View Details',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                    productId:
                                                        currentData['_id']
                                                            .toString(),
                                                  )));
                                      // addtoCart(
                                      //     currentData['_id'],
                                      //     '1',
                                      //     currentData['product_price']
                                      //         .toString());
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasData) {
              throw Exception('getting error');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}










//--------------------------------------------------------------------------------------------















