import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheenbakery/components/common_data.dart';

import '../components/network_connectivity.dart';

class Controller extends ChangeNotifier {
  List<Map<String, dynamic>> branch_list = [];
  List<Map<String, dynamic>> sale_data = [];
  List<Map<String, dynamic>> coll_data = [];
  String total_csh = "";
  List<Map<String, dynamic>> damage_list = [];
  double sum = 0.0;
  int dmg_count = 0;
  bool isDashLoading = false;
  bool isDashDataLoading = false;
  bool isLoading = false;
  double difference = 0.0;
  String? last_s_dt;
  // customNotifier() {
  //   Stream.periodic(const Duration(seconds: 10)).listen((_) {
  //     ///fetch data
  //     Future<List<dynamic>>.delayed(const Duration(milliseconds: 500),
  //         () async {
  //       return someFunction();
  //     });
  //   });
  //   // notifyListeners();
  // }
  geInitialization(BuildContext context, String fdate) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$apiurl/load_dashboard.php");
          Map body = {
            'f_date': fdate,
          };
          isDashLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          final map = jsonDecode(response.body);
          branch_list.clear();
          for (var item in map) {
            branch_list.add(item);
          }
          isDashLoading = false;
          notifyListeners();
          loadDashboard(context, fdate, "");
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////
  loadDashboard(BuildContext context, String f_date, String type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$apiurl/load_dashboard.php");
          int dura = 10;
          if (type == "init") {
            print("hahhh");
            isDashLoading = true;
            notifyListeners();
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("date", f_date);

          Stream.periodic(Duration(minutes: 5)).listen((_) {
            Future<List<dynamic>>.delayed(const Duration(milliseconds: 500),
                () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? fdate = prefs.getString("date");
              Map body = {
                'f_date': fdate,
              };
              print("ggbody------$body");
              http.Response response = await http.post(
                url,
                body: body,
              );
              final map = jsonDecode(response.body);
              branch_list.clear();
              for (var item in map) {
                branch_list.add(item);
              }
              if (type == "init") {
                isDashLoading = false;
                notifyListeners();
              }
              notifyListeners();
              print("branch_list------$branch_list");
              return branch_list;
              // notifyListeners();
            });
          });
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

///////////////////////////////////////////////////////////////////////////////
  getDashboardDetails(BuildContext context, String br_id, String f_date) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$apiurl/load_details.php");
          isDashDataLoading = true;
          notifyListeners();
          Map body = {
            'branch_id': br_id,
            'f_date': f_date,
          };
          print("dash-------$body");
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("map-det--$map");
          sale_data.clear();
          for (var item in map["sale_data"]) {
            sale_data.add(item);
          }

          coll_data.clear();
          if (map["colectn"].length > 0) {
            for (var item in map["colectn"]) {
              coll_data.add(item);
            }
          }
          total_csh = map["total_csh"].toString();
          dmg_count = int.parse(map["dmg_cnt"]);
          last_s_dt = map["last_s_dt"].toString();
          notifyListeners();
          sum = 0.0;
          for (int i = 0; i < sale_data.length; i++) {
            sum = double.parse(sale_data[i]["p_amount"]) + sum;
          }
          isDashDataLoading = false;
          notifyListeners();

          print("dashDeatilsList--------${sale_data}");
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////
  getDamageData(BuildContext context, String br_id, String f_date) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$apiurl/load_dmg_details.php");
          // isDashDataLoading = true;
          // notifyListeners();
          Map body = {
            'branch_id': br_id,
            'f_date': f_date,
          };
          print("dash-------$body");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("damage ---$map");
          damage_list.clear();
          for (var item in map) {
            damage_list.add(item);
          }
          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////
  saveCollection(BuildContext context, String br_id, String f_date, String camt,
      String pamt) {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$apiurl/save_colection.php");
          // isDashDataLoading = true;
          // notifyListeners();
          Map body = {
            'branch_id': br_id,
            'camnt': camt,
            'pamt': pamt,
            'f_date': f_date,
          };
          print("save collection body-------$body");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(url, body: body);
          var map = jsonDecode(response.body);
          print("save collection map ---$map");
          // damage_list.clear();
          // for (var item in map) {
          //   damage_list.add(item);
          // }
          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  calculateDifference(double d, double d1) {
    difference = d - d1;
    print("jbjhxfbjhfgb----$difference---$d---$d1");
    notifyListeners();
  }
}
