// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:pharmabag/Seller/Tickets/ticket_show.dart';
import 'package:pharmabag/components_&_color/color.dart';
import 'package:pharmabag/repositories/ticket_repo/ticket.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';
import 'package:quickalert/quickalert.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({Key? key}) : super(key: key);

  @override
  CreateTicketState createState() => CreateTicketState();
}

class CreateTicketState extends State<CreateTicket> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  addTicket() async {
    var res = await Tickets()
        .addTicket(
            textController1.text, textController2.text, textController3.text)
        .then((value) {
      debugPrint(value.toString());
      if (value == 200) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            text: 'Ticket Created successfully',
            confirmBtnText: 'Ok',
            onConfirmBtnTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ShowTickets())));
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: 'Ticket Creation failed',
            confirmBtnText: 'Ok',
            onConfirmBtnTap: () => Navigator.pop(context));
      }
    });
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: primaryColor),
          title: const ReusableText(
              text: "Create a Ticket", fontSize: 18, fontcolor: primaryColor),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Align(
            alignment: const AlignmentDirectional(0.05, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(-0.05, 0),
                  child: Container(
                    width: double.infinity,
                    height: 691,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                14, 14, 14, 14),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 0),
                                      child: TextFormField(
                                        controller: textController1,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Reason',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          hintText: 'Reason',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 0),
                                      child: TextFormField(
                                        controller: textController2,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Subject',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          hintText: 'Subject',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.7,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.7,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.7,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.7,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 0),
                                      child: TextFormField(
                                        controller: textController3,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Message',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          hintText: 'Message',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: primaryColor,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: red,
                                              width: 0.6,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        maxLines: 5,
                                        minLines: 4,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 20, 0),
                                      child: InkWell(
                                        onTap: () => addTicket(),
                                        child: Container(
                                            width: 380,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                )),
                                            child: Center(
                                              child: Text(
                                                'Create a ticket',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
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
