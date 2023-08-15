import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

// class ProductImagesPage extends StatefulWidget {
//   @override
//   _ProductImagesPageState createState() => _ProductImagesPageState();
// }

// class _ProductImagesPageState extends State<ProductImagesPage> {

//   List<String> productImages = [
//     'https://thumbs.dreamstime.com/b/medicine-medicine-pharmacy-treatment-white-help-antibiotic-composition-white-white-tablets-same-size-composition-169085962.jpg',
//     'https://www.bansalglobalhospital.com/wp-content/uploads/2018/11/medicien.jpg',
//     'https://static.independent.co.uk/s3fs-public/thumbnails/image/2017/01/12/16/aids-drugs.jpg',
//     'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-11/221123-paxlovid-pill-mjf-1248-ff8b43.jpg',
//   ];

//   int _currentImageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: primaryColor,),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share,color: primaryColor,),
//             onPressed: () {
//               // Share functionality
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.shopping_cart,color: primaryColor,),
//             onPressed: () {
//               // Go to shopping cart functionality
//             },
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             child: Text(
//               '3', // Replace with the actual count of items in the shopping cart
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 initialPage: 0,
//                 enableInfiniteScroll: true,
//                 enlargeCenterPage: true,
//                 onPageChanged: (index, _) {
//                   setState(() {
//                     _currentImageIndex = index;
//                   });
//                 },
//               ),
//               items: productImages.map((imagePath) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
// child: Image.network(
//   imagePath,
//   fit: BoxFit.contain,
// ),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Product Title',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Product Description',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Price: \$99.99',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add to cart functionality
//                     },
//                     child: Text('Add to Cart'),
//                   ),
//                   SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Buy now functionality
//                     },
//                     child: Text('Buy Now'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Product Reviews and Ratings',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Implement product reviews and ratings component here
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Product Specifications',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Implement product specifications component here
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Related Products',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Implement related products component here
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Additional Information',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Implement additional information component here
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Social Sharing and Bookmarking',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Implement social sharing and bookmarking component here
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProductImagesPage extends StatefulWidget {
  const ProductImagesPage({Key? key}) : super(key: key);

  @override
  State<ProductImagesPage> createState() => _ProductImagesPageState();
}

class _ProductImagesPageState extends State<ProductImagesPage> {
  int _number = 0;
  void incrementNumber() {
    setState(() {
      _number++;
    });
  }

  void decrementNumber() {
    setState(() {
      if (_number > 0) {
        _number--;
      }
    });
  }

  final List<String> imageUrls = [
    'https://thumbs.dreamstime.com/b/medicine-medicine-pharmacy-treatment-white-help-antibiotic-composition-white-white-tablets-same-size-composition-169085962.jpg',
    'https://images.pexels.com/photos/159211/headache-pain-pills-medication-159211.jpeg?cs=srgb&dl=pexels-pixabay-159211.jpg&fm=jpg',
    'https://media.istockphoto.com/id/1153740646/photo/background-of-a-large-group-of-assorted-capsules-pills-and-blisters.jpg?s=612x612&w=0&k=20&c=Lbd_NdmQSRfrLP95MmPRTEnyJBShBk8ceVZBorlFZ2s=',
    'https://www.outsourcing-pharma.com/var/wrbm_gb_food_pharma/storage/images/_aliases/wrbm_large/publications/pharmaceutical-science/in-pharmatechnologist.com/article/2016/08/02/spanish-regulators-jinan-jinda-pharmaceutical-chemi-should-not-supply-nitrofurantoin-to-eu/1720367-2-eng-GB/Spanish-regulators-Jinan-Jinda-Pharmaceutical-Chemi-should-not-supply-nitrofurantoin-to-EU.jpg',
  ];

  final TextEditingController _textEditingController = TextEditingController();

  int numberOfStars = 4; // Provide the number of stars

  Color getIconColor(int index) {
    // Function to get the color based on the index
    if (index < numberOfStars) {
      return primaryColor; // Change the color as desired
    } else {
      return Colors.grey; // Change the color as desired
    }
  }

  final int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: primaryColor,
            ),
            onPressed: () {
              // Share functionality
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: primaryColor,
            ),
            onPressed: () {
              // Go to shopping cart functionality
            },
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '3', // Replace with the actual count of items in the shopping cart
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                // Image.network(
                //   'https://thumbs.dreamstime.com/b/medicine-medicine-pharmacy-treatment-white-help-antibiotic-composition-white-white-tablets-same-size-composition-169085962.jpg',
                //   fit: BoxFit.contain,
                // ),
                SizedBox(
                  height: 200, // Specify a fixed height for the container
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(imageUrls[index],
                          errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://pharmabag.in/image/logo/logo-edited.png",
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        );
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                            child: ReusableText(
                                text: "New",
                                fontSize: 15,
                                fontcolor: whiteColor)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 45),
                  child: Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Center(
                            child: ReusableText(
                                text: "-20%",
                                fontSize: 15,
                                fontcolor: whiteColor)),
                      )),
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReusableText(
                        text: "Telmikind -AM",
                        fontSize: 20,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        ReusableText(
                            text: "COMPANY: ENHERTU",
                            fontSize: 13,
                            fontcolor: blackColor),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                            child: ReusableText(
                                text: "HSN: NDC 65624589-601-024",
                                fontSize: 13,
                                fontcolor: blackColor)),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: "Expiry: 2023-08-26",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Stock: 0",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Min qty: 123",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Max qty: 456",
                                fontSize: 13,
                                fontcolor: blackColor),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: "Medicine Type: Vial",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Country: India",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Buy:",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Get:",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "GST: 18.00%",
                                fontSize: 13,
                                fontcolor: blackColor),
                            SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "Expected Delhivery: 10 Days",
                                fontSize: 13,
                                fontcolor: blackColor),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ReusableText(
                        text: "Chemical Combination: Enhertu",
                        fontSize: 14,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 5,
                    ),
                    const ReusableText(
                        text: "Discount type: ptr discount",
                        fontSize: 14,
                        fontcolor: blackColor),
                    const SizedBox(
                      height: 25,
                    ),

                    const Row(
                      children: [
                        ReusableText(
                            text: "Seller id:",
                            fontSize: 20,
                            fontcolor: blackColor),
                        ReusableText(
                            text: "  Q284HNDM35663",
                            fontSize: 17,
                            fontcolor: primaryColor),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ReusableText(
                                text: "MRP: ",
                                fontSize: 20,
                                fontcolor: blackColor),
                            ReusableText(
                                text: "₹15",
                                fontSize: 20,
                                fontcolor: primaryColor),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ReusableText(
                                    text: "On PTR: ",
                                    fontSize: 20,
                                    fontcolor: blackColor),
                                ReusableText(
                                    text: "₹8",
                                    fontSize: 20,
                                    fontcolor: primaryColor),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹15",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    decoration: TextDecoration.lineThrough,
                                    color: greyColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ReusableText(
                                    text: "(Rate without GST)",
                                    fontSize: 13,
                                    fontcolor: red)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    // next increment

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ReusableContainer(
                              color: const Color.fromARGB(108, 197, 197, 197),
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: decrementNumber,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            ReusableContainer(
                                height: 30,
                                width: 60,
                                color: primaryColor,
                                child: Center(
                                    child: ReusableText(
                                        text: "$_number",
                                        fontSize: 15,
                                        fontcolor: whiteColor))),
                            const SizedBox(
                              width: 3,
                            ),
                            ReusableContainer(
                              color: const Color.fromARGB(108, 197, 197, 197),
                              height: 40,
                              width: 40,
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: incrementNumber,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: red,
                                  ))),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        //function
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: whiteColor,
                                ),
                                ReusableText(
                                    text: " ADD TO BAG",
                                    fontSize: 17,
                                    fontcolor: whiteColor),
                              ]),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    InkWell(
                      onTap: () {
                        //function
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: whiteColor,
                                ),
                                ReusableText(
                                    text: " CUSTOM ORDER",
                                    fontSize: 17,
                                    fontcolor: whiteColor),
                              ]),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Center(
                        child: ReusableText(
                            text: "Related This Items",
                            fontSize: 20,
                            fontcolor: blackColor)),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 300,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Stack(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ), // Adjust the border radius as desired
                                        child: Image.network(
                                          'https://thumbs.dreamstime.com/b/medicine-medicine-pharmacy-treatment-white-help-antibiotic-composition-white-white-tablets-same-size-composition-169085962.jpg',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Container(
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color: greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Center(
                                                  child: ReusableText(
                                                      text: "New",
                                                      fontSize: 13,
                                                      fontcolor: whiteColor)),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 45),
                                        child: Container(
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color: red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Center(
                                                  child: ReusableText(
                                                      text: "-20% off",
                                                      fontSize: 12,
                                                      fontcolor: whiteColor)),
                                            )),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const ReusableText(
                                              text: "Januvia 50mg Tablet",
                                              fontSize: 16,
                                              fontcolor: blackColor),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const ReusableText(
                                              text: "Generic > Capsules",
                                              fontSize: 16,
                                              fontcolor: blackColor),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  ReusableText(
                                                      text: "MRP",
                                                      fontSize: 16,
                                                      fontcolor: primaryColor),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  ReusableText(
                                                      text: "₹1452",
                                                      fontSize: 16,
                                                      fontcolor: primaryColor),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ReusableText(
                                                      text: "PTR",
                                                      fontSize: 16,
                                                      fontcolor: primaryColor),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  ReusableText(
                                                      text: "₹595",
                                                      fontSize: 16,
                                                      fontcolor: primaryColor),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colors.transparent),
                                              elevation: MaterialStateProperty
                                                  .all<double>(0),
                                            ),
                                            onPressed: () {
                                              debugPrint("pressed");
                                            },
                                            child: const ReusableContainer(
                                              height: 45,
                                              width: 180,
                                              color:
                                                  primaryColor, // Replace with your desired color
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.shopping_bag,
                                                      color: Colors
                                                          .white, // Replace with your desired color
                                                    ),
                                                    Text(
                                                      "View Details",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .white, // Replace with your desired color
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    // list viue section finish

                    const SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        onPressed: () {
                          debugPrint("pressed");
                        },
                        child: Container(
                          height: 45,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(19),
                          ), // Replace with your desired color
                          child: const Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color:
                                      primaryColor, // Replace with your desired color
                                ),
                                Text(
                                  " VIEW ALL RELATED",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        primaryColor, // Replace with your desired color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                        height: 50,
                        color: whiteColor,
                        child: const Center(
                            child: ReusableText(
                                text: "REVIEWS",
                                fontSize: 20,
                                fontcolor: primaryColor))),
                    Container(
                        height: 70,
                        color: whiteColor,
                        child: const Center(
                            child: ReusableText(
                                text: "Be the first to review this product.",
                                fontSize: 20,
                                fontcolor: blackColor))),
                    Container(
                        height: 100,
                        color: whiteColor,
                        child: Center(
                            child: Column(
                          children: [
                            const ReusableText(
                                text: "Add Your Review",
                                fontSize: 20,
                                fontcolor: blackColor),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(
                                    Icons.star,
                                    color: getIconColor(index),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ReusableText(
                                text: "$numberOfStars",
                                fontSize: 20,
                                fontcolor: blackColor),
                          ],
                        ))),

                    //write review section

                    TextField(
                      controller: _textEditingController,
                      maxLength: 200, // Set the maximum number of words
                      maxLines: null, // Allow multiple lines of text
                      decoration: const InputDecoration(
                        hintText: 'Describe',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        onPressed: () {
                          debugPrint("pressed");
                        },
                        child: const ReusableContainer(
                          height: 45,
                          width: 250,
                          color:
                              primaryColor, // Replace with your desired color
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: Colors
                                      .white, // Replace with your desired color
                                ),
                                Text(
                                  "Drop Your Review",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors
                                        .white, // Replace with your desired color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
