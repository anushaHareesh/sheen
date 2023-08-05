import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StreamHome extends StatefulWidget {
  const StreamHome({super.key});

  @override
  State<StreamHome> createState() => _StreamHomeState();
}

class _StreamHomeState extends State<StreamHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<dynamic>(
          stream: generateNumbers,
          builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                      snapshot.data[index]["Title"].toString(),
                      style: TextStyle(fontSize: 13),
                    ));
                  },
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              print("ddd---${snapshot.data.length} ----- ${snapshot.data}");
              return Container();
              // return ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //         title: Text(
              //       snapshot.data.toString(),
              //       style: TextStyle(fontSize: 13),
              //     ));
              //   },
              // );
            }
          },
        ),
      ),
    );
  }

  Stream<dynamic> generateNumbers = (() async* {
    // await Future<void>.delayed(Duration(seconds: 2));
    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(minutes: 1));
      Uri url =
          Uri.parse("http://www.omdbapi.com/?s='iron man'&apikey=eb0d5538");
      final response = await http.get(url);
      final map = jsonDecode(response.body);
      print("map------$map");
      yield map["Search"];
    }
  })();
}
