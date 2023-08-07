import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sheenbakery/db_helper.dart';
import 'package:sheenbakery/screen/home_page.dart';

import '../components/common_data.dart';
import '../components/custom_snackbar.dart';
import '../components/external_dir.dart';
import '../components/network_connectivity.dart';
import '../model/registration_model.dart';
import '../screen/authentication/login.dart';

class RegistrationController extends ChangeNotifier {
  String? userName;
  bool scheduleOpend = false;
  bool isMenuLoading = false;
  bool isAdminLoading = false;
  bool isServSchedulelIstLoadind = false;
  int scheduleListCount = 0;
  String? pendingEnq;
  String? pendingQtn;
  String? cnfQut;
  String? pendingSer;
  String? cust_id;
  String? cust_name;
  String? name;
  List<String> servceScheduldate = [];
  bool isProdLoding = false;
  DateTime now = DateTime.now();
  String? dateToday;
  int servicescheduleListCount = 0;
  List<Map<String, dynamic>> todyscheduleList = [];
  List<Map<String, dynamic>> tomarwscheduleList = [];

  List<Map<String, dynamic>> servicescheduleList = [];
  List<Map<String, dynamic>> servicesProdList = [];
  List<bool> showComplaint = [];
  bool isSchedulelIstLoadind = false;
  String? staffName;
  bool isLoading = false;
  bool isLoginLoading = false;

  ExternalDir externalDir = ExternalDir();
  String? menuIndex;
  String? fp;
  String? cid;
  String? cname;
  String? sof;
  int? qtyinc;
  String? uid;
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> confrmedQuotGraph = [];
  List<Map<String, dynamic>> userservDone = [];
  String? appType;
  String? bId;
  // ignore: non_constant_identifier_names
  List<CD> c_d = [];
  String? firstMenu;
///////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String companyCode,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      print("Text fp...$fingerprints---$companyCode---$phoneno---$deviceinfo");
      // ignore: prefer_is_empty
      if (companyCode.length >= 0) {
        appType = companyCode.substring(10, 12);
      }
      if (value == true) {
        try {
          Uri url =
              Uri.parse("https://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': companyCode,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          // ignore: avoid_print
          print("register body----$body");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          // print("body $body");
          var map = jsonDecode(response.body);
          // ignore: avoid_print
          print("regsiter map----$map");
          RegistrationData regModel = RegistrationData.fromJson(map);

          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;

          if (sof == "1") {
            if (appType == 'RX') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              String? fp1 = regModel.fp;

              // ignore: avoid_print
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);

              cid = regModel.cid;
              prefs.setString("cid", cid!);

              cname = regModel.c_d![0].cnme;

              prefs.setString("cname", cname!);

              print("cid----cname-----$cid---$cname");
              notifyListeners();

              await externalDir.fileWrite(fp1!);

              // ignore: duplicate_ignore
              for (var item in regModel.c_d!) {
                print("ciddddddddd......$item");
                c_d.add(item);
              }
              // verifyRegistration(context, "");

              isLoading = false;
              notifyListeners();

              prefs.setString("user_type", appType!);
              String? user = prefs.getString("userType");
              await SheenDB.instance
                  .deleteFromTableCommonQuery("companyRegistrationTable", "");
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              CustomSnackbar snackbar = CustomSnackbar();
              // ignore: use_build_context_synchronously
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            // ignore: use_build_context_synchronously
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          // ignore: avoid_print
          print(e);
          return null;
        }
      }
    });
    return null;
  }

  //////////////////////////////////////////////////////////
  getLogin(String userName, String password, BuildContext context) async {
    try {
      Uri url = Uri.parse("$apiurl/login.php");
      Map body = {
        'uname': userName,
        'pass': password,
      };
      print("body------$body");
      isLoginLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("login body ${body}");

      var map = jsonDecode(response.body);
      print("login map ${map}");
      isLoginLoading = false;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (map == null || map.length == 0) {
        CustomSnackbar snackbar = CustomSnackbar();
        // ignore: use_build_context_synchronously
        snackbar.showSnackbar(context, "Incorrect Username or Password", "");
        isLoginLoading = false;
        notifyListeners();
      } else {
        prefs.setString("st_uname", userName);
        prefs.setString("name", map[0]["name"]);
        prefs.setString("st_pwd", password);
        prefs.setString("user_id", map[0]["user_id"]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }

      // print("stafff-------${loginModel.staffName}");
      notifyListeners();
      // return staffModel;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  getUserData() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cname = prefs.getString("cname");
    print("haiii ----$cname");
    isLoading = false;
    notifyListeners();
  }
}
