import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmabag/Bayer/buyer_repositories/Auth_repo/auth_repo.dart';
import 'package:pharmabag/components_color/color.dart';
import 'package:pharmabag/reusable_components/text_textfield.dart';

class BuyerLogin extends StatefulWidget {
  const BuyerLogin({super.key});

  @override
  State<BuyerLogin> createState() => _BuyerLoginState();
}

class _BuyerLoginState extends State<BuyerLogin> {
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  int length = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          title: const ReusableText(
              text: "Welcome", fontSize: 18, fontcolor: primaryColor),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                type: MaterialType.card,
                elevation: 0,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12),
                        child: SizedBox(
                          height: 120,
                          child: Image.asset(
                            "assets/images/pharmabag_buyer.png",
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: child,
                              );
                            },
                            width: 360, // set the width of the image
                            height: 60, // set the height of the image
                            fit: BoxFit
                                .fitHeight, // set how the image should be scaled to fit its container
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   height: MediaQuery.of(context).size.height * 0.05,
                      //   decoration: const BoxDecoration(
                      //       color: primaryColor,
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(8.0),
                      //           topRight: Radius.circular(8.0))),
                      //   child: const Padding(
                      //     padding: EdgeInsets.all(8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text(
                      //           'Log in/Sign up',
                      //           style:
                      //               TextStyle(color: whiteColor, fontSize: 16),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                length = value.length;
                              });
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                counter: Text('$length/10'),
                                hintText: 'Enter Your Phone Number',
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greyColor,
                                      width: 0.7,
                                      style: BorderStyle.solid),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greyColor,
                                      width: 0.7,
                                      style: BorderStyle.solid),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (length == 10) {
                            BuyerAuth().sendOTP(phoneController.text, context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    icon: const Icon(Icons.dangerous_rounded),
                                    content:
                                        const Text('Phone number is invalid'),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () => Navigator.pop(context),
                                        color: greenColor,
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: const Center(
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyOTP extends StatefulWidget {
  final String phone;
  final String otp;
  const VerifyOTP({super.key, required this.otp, required this.phone});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          title: const ReusableText(
              text: "Verify OTP", fontSize: 18, fontcolor: primaryColor),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              type: MaterialType.card,
              elevation: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.42,
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 0.6)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                          decoration: const BoxDecoration(
                              color: greenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(
                                  'The OTP is ${widget.otp}',
                                  style: const TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: SizedBox(
                        height: 120,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: greyColor, width: 0.6)),
                        child: Image.asset(
                          'assets/images/pharmabag_seller.png',
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: child,
                            );
                          },
                          width: 360, // set the width of the image
                          height: 60, // set the height of the image
                          fit: BoxFit
                              .fitHeight, // set how the image should be scaled to fit its container
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Enter OTP',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (otpController.text == widget.otp) {
                          debugPrint('Verified Successfully');
                          BuyerAuth()
                              .getToken(widget.otp, widget.phone, context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  icon: const Icon(Icons.dangerous_rounded),
                                  content: const Text('The OTP is invalid'),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: primaryColor,
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: const Center(
                            child: Text(
                              'Verify OTP',
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExtraDetails extends StatefulWidget {
  final String phone;
  const ExtraDetails({super.key, required this.phone});

  @override
  State<ExtraDetails> createState() => _ExtraDetailsState();
}

class _ExtraDetailsState extends State<ExtraDetails> {
  final TextEditingController panController = TextEditingController();
  late final GroupButtonController controller;

  @override
  void initState() {
    controller = GroupButtonController(selectedIndex: 0);
    super.initState();
  }

  int pan = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: greyColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: GroupButton(
                  controller: controller,
                  options: const GroupButtonOptions(
                      selectedColor: greenColor, unselectedColor: Colors.white),
                  buttons: const ['GST', 'PAN'],
                  onSelected: (i, selected, value) {
                    // debugPrint('Button #$i $selected');
                    setState(() {
                      pan = selected;
                    });
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: panController,
                  decoration: InputDecoration(
                      hintText: pan == 0 ? 'Enter GST' : 'Enter PAN',
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greyColor,
                            width: 0.7,
                            style: BorderStyle.solid),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greyColor,
                            width: 0.7,
                            style: BorderStyle.solid),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (panController.text != '' && pan == 1) {
                  BuyerAuth()
                      .getDetails(panController.text, context, 1, widget.phone);
                } else if (panController.text != '' && pan == 0) {
                  BuyerAuth()
                      .getDetails(panController.text, context, 0, widget.phone);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: const BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Center(
                    child: Text(
                      'Get Details',
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FinalDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool gst;
  final String phone;
  const FinalDetails(
      {super.key, required this.data, this.gst = false, required this.phone});

  @override
  State<FinalDetails> createState() => _FinalDetailsState();
}

class _FinalDetailsState extends State<FinalDetails> {
  final TextEditingController name = TextEditingController();
  final TextEditingController pan = TextEditingController();
  final TextEditingController gst = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController streetAddress1 = TextEditingController();
  final TextEditingController streetAddress2 = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController licenseA = TextEditingController();
  final TextEditingController licenseB = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController inviteCode = TextEditingController();
  bool loading = false;
  bool validate() {
    if (name.text.isEmpty ||
        pan.text.isEmpty ||
        gst.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        fullname.text.isEmpty ||
        streetAddress1.text.isEmpty ||
        streetAddress2.text.isEmpty ||
        state.text.isEmpty ||
        city.text.isEmpty ||
        pincode.text.isEmpty ||
        landmark.text.isEmpty ||
        licenseA.text.isEmpty ||
        licenseB.text.isEmpty ||
        bankName.text.isEmpty ||
        branchName.text.isEmpty ||
        accountName.text.isEmpty ||
        ifsc.text.isEmpty ||
        accountName.text.isEmpty ||
        inviteCode.text.isEmpty ||
        image!.path == 'image' ||
        image2!.path == 'image2' ||
        image3!.path == 'image3') {
      return false;
    }
    return true;
  }

  bool? checked = false;
  File? image = File('image');
  File? image2 = File('image2');
  File? image3 = File('image3');
  DateTime expiryDate = DateTime.now();
  DateTime expiryDate2 = DateTime.now();
  double value = 0;
  @override
  void initState() {
    phone.text = widget.phone;
    if (widget.gst == true && widget.data['data']['error'] == false) {
      setState(() {
        name.text = widget.data['data']['data']['lgnm'].toString();
        gst.text = widget.data['data']['data']['gstin'].toString();
        state.text =
            widget.data['data']['data']['pradr']['addr']['stcd'].toString();
        streetAddress1.text =
            widget.data['data']['data']['pradr']['addr']['st'].toString();
        streetAddress2.text =
            widget.data['data']['data']['pradr']['addr']['loc'].toString();
        pincode.text =
            widget.data['data']['data']['pradr']['addr']['pncd'].toString();
        landmark.text =
            widget.data['data']['data']['pradr']['addr']['loc'].toString();
        city.text =
            widget.data['data']['data']['pradr']['addr']['dst'].toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: loading
            ? Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: AlertDialog(
                    icon: const CircleAvatar(
                      radius: 40,
                      child: Icon(
                        Icons.upload,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text('Uploading.'),
                    content: Center(
                      child: LinearProgressIndicator(
                        color: Colors.grey,
                        value: value,
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Basic Information',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 22.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                                'We\'ll use this details to keep you updated about your order'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: name,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Legal Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: pan,
                          decoration: const InputDecoration(
                              hintText: 'PAN',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: gst,
                          decoration: const InputDecoration(
                              hintText: 'GST',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: 'E-mail',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Shipping Information'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: fullname,
                          decoration: const InputDecoration(
                              hintText: 'Full Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: streetAddress1,
                          decoration: const InputDecoration(
                              hintText: 'Street Address',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: streetAddress2,
                          decoration: const InputDecoration(
                              hintText: 'Street Address 2',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: state,
                          decoration: const InputDecoration(
                              hintText: 'State',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: city,
                          decoration: const InputDecoration(
                              hintText: 'City',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: pincode,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Pin Code',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: landmark,
                          decoration: const InputDecoration(
                              hintText: 'Landmark',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Drug License Information'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: licenseA,
                          decoration: const InputDecoration(
                              hintText: 'D.L N. 20B',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Valid Till'),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: expiryDate,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            expiryDate = newDateTime;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7)),
                        child: Row(
                          children: [
                            Container(
                              color: primaryColor,
                              child: MaterialButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final img = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image = File(img!.path);
                                  });
                                },
                                child: const Text(
                                  'Browse',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              image!.path == 'image'
                                  ? 'No File Selected'
                                  : image!.path.length > 35
                                      ? '${image!.path.substring(0, 35)}....'
                                      : image!.path,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Drug License Information'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: licenseB,
                          decoration: const InputDecoration(
                              hintText: 'D.L N. 21B',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Valid Till'),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: expiryDate2,
                        onDateTimeChanged: (DateTime newDateTime) {
                          setState(() {
                            expiryDate2 = newDateTime;
                            debugPrint(expiryDate2.toString());
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7)),
                        child: Row(
                          children: [
                            Container(
                              color: primaryColor,
                              child: MaterialButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final img = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image2 = File(img!.path);
                                  });
                                },
                                child: const Text(
                                  'Browse',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              image2!.path == 'image2'
                                  ? 'No File Selected'
                                  : image2!.path.length > 35
                                      ? '${image2!.path.substring(0, 35)}....'
                                      : image2!.path,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Text('Bank Account Details'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Compulsory for Sellers'),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: bankName,
                          decoration: const InputDecoration(
                              hintText: 'Bank Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: branchName,
                          decoration: const InputDecoration(
                              hintText: 'Branch Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: accountNumber,
                          decoration: const InputDecoration(
                              hintText: 'Account No',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: ifsc,
                          decoration: const InputDecoration(
                              hintText: 'IFSC Code',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7)),
                        child: Row(
                          children: [
                            Container(
                              color: primaryColor,
                              child: MaterialButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final img = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    image3 = File(img!.path);
                                  });
                                },
                                child: const Text(
                                  'Browse',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              image3!.path == 'image3'
                                  ? 'No File Selected'
                                  : image3!.path.length > 35
                                      ? '${image3!.path.substring(0, 35)}....'
                                      : image3!.path,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: accountName,
                          decoration: const InputDecoration(
                              hintText: 'Account Holder\'s Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                checked = value;
                              });
                            }),
                        const Text(
                            'I agree to Pharmabag\'s privacy policy and terms of use')
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: inviteCode,
                          decoration: const InputDecoration(
                              hintText: 'Invite Code',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: greyColor,
                                    width: 0.7,
                                    style: BorderStyle.solid),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (validate() && checked.toString() == 'true') {
                          setState(() {
                            loading = true;
                          });
                          var response = await BuyerAuth()
                              .upload(image!, image2!, image3!)
                              .then((response) async {
                            debugPrint('The images are $response');
                            await BuyerAuth()
                                .getGeoLocation(
                                    city.text, state.text, pincode.text)
                                .then((value) {
                              debugPrint('The cords are $value');
                              List<String> DL20B = [
                                licenseA.text,
                                expiryDate.toString(),
                                response[0].toString()
                              ];
                              debugPrint('The licenseA are $DL20B');
                              List<String> DL21B = [
                                licenseB.text,
                                expiryDate2.toString(),
                                response[1].toString()
                              ];
                              debugPrint('The licenseB are $DL21B');
                              var address = {
                                "street_address": streetAddress1.text,
                                "street_address2": streetAddress2.text,
                                "state": state.text,
                                "city": city.text,
                                "pincode": pincode.text,
                                "landmark": landmark.text,
                                "cords": value
                              };
                              var license = {"DL20B": DL20B, "DL21B": DL21B};
                              var bankAccount = {
                                "bank_name": bankName.text,
                                "branch_name": branchName.text,
                                "account_no": accountNumber.text,
                                "ifsc_code": ifsc.text,
                                "acc_name": accountName.text,
                                "cancel_cheque": response[2]
                              };

                              debugPrint(bankAccount.toString());
                              var gstResponse = widget.data['data']['data'];
                              debugPrint(gstResponse.toString());
                              BuyerAuth().register(
                                  name.text,
                                  email.text,
                                  phone.text,
                                  fullname.text,
                                  // address.toString(),
                                  jsonEncode(address).toString(),
                                  DL20B,
                                  DL21B,
                                  // bankAccount.toString(),
                                  jsonEncode(bankAccount).toString(),
                                  inviteCode.text,
                                  // license.toString(),
                                  jsonEncode(license).toString(),
                                  // gstResponse.toString());
                                  jsonEncode(gstResponse).toString());
                            });
                            setState(() {
                              loading = false;
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please complete the details')));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: loading
                                ? const CircularProgressIndicator(
                                    color: whiteColor,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(color: whiteColor),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
