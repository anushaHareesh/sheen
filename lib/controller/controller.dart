import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Controller extends ChangeNotifier {
  // customNotifier() {
  //   Stream.periodic(const Duration(seconds: 10)).listen((_) {
  //     ///fetch data
  //     Future<List<dynamic>>.delayed(const Duration(milliseconds: 500),
  //         () async {
  //       someFunction();
  //     });
  //   });
  //   notifyListeners();
  // }

  ////////////////////////////////////
  someFunction() async {
    Uri url = Uri.parse("http://www.omdbapi.com/?s='iron man'&apikey=eb0d5538");
    Stream.periodic(const Duration(seconds: 30)).listen((_) {
      Future<List<dynamic>>.delayed(const Duration(milliseconds: 500),
          () async {
        final response = await http.get(url);
        final map = jsonDecode(response.body);
        print("map------$map");
        return map["Search"];
      });
    });
  }
}
