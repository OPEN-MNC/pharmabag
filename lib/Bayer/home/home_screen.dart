import 'dart:convert';
import 'package:event_handeler/event_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/WishList/wishlist.dart';
import 'package:pharmabag/Bayer/buyer_repositories/Auth_repo/Auth_repo.dart';
import 'package:pharmabag/Bayer/home/search/seach_screen.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/notifications_repo/notifications_repo.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import '../../Seller/pages_view/product.dart';
import '../Main/product_page.dart';
import '../Notification/notification.dart';
import '../components/cart/cart.dart';
import '../components/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getBuyerProfile();
    getNotifications();
    getWishList();
    fetchCartItems();

    addCustomEventListener('WishList', (data) {
      wishCount = int.parse(data);
      setState(() {
        wishCount = wishCount;
      });
    });

    addCustomEventListener("wishlist_update", (data) {
      wishCount = int.parse(data);
      setState(() {
        wishCount = wishCount;
      });
    });

    addCustomEventListener('CartDelete', (data) {
      cartcount = int.parse(data);
      setState(() {
        cartcount = cartcount;
      });
    });
    addCustomEventListener('CartUpdate', (data) {
      cartcount = cartcount + int.parse(data);
      setState(() {
        cartcount = cartcount;
      });
    });
    super.initState();
  }

  List<dynamic> finalList = [];
  int wishCount = 0;
  int cartcount = 0;
  getWishList() async {
    String url = "https://pharmabag.in:3000/buyer/auth/wishlist";
    String token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    var res = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'auth-token': token});
    setState(() {
      finalList = jsonDecode(res.body);
      for (var element in finalList) {
        if ((element['product_details'] as List<dynamic>).isNotEmpty) {
          wishCount = wishCount + 1;
        }
      }
    });
  }

  Future<void> fetchCartItems() async {
    final url = Uri.parse('https://pharmabag.in:3000/buyer/auth/cart');
    String authToken = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'auth-token': authToken,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['result_cart'];

        setState(() {
          cartcount = data.length;
        });
      } else {
        showAlert(
            'Failed to fetch cart items. Please try again or contact admin.');
      }
    } catch (e) {
      showAlert(
          'An error occurred while fetching cart items. Please try again.$e');
    }
  }

  void showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int nots = 0;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  List<dynamic> note = [];
  getNotifications() async {
    var res =
        await NotificationRepo().getBuyerNotifications().then((value) async {
      String date = await _storage.read(key: 'lastDate').then((value) {
        return value.toString();
      });
      DateTime finalDate = DateTime.parse(date);

      var data = jsonDecode(value);
      note = data;
      for (var element in note) {
        if (DateTime.parse(element['date']).isAfter(finalDate)) {
          nots = nots + 1;
        }
      }
      setState(() {
        note = note;
        nots = nots;
      });
    });
    print(nots);
  }

  String name = '';
  Map<String, dynamic> finalData = {};
  getBuyerProfile() async {
    http.Response res = await BuyerAuth().getBuyerProfile();
    var data = jsonDecode(res.body);
    setState(() {
      finalData = data;
      name = finalData['buyer_details']['name'].toString().split(' ')[0];
    });
  }

  // String getHello(String name) {
  //   String split = name.split(' ')[0];
  //   print(split);
  //   String firstletter = split[0];
  //   captial
  //   return split;
  // }

  @override
  Widget build(BuildContext context) {
    Color blackColor2 = const Color.fromARGB(235, 24, 24, 24);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: note.isEmpty && finalData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Scaffold(
              appBar: AppBar(
                  leadingWidth: 0,
                  title: widget.isLoggedIn
                      ?
                      // ? Text(
                      //     'Hii, Remesh',
                      //     style: TextStyle(color: blackColor,
                      //          decoration: TextDecoration.underline),
                      //   )
                      ReusableText(
                          text: name.isEmpty
                              ? ' '
                              : "Hi ${"$name".split("")[0].toUpperCase()}${"$name".substring(1, name.length)}",
                          fontSize: 22,
                          fontcolor: blackColor2)
                      : Image.asset(
                          'assets/images/logo.png',
                          height: 40,
                        ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                const Color.fromARGB(255, 227, 227, 255),
                            child: IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WishList())),
                              icon: const Icon(
                                Icons.favorite,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Badge(
                            label: Text(wishCount.toString()),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                const Color.fromARGB(255, 227, 227, 255),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BuyerNotifications(
                                    note: note,
                                  );
                                }));
                              },
                              icon: const Icon(
                                Icons.notifications,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Badge(
                            label: Text(nots.toString()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                const Color.fromARGB(255, 227, 227, 255),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen()));
                              },
                              icon: const Icon(
                                Icons.shopping_bag,
                                size: 20,
                                color: primaryColor,
                              ),
                              // icon: Badge(
                              //   badgeContent: const Text(
                              //     '1',
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   child: const Icon(
                              //     Icons.notifications,
                              //     size: 30,
                              //     color: Color.fromARGB(255, 93, 90, 241),
                              //   ),
                              // ),
                            ),
                          ),
                          Badge(
                            label: Text(cartcount.toString()),
                          ),
                        ],
                      ),
                    ),
                  ]),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    readOnly: true,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const SearchScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return SlideTransition(
                                              position: Tween<Offset>(
                                                      begin: const Offset(1, 0),
                                                      end: Offset.zero)
                                                  .animate(animation),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search_rounded,
                                        color: Color.fromARGB(255, 93, 90, 241),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 93, 90, 241),
                                        fontSize: 18,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 93, 90, 241),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Offers",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'See all',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 93, 90, 241),
                                      fontSize: 15,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Color.fromARGB(255, 93, 90, 241),
                                  )
                                ],
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Image.network(
                            'https://image.shutterstock.com/image-vector/vector-medical-banner-pharmacy-template-260nw-2043622106.jpg',
                            errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://pharmabag.in/image/logo/logo-edited.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.contain,
                          );
                        }),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shop by Categories",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ]),
                      ),
                      const CategoryCard(),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Hot Selling in your area",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const AllProducts();
                                      }));
                                    },
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 93, 90, 241),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                    color: Color.fromARGB(255, 93, 90, 241),
                                  )
                                ],
                              ),
                            ]),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProductCard(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AllProducts();
                            }));
                          },
                          child: Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: ReusableText(
                                      text: "See More",
                                      fontSize: 15,
                                      fontcolor: whiteColor)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> products = [];
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return const InkWell();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> products = [];
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return const InkWell();
        });
  }
}
