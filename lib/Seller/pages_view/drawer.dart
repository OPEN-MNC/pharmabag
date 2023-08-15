import 'package:flutter/material.dart';
import 'package:pharmabag/Seller/pages_view/notification.dart';
import 'package:pharmabag/components_&_color/color.dart';

class drawerPage extends StatelessWidget {
  const drawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
              accountEmail: Text("test@gmail.com"),
              accountName: Text("Test Man"),
              currentAccountPicture: CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://www.tatatrusts.org/images/Ratan_N_Tata_sm.jpg"))),

          ListTile(
            // leading: const Icon(Icons.local_mall),
            leading: const Icon(Icons.all_inbox),
            title: const Text(
              'Product',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => homePage())));
            },
          ),

          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text(
              'Tickets',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.fact_check),
            title: const Text(
              'Settlement',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => homePage())));
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const notificationPage())));
            },
          ),

          ListTile(
            leading: const Icon(Icons.auto_graph),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => homePage())));
            },
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Accoun',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 100),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
              child: const Text(
                'vication mood',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          //sing Out button
          const SizedBox(height: 30),

          ListTile(
            leading: const Icon(Icons.warning_amber),
            title: const Text(
              'Log Out',
              style: TextStyle(fontSize: 17),
            ),
            onTap: () {},
          ),

          // Center(
          //   child: ElevatedButton(

          //     child: const Text('Log out',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 17,
          //     ),
          //     ),
          //     onPressed: () {
          //       print('button pressed');

          //      },
          //      style: ElevatedButton.styleFrom(
          //       minimumSize: const Size(200, 40),
          //       backgroundColor: const Color.fromARGB(245, 86, 180, 57),
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(50)),
          //       ),
          //   ),
          // ),
          // ),

          //  ------------ Add More option in drawer ------------
        ],
      ),
    );
  }
}
