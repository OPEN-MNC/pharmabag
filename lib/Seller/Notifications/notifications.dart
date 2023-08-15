import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/notifications_repo/notifications_repo.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  List<dynamic> note = [];
  getNotifications() async {
    var res = await NotificationRepo().getNotifications().then((value) {
      var data = jsonDecode(value);
      setState(() {
        note = data as List<dynamic>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              itemCount: note.length,
              itemBuilder: (context, index) {
                final notification = note[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                              color: primaryColor, fontWeight: FontWeight.w700),
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
    );
  }
}
