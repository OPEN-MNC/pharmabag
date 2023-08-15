// import 'dart:js_interop';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pharmabag/Seller/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:background_fetch/background_fetch.dart';

// Initialize the FlutterLocalNotificationsPlugin instance
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  // Initialize the background execution
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the FlutterLocalNotificationsPlugin
  await initNotifications();

  // Configure and register the background task
  BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 1, // Execute every 15 minutes
        stopOnTerminate: false,
        enableHeadless: true,
        forceAlarmManager: true,
      ),
      fetchUpdates, (String taskId) async {
    // <-- Task timeout callback
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    BackgroundFetch.finish(taskId);
  });

  // Start the background task
  BackgroundFetch.start();
  runApp(MyApp());
}

String token = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      title: 'Pharmabag',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  getToken() async {
    token = await _storage.read(key: 'token').then((value) {
      return value.toString();
    });
    return token.toString();
  }

  @override
  void initState() {
    getToken();
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    token == "undefined" || token == "" || token == "null"
                        ? const LoginScreen()
                        : const BottomNavBarpage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Center(
            child: Center(
          child: Image(image: AssetImage("assets/images/pharmabag_seller.png")),
        )));
  }
}

//==========================================
void fetchUpdates(task) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const String apiUrl = 'https://pharmabag.in:3000/seller/my/notifications';

  try {
    final http.Response response =
        await http.get(Uri.parse(apiUrl), headers: {"auth-token": token});
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      final String latestUpdate = jsonData[0]['message'];

      // Check if the latest update is different from the stored value
      final String storedUpdate = prefs.getString('latestUpdate') ?? '';
      if (latestUpdate != storedUpdate) {
        // Display a notification
        await showNotification(latestUpdate);

        // Update the stored value
        prefs.setString('latestUpdate', latestUpdate);
      }
    }
  } catch (e) {}
  BackgroundFetch.scheduleTask(
      TaskConfig(periodic: true, delay: 6000, taskId: task));
  // Complete the background task
}

// Initialize the FlutterLocalNotificationsPlugin
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      const InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Show a notification with the given message
Future<void> showNotification(String message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    'New Update',
    message,
    platformChannelSpecifics,
  );
}
//=============================================
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// String token = '';

// class _MyAppState extends State<MyApp> {
//   getToken() async {
//     token = await _storage.read(key: 'token').then((value) {
//       return value.toString();
//     });
//     print('The token is $token');
//     return token.toString();
//   }

//   final FlutterSecureStorage _storage = const FlutterSecureStorage();
//   @override
//   void initState() {
//     getToken();

//     super.initState();
//     Timer(
//         Duration(seconds: 5),
//         () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => token == ""
//                     ? const LoginScreen()
//                     : const BottomNavBarpage())));
//   }

//   // This widget is the root of your application.

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Pharmabag',
//         debugShowCheckedModeBanner: false,
//         localizationsDelegates: const [
//           GlobalWidgetsLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           MonthYearPickerLocalizations.delegate,
//         ],
//         theme: ThemeData(
//           // is not restarted.
//           primaryColor: primaryColor,
//         ),
//         home: Container(
//             color: primaryColor,
//             child: FlutterLogo(size: MediaQuery.of(context).size.height))

//         // home:  SellerProductDetails(),
//         // home: firstform(),
//         );
//   }
// }
