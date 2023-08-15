// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmabag/Bayer/home/ticket/chat_screen.dart';
import 'package:pharmabag/Seller/Tickets/create_a_ticket.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/ticket_repo/ticket.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class ShowTicket extends StatefulWidget {
  final String user;
  const ShowTicket({Key? key, this.user = ''}) : super(key: key);

  @override
  State<ShowTicket> createState() => _ShowTicketState();
}

class _ShowTicketState extends State<ShowTicket> {
  @override
  void initState() {
    getTickets();
    super.initState();
  }

  List<dynamic> data = [];
  getTickets() async {
    var res = await Tickets().getBuyerTickets().then((value) {
      setState(() {
        data = jsonDecode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: primaryColor,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateTicket())),
        child: const Icon(
          Icons.create,
          color: whiteColor,
          size: 25,
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
                                          data[index]['status'] == 0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              color:
                                                                  primaryColor,
                                                              width: 1.0)),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
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
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: greenColor,
                                                          width: 0.6)),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text('Closed',
                                                        style: TextStyle(
                                                            color: greenColor)),
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
                                              Text(data[index]['reason']),
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
                                              Text(data[index]['subject']),
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
                                              Text(data[index]['createdAt']
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
                                                          id: data[index]
                                                              ['_id'],
                                                          date: data[index]
                                                              ['createdAt'],
                                                          message: data[index]
                                                              ['message'],
                                                        ))),
                                            color: primaryColor,
                                            child: const Text(
                                              'View Details',
                                              style:
                                                  TextStyle(color: whiteColor),
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
    );
  }
}
