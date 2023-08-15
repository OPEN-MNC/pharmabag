// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:pharmabag/Seller/drawer.dart';
import 'package:pharmabag/Seller/Tickets/chat_screen.dart';
import 'package:pharmabag/Seller/Tickets/create_a_ticket.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/ticket_repo/ticket.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class ShowTickets extends StatefulWidget {
  final String user;
  const ShowTickets({Key? key, this.user = ''}) : super(key: key);

  @override
  State<ShowTickets> createState() => _ShowTicketsState();
}

class _ShowTicketsState extends State<ShowTickets> {
  @override
  void initState() {
    getTickets();
    super.initState();
  }

  List<dynamic> data = [];
  getTickets() async {
    var res = await Tickets().getTickets().then((value) {
      setState(() {
        data = jsonDecode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavBarpage()));
        return true;
      },
      child: Scaffold(
        drawer: const Drawer(
          child: Drawers(),
        ),
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          backgroundColor: primaryColor,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTicket())),
          label: const Row(
            children: [
              Icon(
                Icons.create,
                color: whiteColor,
                size: 16,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Create Ticket',
                style: TextStyle(color: whiteColor),
              )
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: primaryColor),
            title: const ReusableText(
                text: 'Tickets', fontSize: 18, fontcolor: primaryColor),
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
        body: data.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.918,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var currentItem = data.reversed.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                          child: Card(
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: primaryColor, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            currentItem['status'] == 0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                                color:
                                                                    primaryColor,
                                                                width: 1.0)),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            'Processsing',
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: greenColor,
                                                            width: 0.6)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text('Closed',
                                                          style: TextStyle(
                                                              color:
                                                                  greenColor)),
                                                    ))
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Reason',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(currentItem['reason']),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Subject',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(currentItem['subject']),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Created on',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(currentItem['createdAt']
                                                    .toString()
                                                    .substring(0, 10)
                                                    .replaceAll('-', '/')),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24.0),
                                        child: Row(
                                          children: [
                                            MaterialButton(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreen(
                                                            user: widget.user,
                                                            id: currentItem[
                                                                '_id'],
                                                            date: currentItem[
                                                                'createdAt'],
                                                            message:
                                                                currentItem[
                                                                    'message'],
                                                          ))),
                                              color: primaryColor,
                                              child: const Text(
                                                'View Details',
                                                style: TextStyle(
                                                    color: whiteColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    ))),
      ),
    );
  }
}
