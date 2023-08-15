// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:pharmabag/Seller/Bottom_nav_bar.dart';
// import 'package:pharmabag/authentication/login.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   var token;
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();
//   @override
//   void initState() {
//     getToken();
//     super.initState();
//   }

//   getToken() async {
//     token = await _storage.read(key: 'token').then((value) {
//       debugPrint('the token is $value');
//       return value.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return token.runtimeType.toString() != "String"
//         ? const LoginScreen()
//         : const bottomNavBarpage();
//   }
// }
