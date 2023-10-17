import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheenbakery/controller/registration_controller.dart';
import 'package:sheenbakery/screen/authentication/login.dart';
import 'package:sheenbakery/screen/reports/damage_report.dart';

import 'package:sheenbakery/screen/reports/itemwise_report.dart';
import 'package:sheenbakery/screen/reports/peakwise_time_report.dart';
import 'package:sheenbakery/screen/reports/sale_report.dart';
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
  String? selectval;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<String> reports = ["Sale Report 123", "vbvbvnb"];
  void _onRefresh() async {
    formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    // await Future.delayed(const Duration(milliseconds: 1000));
    // ignore: use_build_context_synchronously
    Provider.of<Controller>(context, listen: false).geInitialization(
      context,
      formattedDate!,
    );
  }

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
                primary: Color.fromARGB(
                    255, 233, 204, 76), // header background color
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
      key: _key,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert,
                  color: Colors.white), // add this line
              itemBuilder: (_) => <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                        child: Container(
                            width: 100,
                            // height: 30,
                            child: const Text(
                              "Refresh",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 97, 97, 97),
                                  fontWeight: FontWeight.bold),
                            )),
                        value: 'refresh'),
                    PopupMenuItem<String>(
                        child: Container(
                            width: 100,
                            // height: 30,
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 245, 87, 76),
                                  fontWeight: FontWeight.bold),
                            )),
                        value: 'logout'),
                  ],
              onSelected: (index) async {
                switch (index) {
                  case 'logout':
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('st_uname');
                    await prefs.remove('st_pwd');
                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return LoginPage();
                        },
                      ),
                      (_) => false,
                    );
                    break;
                  case 'refresh':
                    _onRefresh();
                }
              })
        ],
        toolbarHeight: 90, // default is 56
        // toolbarOpacity: 0.5,
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
                            color: Color.fromARGB(255, 233, 204, 76),
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 54, 51, 51),
        elevation: 0,
      ),
      // drawer: Drawer(),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 54, 51, 51),
              ),
              child: Consumer<RegistrationController>(
                builder: (context, value, child) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              _key.currentState!.closeDrawer();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            "assets/man.png",
                            height: size.height * 0.07,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.016,
                        ),
                        Flexible(
                          child: Text(
                            value.userName.toString().toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            InkWell(
                onTap: () {
                  Provider.of<Controller>(context, listen: false).getCategory(
                    context,
                  );
                  Provider.of<Controller>(context, listen: false)
                      .getItemwisereport(
                    context,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemwiseReport()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.0, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 10,
                          //   backgroundColor: Colors.transparent,
                          //   backgroundImage: AssetImage(
                          //     "assets/item.png",
                          //   ),
                          // ),
                          Icon(
                            Icons.report,
                            size: 16,
                            color: Colors.green,
                          ),

                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            'Itemwise Report'.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_right, size: 37)
                    ],
                  ),
                )),
            Divider(
              height: 10,
            ),

            /////////////////////////////////////////////////////////////////////////////////
            InkWell(
              onTap: () {
                Provider.of<Controller>(context, listen: false).getCategory(
                  context,
                );
                Provider.of<Controller>(context, listen: false)
                    .getPeaktimeBranchwiseReport(
                  context,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeakwiseTimeReport()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timeline_outlined,
                          size: 16,
                          color: Colors.blue,
                        ),
                        // Image.asset(
                        //   "assets/time.png",
                        //   height: size.height * 0.02,
                        // ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'Peakwise Time Report'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right, size: 37)
                  ],
                ),
              ),
            ),
            ////////////////////////////////////////////////////////////////////////////////////
            Divider(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Provider.of<Controller>(context, listen: false).getCategory(
                  context,
                );
                Provider.of<Controller>(context, listen: false)
                    .getDamageCountReport(
                  context,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DamageCountReport()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.report_off_sharp,
                          size: 16,
                          color: Colors.red,
                        ),
                        // Image.asset(
                        //   "assets/damage.png",
                        //   height: size.height * 0.02,
                        // ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Text(
                          'Damage Count Report'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right, size: 37)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isDashLoading
            ? SpinKitCircle(
                color: Color.fromARGB(255, 54, 51, 51),
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
        color: Colors.grey[100],
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
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<Controller>(context, listen: false)
                          .getDashboardDetails(
                              context,
                              map["branch_id"].toString(),
                              formattedDate.toString());
                      Provider.of<Controller>(context, listen: false)
                          .camtController
                          .clear();
                      // Provider.of<Controller>(context, listen: false).difference =
                      //     0.00;

                      DetailsSheet sheet = DetailsSheet();
                      sheet.showBottomSheet(context, size, map["branch_name"],
                          map["branch_id"], formattedDate.toString());
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    Color.fromARGB(255, 233, 204, 76),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Expanded(
                          // flex: 1,
                          // fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: map["branch_name"]
                                      .toString()
                                      .toUpperCase(),
                                  // text:
                                  //     "sjfjsfbjzfn znjfjzf fznfzjfbdf jhsfbjhfbdf fbjhfb fffff",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey[800]),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Last Sync : ",
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey[700]),
                                  ),
                                  Text(
                                    map["last_sync"],
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          map["branch_sale"].toString(),
                          // "23453678123",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   height: 25,
                      //   decoration: BoxDecoration(
                      //     // color: Color.fromARGB(255, 241, 182, 93),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child:

                      //    Padding(
                      //     padding: const EdgeInsets.only(left: 7.0),
                      //     // child:

                      //     //  DropdownButton(
                      //     //   style: TextStyle(color: Colors.black, fontSize: 12),
                      //     //   //Dropdown font color
                      //     //   dropdownColor: Colors
                      //     //       .grey[100], //dropdown menu background color
                      //     //   // icon: Icon(Icons.arrow_downward,
                      //     //   //     color: Colors.white), //dropdown indicator icon
                      //     //   underline: Container(), //make underline empty
                      //     //   value: selectval,
                      //     //   hint: Text(
                      //     //     "Select Report",
                      //     //     style:
                      //     //         TextStyle(color: Colors.black, fontSize: 12),
                      //     //   ),
                      //     //   onChanged: (value) {
                      //     //     // setState(() {
                      //     //     //   selectval = value.toString();
                      //     //     // });
                      //     //     Navigator.push(
                      //     //       context,
                      //     //       MaterialPageRoute(
                      //     //           builder: (context) => const SaleReport()),
                      //     //     );
                      //     //   },
                      //     //   items: reports.map((itemone) {
                      //     //     return DropdownMenuItem(
                      //     //         value: itemone, child: Text(itemone));
                      //     //   }).toList(),
                      //     // ),
                      //     // child: Text(
                      //     //   "Sale Report",
                      //     //   style: TextStyle(
                      //     //       color: Colors.grey[800],
                      //     //       fontWeight: FontWeight.w900,
                      //     //       fontSize: 13),
                      //     // ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          // Provider.of<Controller>(context, listen: false)
                          //     .getSaleReport(
                          //         context, map["branch_id"].toString(), "");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaleReport(
                                    brId: map["branch_id"].toString(),
                                    brName: map["branch_name"].toString())),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Sales (Sman) ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // Provider.of<Controller>(context, listen: false)
                      //     //     .getSaleReport(
                      //     //         context, map["branch_id"].toString(), "");
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               ConfirmationDetailsPage()),
                      //     );
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.blueAccent,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(6.0),
                      //       child: Text(
                      //         "Itemwise",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // Provider.of<Controller>(context, listen: false)
                      //     //     .getSaleReport(
                      //     //         context, map["branch_id"].toString(), "");
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => SaleReport(
                      //               brId: map["branch_id"].toString(),
                      //               brName: map["branch_name"].toString())),
                      //     );
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.blueAccent,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(6.0),
                      //       child: Text(
                      //         "Peakwise time",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // Provider.of<Controller>(context, listen: false)
                      //     //     .getSaleReport(
                      //     //         context, map["branch_id"].toString(), "");
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => SaleReport(
                      //               brId: map["branch_id"].toString(),
                      //               brName: map["branch_name"].toString())),
                      //     );
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.blueAccent,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(6.0),
                      //       child: Text(
                      //         "Damage",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              )

              // child:ListTile(
              //     minLeadingWidth: 10,
              //     horizontalTitleGap: 8,
              //     onTap: () {
              //       Provider.of<Controller>(context, listen: false)
              //           .getDashboardDetails(context, map["branch_id"].toString(),
              //               formattedDate.toString());
              //       Provider.of<Controller>(context, listen: false)
              //           .camtController
              //           .clear();
              //       // Provider.of<Controller>(context, listen: false).difference =
              //       //     0.00;

              //       DetailsSheet sheet = DetailsSheet();
              //       sheet.showBottomSheet(context, size, map["branch_name"],
              //           map["branch_id"], formattedDate.toString());
              //     },
              //     // dense: true,
              //     contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              //     leading: CircleAvatar(
              //         radius: 15,
              //         backgroundColor: Color.fromARGB(255, 233, 204, 76),
              //         child: Icon(
              //           Icons.person,
              //           color: Colors.black,
              //         )),
              //     title: Text(
              //       map["branch_name"].toString().toUpperCase(),
              //       // "sjfjsfbjzfn znjfjzf fznfzjfbdf jhsfbjhfbdf fbjhfb",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 13,
              //           color: Colors.grey[800]),
              //     ),
              //     subtitle: Column(
              //       children: [
              //         Row(
              //           children: [
              //             Text(
              //               "Last Sync : ",
              //               style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              //             ),
              //             Flexible(
              //                 child: Text(
              //               map["last_sync"],
              //               style: TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.grey[700],
              //                   fontWeight: FontWeight.bold),
              //             )),
              //           ],
              //         ),

              //       ],
              //     ),
              //     trailing: Wrap(
              //       alignment: WrapAlignment.center,
              //       spacing: 18.0,
              //       runAlignment: WrapAlignment.center,
              //       runSpacing: 8.0,
              //       crossAxisAlignment: WrapCrossAlignment.center,
              //       children: [
              //         // Container(
              //         //   color: Colors.white,
              //         //   height: 50,
              //         //   width: 1,
              //         // ),

              //         Container(
              //           child: Text(
              //             map["branch_sale"].toString(),
              //             // "23453678",
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Color.fromARGB(255, 14, 140, 243)),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              ),
        ),
      ),
    );
  }
}
