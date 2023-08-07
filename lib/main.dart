import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
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
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  isLoggedIn = await checkLogin();
  isRegistered = await checkRegistration();
  requestPermission();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => RegistrationController()),
    ],
    child: const MyApp(),
  ));
  FlutterNativeSplash.remove();
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

void requestPermission() async {
  var sta = await Permission.storage.request();
  var status = Platform.isIOS
      ? await Permission.photos.request()
      : await Permission.manageExternalStorage.request();
  if (status.isGranted) {
    await Permission.manageExternalStorage.request();
  } else if (status.isDenied) {
    await Permission.manageExternalStorage.request();
  } else if (status.isRestricted) {
    await Permission.manageExternalStorage.request();
  } else if (status.isPermanentlyDenied) {
    await Permission.manageExternalStorage.request();
  }
  // if (!status1.isGranted) {
  //   var status = await Permission.manageExternalStorage.request();
  //   if (status.isGranted) {
  //   } else if (!status1.isRestricted) {
  //     await Permission.manageExternalStorage.request();
  //   } else if (!status1.isPermanentlyDenied) {
  //     await Permission.manageExternalStorage.request();
  //   } else if (!status1.isDenied) {
  //     await Permission.manageExternalStorage.request();
  //   }
  // }
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
        home: isRegistered
            ? isLoggedIn
                ? const HomePage()
                : const LoginPage()
            : const Registration()
        // home: LoginPage()
        );
  }
}
