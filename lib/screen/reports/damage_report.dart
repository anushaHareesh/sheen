import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/screen/reports/report_table.dart';

import '../../components/date_find.dart';
import '../../controller/controller.dart';

class DamageCountReport extends StatefulWidget {
  const DamageCountReport({super.key});

  @override
  State<DamageCountReport> createState() => _DamageCountReportState();
}

class _DamageCountReportState extends State<DamageCountReport> {
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: Color.fromARGB(255, 54, 51, 51),
        elevation: 0,
        title: const Text(
          "Itemwise Report",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 3,
        ),
        child: Consumer<Controller>(
          builder: (context, value, child) => Column(
            children: [
              Container(
                height: size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              // String df;
                              // String tf;
                              dateFind.selectDateFind(context, "from date");
                              // if (value.fromDate == null) {
                              //   df = todaydate.toString();
                              // } else {
                              //   df = value.fromDate.toString();
                              // }
                              // if (value.todate == null) {
                              //   tf = todaydate.toString();
                              // } else {
                              //   tf = value.todate.toString();
                              // }
                              // Provider.of<Controller>(context, listen: false)
                              //     .historyData(context, splitted[0], "",
                              //         df, tf);
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              // color: P_Settings.loginPagetheme,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: Text(
                            value.fromDate == null
                                ? todaydate.toString()
                                : value.fromDate.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              dateFind.selectDateFind(context, "to date");
                            },
                            icon: Icon(Icons.calendar_month)),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            value.todate == null
                                ? todaydate.toString()
                                : value.todate.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Flexible(
                    //     child: Container(
                    //   height: size.height * 0.05,
                    //   child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         primary: P_Settings.loginPagetheme,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius:
                    //               BorderRadius.circular(2), // <-- Radius
                    //         ),
                    //       ),
                    //       onPressed: () {
                    //         String df;
                    //         String tf;

                    //         if (value.fromDate == null) {
                    //           df = todaydate.toString();
                    //         } else {
                    //           df = value.fromDate.toString();
                    //         }
                    //         if (value.todate == null) {
                    //           tf = todaydate.toString();
                    //         } else {
                    //           tf = value.todate.toString();
                    //         }

                    //       },
                    //       child: Text(
                    //         "Apply",
                    //         style: GoogleFonts.aBeeZee(
                    //           textStyle: Theme.of(context).textTheme.bodyText2,
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.bold,
                    //           // color: P_Settings.whiteColor,
                    //         ),
                    //       )),
                    // ))
                  ],
                ),
                // dropDownCustom(size,""),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Text(
                    "Select a Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 2, right: 2, top: 12),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 163, 163, 163)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        // value: selected,
                        // isDense: true,
                        hint: Text(
                          value.catSelected == null
                              ? "All"
                              : value.catSelected!,
                          style: TextStyle(fontSize: 14),
                        ),
                        isExpanded: true,
                        autofocus: false,
                        underline: SizedBox(),
                        elevation: 0,
                        items: value.category_list
                            .map((item) => DropdownMenuItem<String>(
                                value: item["cat_id"].toString(),
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Text(
                                    item["cat_name"].toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          print("clicked");
                          if (item != null) {
                            print("clicked------$item");
                            // value.areaId = item;
                            Provider.of<Controller>(context, listen: false)
                                .setDropdowndata(item);
                            Provider.of<Controller>(context, listen: false)
                                .getItemwisereport(
                              context,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: size.height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () {},
                        child: Text("APPLY")),
                  ))
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // SizedBox(height: size.height * 0.02),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: size.width * 0.01,
              //     ),
              //     Text(
              //       "Select a Category",
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Flex(direction: Axis.vertical, children: [
              //   Container(
              //     margin: EdgeInsets.only(left: 2, right: 2, top: 12),
              //     decoration: BoxDecoration(
              //       border:
              //           Border.all(color: Color.fromARGB(255, 163, 163, 163)),
              //       borderRadius: BorderRadius.circular(3),
              //     ),
              //     // width: size.width * 0.4,
              //     height: size.height * 0.05,

              //     child: ButtonTheme(
              //       alignedDropdown: true,
              //       child: DropdownButton<String>(
              //         // value: selected,
              //         // isDense: true,
              //         hint: Text(
              //           value.catSelected == null ? "All" : value.catSelected!,
              //           style: TextStyle(fontSize: 14),
              //         ),
              //         isExpanded: true,
              //         autofocus: false,
              //         underline: SizedBox(),
              //         elevation: 0,
              //         items: value.category_list
              //             .map((item) => DropdownMenuItem<String>(
              //                 value: item["cat_id"].toString(),
              //                 child: Container(
              //                   width: size.width * 0.4,
              //                   child: Text(
              //                     item["cat_name"].toString(),
              //                     style: TextStyle(fontSize: 14),
              //                   ),
              //                 )))
              //             .toList(),
              //         onChanged: (item) {
              //           print("clicked");
              //           if (item != null) {
              //             print("clicked------$item");
              //             // value.areaId = item;
              //             Provider.of<Controller>(context, listen: false)
              //                 .setDropdowndata(item);
              //             Provider.of<Controller>(context, listen: false)
              //                 .getItemwisereport(
              //               context,
              //             );
              //           }
              //         },
              //       ),
              //     ),
              //   ),
              // ]),
              SizedBox(height: size.height * 0.02),
              ReportTable(
                list: value.damage_report_list,
              )
            ],
          ),
        ),
      ),
    );
  }
}
