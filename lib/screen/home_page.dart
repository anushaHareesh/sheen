import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/controller/registration_controller.dart';
import 'package:sheenbakery/screen/widgets/detail_sheet.dart';
import 'package:http/http.dart' as http;

import '../controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    Provider.of<Controller>(context, listen: false).geInitialization(
      context,
      formattedDate!,
    );
    Provider.of<RegistrationController>(context, listen: false).getUserData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary:
                    Color.fromARGB(255, 238, 183, 3), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold) // button text color
                    ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        Provider.of<Controller>(context, listen: false).geInitialization(
          context,
          formattedDate!,
        );
        // Provider.of<Controller>(context, listen: false)
        //     .loadDashboard(context, formattedDate!, "init");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 45, 45),
      appBar: AppBar(
        toolbarHeight: 90, // default is 56
        toolbarOpacity: 0.5,
        title: Consumer<RegistrationController>(
          builder: (context, value, child) => value.isLoading
              ? SpinKitChasingDots(
                  color: Colors.white,
                  size: 14,
                )
              : Column(
                  children: [
                    Text(
                      value.cname.toString().toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Text(
                        "( ${formattedDate.toString()} )",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 45, 45),
        elevation: 0,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isDashLoading
            ? SpinKitCircle(
                color: Colors.yellow,
              )
            : ListView.builder(
                itemCount: value.branch_list.length,
                itemBuilder: (context, index) {
                  return tileCard(size, index, value.branch_list[index]);
                },
              ),
      ),
    );
  }

  Widget tileCard(Size size, int index, Map map) {
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
              minLeadingWidth: 10,
              horizontalTitleGap: 8,
              onTap: () {
                Provider.of<Controller>(context, listen: false)
                    .getDashboardDetails(context, map["branch_id"].toString(),
                        formattedDate.toString());
                DetailsSheet sheet = DetailsSheet();
                sheet.showBottomSheet(context, size, map["branch_name"],
                    map["branch_id"], formattedDate.toString());
              },
              leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.yellow,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  )),
              title: Text(
                map["branch_name"].toString().toUpperCase(),
                // "sjfjsfbjzfn znjfjzf fznfzjfbdf jhsfbjhfbdf fbjhfb",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                spacing: 18.0,
                runAlignment: WrapAlignment.center,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Container(
                  //   color: Colors.white,
                  //   height: 50,
                  //   width: 1,
                  // ),

                  Container(
                    child: Text(
                      map["branch_sale"].toString(),
                      // "23453678",
                      style: TextStyle(
                          fontSize: 18,
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
