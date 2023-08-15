import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmabag/Seller/drawer.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/containers.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:quickalert/quickalert.dart';

import '../Bottom_nav_bar.dart';
import '../Notifications/notifications.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class settlePage extends StatefulWidget {
  const settlePage({Key? key}) : super(key: key);

  @override
  State<settlePage> createState() => settlementPage();
}

class settlementPage extends State<settlePage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  download({required String url, required String orderid}) async {
    // requests permission for downloading the file
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    // gets the directory where we will download the file.
    var dir = await getExternalStorageDirectory();

    // You should put the name you want for the file here.
    // Take in account the extension.
    String fileName = "Recipt_of_Order_$orderid.jpeg";

    // downloads the file
    Dio dio = Dio();
    debugPrint("url is $url");
    debugPrint("${dir?.path}/$fileName");
    await dio.download(url, "${dir!.path}/$fileName");
    debugPrint("done downloading");
    OpenFile.open("${dir.path}/$fileName");
    return "${dir.path}/$fileName";
    // opens the file
  }

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  var settelments = [];
  getSettelments() async {
    var res;
    String token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    const url = 'https://pharmabag.in:3000/seller/payments/history';
    res = await http
        .get(Uri.parse(url), headers: {'auth-token': token}).then((value) {
      res = value.body;
      setState(() {
        settelments = jsonDecode(res);
      });
      return res;
    });
    return res;
  }

  @override
  void initState() {
    getSettelments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("settelments are :$settelments");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBarpage()));
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(
          child: Drawers(),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            actions: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications())),
                child: const CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 30,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
            iconTheme: const IconThemeData(color: primaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // leading: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.sort,
            //       color: primaryColor,
            //       size: 30,
            //     )),
            title: const Text(
              "Settlements",
              style: TextStyle(color: primaryColor),
            ),
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    itemCount: settelments.length,
                    itemBuilder: (context, index) {
                      var currentItem = settelments[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2, top: 20),
                        child: ReusableContainer(
                          height: 100,
                          width: 315,
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(29, 47, 2, 207),
                                      radius: 20,
                                      child: Icon(
                                        Icons.monetization_on,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                        text: currentItem["_id"].toString(),
                                        fontSize: 11,
                                        fontcolor: primaryColor),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    ReusableText(
                                        text: DateTime.parse(currentItem[
                                                "last_settelment_date"])
                                            .toLocal()
                                            .toString()
                                            .substring(0, 11),
                                        fontSize: 13,
                                        fontcolor: greyColor),
                                    SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor),
                                          onPressed: () {
                                            download(
                                                    url: currentItem["invoice"]
                                                        .toString(),
                                                    orderid: currentItem["_id"])
                                                .then((value) {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.success,
                                                title: "Saved in " + value,
                                                confirmBtnText: 'Okay',
                                                onConfirmBtnTap: () =>
                                                    {Navigator.pop(context)},
                                              );
                                            });
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.download_outlined,
                                                size: 18,
                                              ),
                                              Text(
                                                "Download Invoice",
                                                textScaleFactor: 0.8,
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
