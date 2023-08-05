import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/screen/widgets/detail_sheet.dart';
import 'package:http/http.dart' as http;

import '../controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).someFunction();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 45, 45),
      appBar: AppBar(
        title: Text(
          "Company NAme",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 45, 45),
        elevation: 0,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => ListView.builder(
          itemCount: 13,
          itemBuilder: (context, index) {
            return tileCard(size, index);
          },
        ),
      ),
    );
  }

  Widget tileCard(Size size, int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.black,
        // shape: StadiumBorder(
        //   side: BorderSide(
        //     color: Color.fromARGB(255, 247, 244, 244),
        //     width: 1.0,
        //   ),
        // ),
        elevation: 0,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // border: Border(
              //   bottom: BorderSide(
              //     color: Color.fromARGB(255, 114, 113, 113),
              //     width: 5,
              //   ),
              // ),
              ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                DetailsSheet sheet = DetailsSheet();
                sheet.showBottomSheet(
                  context,
                  size,
                );
              },
              leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.yellow,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  )),
              title: Text(
                "Chovva".toString().toUpperCase(),
                // "sjfjsfbjzfn znjfjzf fznfzjfbdf jhsfbjhfbdf fbjhfb",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                spacing: 18.0,
                runAlignment: WrapAlignment.center,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    height: 50,
                    width: 1,
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Container(
                    child: Text(
                      "12",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
