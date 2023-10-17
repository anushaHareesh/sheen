import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:lottie/lottie.dart";
import "package:provider/provider.dart";
import "package:sheenbakery/controller/controller.dart";
import "package:sheenbakery/screen/reports/report_table.dart";

import "../../components/date_find.dart";

class ItemwiseReport extends StatefulWidget {
  const ItemwiseReport({super.key});

  @override
  State<ItemwiseReport> createState() => _ItemwiseReportState();
}

class _ItemwiseReportState extends State<ItemwiseReport> {
  DateFind dateFind = DateFind();
  String? todaydate;
  DateTime now = DateTime.now();
  String? selected;
  Widget myDiveider() {
    return const VerticalDivider(
      color: Colors.grey,
    );
  }

  final appPrimary = Colors.purple;

  TextStyle headerTextStyle = const TextStyle(
      color: Colors.green, fontSize: 13.7, fontWeight: FontWeight.bold);

  TextStyle lableTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.2,
  );
  // List tableHeader = ["Item"];

  // List secndtablHeader = [
  //   "Br1",
  //   "Br2",
  //   "Br3",
  //   "Br4",
  //   "Br5",
  //   "Br6",
  //   "Br7",
  //   "Br8"
  // ];

  // List<Map<String, dynamic>> empl = [
  //   {
  //     "Item": "item2bfff ffffff",
  //     'br1': "1000",
  //     "Br2": "200",
  //     "Br3": "100000",
  //     "Br4": "345",
  //     "Br5": "567",
  //     "Br6": "1233",
  //     'Br7': "345",
  //     "Br8": "456",
  //   },
  //   {
  //     "Item": "item1",
  //     'br1': "2300",
  //     "Br2": "3211",
  //     "Br3": "100000",
  //     "Br4": "22",
  //     "Br5": "222",
  //     "Br6": "233",
  //     'Br7': "123",
  //     "Br8": "2222",
  //   },
  //   {
  //     "Item": "item3",
  //     'br1': "4500",
  //     "Br2": "3400",
  //     "Br3": "100000",
  //     "Br4": "999",
  //     "Br5": "999",
  //     "Br6": "9999",
  //     'Br7': "anu",
  //     "Br8": "manager",
  //   },
  //   {
  //     "Item": "item5",
  //     'Br1': "234",
  //     "Br2": "4322",
  //     "Br3": "100000",
  //     "Br4": "88",
  //     "Br5": "88",
  //     "Br6": "888",
  //     'Br7': "88",
  //     "Br8": "manager",
  //   },
  //   {
  //     "Item": "item8",
  //     'Br1': "2222",
  //     "Br2": "3333",
  //     "Br3": "100000",
  //     "Br4": "888",
  //     "Br5": "888",
  //     "Br6": "7777",
  //     'Br7': "777",
  //     "Br8": "6666",
  //   },
  //   {
  //     "Item": "item5",
  //     'Br1': "1234",
  //     "Br2": "2345",
  //     "Br3": "100000",
  //     "Br4": "1233",
  //     "Br5": "33333",
  //     "Br6": "444",
  //     'Br7': "5555",
  //     "Br8": "66",
  //   },
  // ];
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
                        value: selected, 
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
                                // value: item["cat_id"].toString(),
                                value: item["category"].toString(),
                                child: Container(
                                  width: size.width * 0.4,
                                  child: Text(
                                    item["category"].toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          print("clicked");
                          if (item != null) {
                            print("clicked------$item");
                            setState(() {
                              selected=item;
                            });
                            // value.areaId = item;
                            // Provider.of<Controller>(context, listen: false)
                            //     .setDropdowndata(item);
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
              // Row(
              //   children: [
              //     DataTable(
              //         horizontalMargin: 10,
              //         headingRowHeight: 45,
              //         headingRowColor: MaterialStateProperty.all(
              //             Color.fromARGB(255, 216, 234, 248)),
              //         decoration: BoxDecoration(
              //           border: Border(
              //             top: BorderSide(color: appPrimary.withOpacity(0.2)),
              //             right: BorderSide(color: appPrimary.withOpacity(0.2)),
              //             bottom:
              //                 BorderSide(color: appPrimary.withOpacity(0.2)),
              //             left: BorderSide(color: appPrimary.withOpacity(0.2)),
              //           ),
              //         ),
              //         dataRowHeight: 40,
              //         columnSpacing: 8,
              //         dividerThickness: 1.0,
              //         columns: getColumn(tableHeader),
              //         rows: empl
              //             .map((e) => DataRow(cells: getfirstCol(e)))
              //             .toList()),
              //     Expanded(
              //       child: SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: DataTable(
              //             dividerThickness: 1.0,
              //             horizontalMargin: 10,
              //             headingRowHeight: 45,
              //             headingRowColor: MaterialStateProperty.all(
              //                 Color.fromARGB(255, 216, 234, 248)),
              //             border: TableBorder(
              //               verticalInside: BorderSide(
              //                   color: Color.fromARGB(255, 214, 214, 214),
              //                   width: 0.7),
              //             ),
              //             decoration: BoxDecoration(
              //               border: Border(
              //                 top: BorderSide(
              //                     color: appPrimary.withOpacity(0.2)),
              //                 bottom: BorderSide(
              //                     color: appPrimary.withOpacity(0.2)),
              //                 right: BorderSide(
              //                     color: appPrimary.withOpacity(0.2)),
              //               ),
              //             ),
              //             dataRowHeight: 40,
              //             columnSpacing: 18,
              //             // dividerThickness: 0,
              //             columns: getColumn(secndtablHeader),
              //             rows: getRows(empl)),
              //       ),
              //     )
              //   ],
              // ),
              value.itemwise_report_list.length == 0
                  ? Container(
                      height: size.height * 0.6,
                      child: Center(
                        child: LottieBuilder.asset(
                          "assets/nodata.json",
                          height: size.height * 0.23,
                        ),
                      ),
                    )
                  : ReportTable(
                      list: value.itemwise_report_list,
                    )
            ],
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////
  // List<DataColumn> getColumn(List list) {
  //   List<DataColumn> tableColmn = [];
  //   print("listt-----${list}");
  //   for (int i = 0; i < list.length; i++) {
  //     tableColmn.add(DataColumn(
  //         label: Text(
  //       list[i],
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     )));
  //   }
  //   return tableColmn;
  // }

/////////////////////////////////////////////////////////////////////////////////
//   List<DataRow> getRows(List<Map<String, dynamic>> listmap) {
//     List<DataRow> items = [];
//     for (int i = 0; i < listmap.length; i++) {
//       items.add(DataRow(cells: getCelle(listmap[i])));
//     }
//     return items;
//   }

// ///////////////////////////////////////////////////////////////////////////////////
//   List<DataCell> getCelle(
//     Map<dynamic, dynamic> data,
//   ) {
//     print("data--$data");
//     List<DataCell> datacell = [];
//     for (var i = 0; i < secndtablHeader.length; i++) {
//       data.forEach((key, value) {
//         if (secndtablHeader[i].toString().toLowerCase() ==
//             key.toString().toLowerCase()) {
//           datacell.add(
//             DataCell(
//               Container(
//                 // height: 50.0, width: 100.0,
//                 // decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 141, 139, 139))),
//                 child: Padding(
//                   padding: EdgeInsets.all(0.0),
//                   child: Text(
//                     value,
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//       });
//     }
//     return datacell;
//   }

// /////////////////////////////////////////////////////////////////////
//   getfirstCol(Map<String, dynamic> row) {
//     print("roww----$row");
//     List<DataCell> datacell = [];
//     for (var i = 0; i < tableHeader.length; i++) {
//       row.forEach((key, value) {
//         if (tableHeader[i].toString().toLowerCase() == key.toLowerCase()) {
//           datacell.add(
//             DataCell(Text(value)),
//           );
//         }
//       });
//     }
//     return datacell;
//   }
}
