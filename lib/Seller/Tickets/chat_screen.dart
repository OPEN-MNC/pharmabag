import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/ticket_repo/messages.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String user;
  final String id;
  final String date;
  final String message;
  const ChatScreen(
      {Key? key,
      required this.user,
      required this.id,
      required this.date,
      required this.message})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    getMessages();
    super.initState();
  }

  List<dynamic> data = [];
  getMessages() async {
    var res = await Messages().getMessage(widget.id);
    data = jsonDecode(res);
    setState(() {
      data = jsonDecode(res);
    });
  }

  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: primaryColor),
          title: const ReusableText(
              text: 'Chat', fontSize: 18, fontcolor: primaryColor),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Id',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.id,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Date',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        widget.date
                                            .substring(0, 10)
                                            .replaceAll('-', '/'),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.73,
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment:
                                data[index]['user_name'].toString() == " "
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Material(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data[index]['message'].toString(),
                                        style: const TextStyle(
                                          color: whiteColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data[index]['createdAt']
                                            .toString()
                                            .substring(0, 10),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: greyColor,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ))),
                      );
                    }),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: message,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: greyColor, width: 0.6),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: primaryColor, width: 0.9),
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FlutterSecureStorage _storage =
                              const FlutterSecureStorage();
                          String url =
                              "https://pharmabag.in:3000/seller/send/message/for/ticket/${widget.id}";
                          String token =
                              await _storage.read(key: 'token').then((value) {
                            return value.toString();
                          });
                          http.Response res = await http.post(Uri.parse(url),
                              body: {'message': message.text},
                              headers: {'auth-token': token});

                          if (res.statusCode == 200) {
                            getMessages();
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(res.body)));
                          }
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: const Material(
                            type: MaterialType.circle,
                            color: primaryColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              child: Icon(
                                Icons.send,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
