import 'package:flutter/material.dart';
import 'package:pharmabag/components_&_color/color.dart';

class Accounts extends StatefulWidget {
  Map<String, dynamic> data;
  Accounts({Key? key, required this.data}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: primaryColor),

          title: const Text('My Profile',
              style: TextStyle(fontSize: 18, color: primaryColor)),
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.06,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 0.7),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: Image.network(
                                    'https://pharmabag.in/pharmabag-seller/assets/images/avatars/avatar-1.png',
                                    errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    "https://pharmabag.in/image/logo/logo-edited.png",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.contain,
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.data['buyer_details']['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.data['buyer_details']['buyer_id'].toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.data['buyer_user']['_id'].toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.data['buyer_details']['legal_name']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.data['buyer_details']['address']['street_address']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.data['buyer_details']['address']['street_address2']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              )
                            ],
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
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Business Information',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Material(
                  type: MaterialType.card,
                  borderRadius: BorderRadius.circular(8),
                  elevation: 1,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'PAN No',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Undefined',
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'GST No',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.data['buyer_details']['gst_pan_response']
                                  ['gstin'],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Drug LIC 20B License',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['licence']['DL20B'][0]}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Valid Till',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['licence']['DL20B'][1]}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Drug LIC 21B License',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['licence']['DL21B'][0]}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Valid Till',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['licence']['DL21B'][1]}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('State',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['address']['state']}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Pincode',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['address']['pincode']}'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Banking Information',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  type: MaterialType.card,
                  elevation: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Account No',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.data['buyer_details']['bank_account']['account_no']}',
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'IFSC Code',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.data['buyer_details']['bank_account']
                                  ['ifsc_code'],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Branch Name',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['bank_account']['branch_name']}'),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Divider(
                          height: 2,
                          color: greyColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Bank Name',
                                style: TextStyle(color: primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.data['buyer_details']['bank_account']['bank_name']}'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
