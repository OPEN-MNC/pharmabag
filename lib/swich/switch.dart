import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pharmabag/Bayer/Auth/log_in.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/Seller/authentication/login.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class swich extends StatefulWidget {
  const swich({Key? key}) : super(key: key);

  @override
  State<swich> createState() => _swichState();
}

class _swichState extends State<swich> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/635MB8OWDVK8MH4F.gif'), // Replace with your image path
              fit: BoxFit.contain,
            ),
          ),
          child: Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: primaryColor,
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text("I want To sell Medicine"),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ReusableText(
                                text: "Go As Seller",
                                fontSize: 20,
                                fontcolor: whiteColor),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      const Text("I want To Buy Medicine"),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => buyerHomePage()),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ReusableText(
                                text: "Go As Buyer",
                                fontSize: 20,
                                fontcolor: whiteColor),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = "";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  getToken() async {
    token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    return token.toString();
  }

  @override
  void initState() {
    getToken();
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    token == "undefined" || token == "" || token == "null"
                        ? const LoginScreen()
                        : const BottomNavBarpage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Center(
          child: Image.asset("assets/images/pharmabag_seller.png"),
        )));
  }
}

//==========================
class buyerHomePage extends StatefulWidget {
  @override
  _buyerHomePageState createState() => _buyerHomePageState();
}

class _buyerHomePageState extends State<buyerHomePage> {
  String token = "";
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  getToken() async {
    token = await _storage.read(key: 'buyertoken').then((value) {
      return value.toString();
    });
    return token.toString();
  }

  @override
  void initState() {
    getToken();
    debugPrint("so the tokon is $token");
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    token == "undefined" || token == "" || token == "null"
                        ? const BuyerLogin() //const BuyerLoginScreen()
                        : const BuyerHome(
                            isLoggedIn: true,
                          ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Center(
          child: Image.asset("assets/images/pharmabag_buyer.png"),
        )));
  }
}
