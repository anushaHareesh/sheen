import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheenbakery/screen/authentication/login.dart';
import 'package:sheenbakery/screen/authentication/login.dart';
import 'package:sheenbakery/screen/authentication/registration.dart';
import 'package:sheenbakery/screen/home_page.dart';
import 'package:sheenbakery/screen/stream_home.dart';

import 'controller/controller.dart';
import 'controller/registration_controller.dart';

bool isLoggedIn = false;
bool isRegistered = false;
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => RegistrationController()),
    ],
    child: const MyApp(),
  ));
}

checkLogin() async {
  bool isAuthenticated = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final stUname = prefs.getString("st_uname");
  final stPwd = prefs.getString("st_pwd");

  if (stUname != null && stPwd != null) {
    isAuthenticated = true;
  } else {
    isAuthenticated = false;
  }
  return isAuthenticated;
}

checkRegistration() async {
  bool isAuthenticated = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString("st_uname", "anu");
  // prefs.setString("st_pwd", "anu");
  final cid = prefs.getString("cid");
  if (cid != null) {
    isAuthenticated = true;
  } else {
    isAuthenticated = false;
  }
  return isAuthenticated;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.yellow,
            secondaryHeaderColor: Colors.black,
            // primaryColor: Colors.red[400],
            // accentColor: Color.fromARGB(255, 248, 137, 137),
            scaffoldBackgroundColor: Colors.white,
            // fontFamily: 'Roboto Mono sample',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.aBeeZeeTextTheme()
            // scaffoldBackgroundColor: P_Settings.bodycolor,
            // textTheme: const TextTheme(
            //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //   headline6: TextStyle(
            //     fontSize: 25.0,
            //   ),
            //   bodyText2: TextStyle(
            //     fontSize: 14.0,
            //   ),
            // ),
            ),
        // home: isRegistered
        //     ? isLoggedIn
        //         ? const HomePage()
        //         : const LoginPage()
        //     : const Registration()
        home: LoginPage(),
        );
  }
}
