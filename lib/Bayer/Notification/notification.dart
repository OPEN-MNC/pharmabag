// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Bayer/home/buyer_home.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class BuyerNotifications extends StatefulWidget {
  final List<dynamic> note;
  const BuyerNotifications({Key? key, required this.note}) : super(key: key);

  @override
  State<BuyerNotifications> createState() => _BuyerNotificationsState();
}

class _BuyerNotificationsState extends State<BuyerNotifications> {
  @override
  void initState() {
    super.initState();
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _storage.write(
            key: 'lastDate', value: DateTime.now().toIso8601String());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BuyerHome(isLoggedIn: true)));
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: primaryColor),
            title: const ReusableText(
                text: "Notifications", fontSize: 18, fontcolor: primaryColor),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            // leading: IconButton(
            //     onPressed: () {
            //       Keys().scaffoldKey.currentState!.openDrawer();
            //     },
            //     icon: const Icon(
            //       Icons.sort,
            //       color: primaryColor,
            //       size: 30,
            //     )),
            // actions: [
            //   InkWell(
            //     onTap: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const Notifications())),
            //     child: const CircleAvatar(
            //       radius: 30.0,
            //       backgroundColor: Colors.transparent,
            //       backgroundImage: NetworkImage(
            //           "https://www.tatatrusts.org/images/Ratan_N_Tata_sm.jpg"),
            //     ),
            //   ),
            // ]
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                itemCount: widget.note.length,
                itemBuilder: (context, index) {
                  final notification = widget.note[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: primaryColor, width: 0.6)),
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          leading: const CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Center(
                                  child: Icon(
                                Icons.notifications,
                                color: whiteColor,
                              ))),
                          title: Text(
                            notification['message'].toString(),
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(notification['date']
                                .toString()
                                .substring(0, 10)
                                .replaceAll('-', "/")),
                          ),
                          trailing: const Icon(
                            Icons.circle,
                            size: 8,
                            color: greenColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
