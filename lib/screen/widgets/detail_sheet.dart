import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/screen/damage_screen.dart';

import '../../controller/controller.dart';

class DetailsSheet {
  Future<void> showBottomSheet(BuildContext context, Size size, String br_name,
      String br_id, String date) async {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Consumer<Controller>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: value.isDashDataLoading
                ? Center(
                    child: Container(
                        height: size.height * 0.2,
                        child: Center(
                            child: SpinKitCircle(
                          color: Color.fromARGB(255, 54, 51, 51),
                        ))))
                : Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 23,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    br_name.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.007,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "( ${date} )",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Divider(),
                          value.sale_data.length == 0
                              ? Lottie.asset("assets/nodata.json",
                                  height: size.height * 0.3)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.sale_data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              value.sale_data[index]["pay_mode"]
                                                  .toString()
                                                  .toUpperCase(),
                                              // "dknskjfnszkf sfnjd f zdfjknzsdkjf zsdfzsjnfzs fszj",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 13,
                                                // color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                // color: P_Settings.loginPagetheme,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\u{20B9}${value.sale_data[index]["p_amount"].toString()}",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              // color: P_Settings.loginPagetheme,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                    // return ListTile(
                                    //   visualDensity: VisualDensity(
                                    //       horizontal: 0, vertical: -4),
                                    //   title: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Flexible(
                                    //         child: Text(
                                    //           value.sale_data[index]["pay_mode"]
                                    //               .toString()
                                    //               .toUpperCase(),
                                    //           // "dknskjfnszkf sfnjd f zdfjknzsdkjf zsdfzsjnfzs fszj",
                                    //           style: GoogleFonts.aBeeZee(
                                    //             textStyle: Theme.of(context)
                                    //                 .textTheme
                                    //                 .bodyText2,
                                    //             fontSize: 12,
                                    //             // color: Colors.green,
                                    //             fontWeight: FontWeight.bold,
                                    //             // color: P_Settings.loginPagetheme,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         "\u{20B9}${value.sale_data[index]["p_amount"].toString()}",
                                    //         style: GoogleFonts.aBeeZee(
                                    //           textStyle: Theme.of(context)
                                    //               .textTheme
                                    //               .bodyText2,
                                    //           fontSize: 13,
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.bold,
                                    //           // color: P_Settings.loginPagetheme,
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // );
                                  },
                                ),
                          Divider(),
                          value.sale_data.length == 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Total".toString(),
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\u{20B9}${value.sum.toStringAsFixed(2)}",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.last_s_dt == "null"
                              ? Container()
                              : Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  height: size.height * 0.05,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14.0, right: 14),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Last Sync ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(" : "),
                                        Text(
                                          value.last_s_dt.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                          value.sale_data.length == 0 ? Container() : Divider(),
                          value.total_csh == 0.00
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Total Cash",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\u{20B9}${value.total_csh.toStringAsFixed(2)}",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          value.coll_data.length == 0
                              ? Container()
                              : SizedBox(
                                  height: size.height * 0.014,
                                ),
                          value.coll_data.length == 0
                              ? Container()
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0, right: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Previously Collected",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              // color: P_Settings.loginPagetheme,
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .saveCollection(
                                                        context,
                                                        br_id,
                                                        date,
                                                        value.camtController
                                                            .text,
                                                        value.difference
                                                            .toString(),
                                                        "1");
                                              },
                                              child: Icon(Icons.delete,
                                                  color: Colors.red, size: 18)),
                                          // Spacer(),
                                          Text(
                                            value.coll_data.isEmpty
                                                ? "0.00"
                                                : "\u{20B9}${value.coll_data[0]["prev_clt"]}",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              // color: P_Settings.loginPagetheme,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.total_csh == 0.00
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Collection Amount",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                          height: size.height * 0.04,
                                          width: size.width * 0.25,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: value.camtController,
                                            onChanged: (val) {
                                              if (val.isNotEmpty) {
                                                if (value.coll_data.isEmpty) {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .calculateDifference(
                                                          value.total_csh,
                                                          0.00,
                                                          double.parse(val));
                                                } else {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .calculateDifference(
                                                          value.total_csh,
                                                          double.parse(
                                                              value.coll_data[0]
                                                                  ["prev_clt"]),
                                                          double.parse(val));
                                                }
                                              } else {
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .calculateDifference(
                                                        value.total_csh,
                                                        double.parse(
                                                            value.coll_data[0]
                                                                ["prev_clt"]),
                                                        0);
                                              }

                                              // double diff =
                                              //     d - double.parse(val);
                                              // print("diff----$diff");
                                            },
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 18),
                                          ))
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.total_csh == 0.00
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Difference",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\u{20B9}${value.difference.toStringAsFixed(2)}",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 15,
                                          color: value.difference < 0
                                              ? Colors.green
                                              : Colors.red,
                                          fontWeight: FontWeight.bold,
                                          // color: P_Settings.loginPagetheme,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          value.dmg_count == 0
                              ? value.sale_data.length == 0
                                  ? Container()
                                  : Container(
                                      width: size.width * 0.42,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: value.isSaveLoading
                                                  ? Colors.green
                                                  : Colors.yellow),
                                          onPressed: () {
                                            if (value.camtController.text
                                                .isNotEmpty) {
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .saveCollection(
                                                      context,
                                                      br_id,
                                                      date,
                                                      value.camtController.text,
                                                      value.difference
                                                          .toString(),
                                                      "0");
                                            }
                                          },
                                          child: Text(
                                            value.isSaveLoading
                                                ? "Loading...."
                                                : "UPDATE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                    )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    value.sale_data.length == 0
                                        ? Container()
                                        : Container(
                                            width: size.width * 0.42,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: value.isSaveLoading
                                                        ? Colors.green
                                                        : Colors.yellow),
                                                onPressed: () {
                                                  print("cz cnz cz-----");
                                                  if (value.camtController.text
                                                      .isNotEmpty) {
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .saveCollection(
                                                            context,
                                                            br_id,
                                                            date,
                                                            value.camtController
                                                                .text,
                                                            value.difference
                                                                .toString(),
                                                            "0");
                                                  }
                                                },
                                                child: Text(
                                                  value.isSaveLoading
                                                      ? "Loading...."
                                                      : "UPDATE",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Container(
                                      width: size.width * 0.42,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.black),
                                          onPressed: () {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getDamageData(
                                                    context, br_id, date);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DamageScreen(
                                                        brName: br_name,
                                                      )),
                                            );
                                          },
                                          child: Text(
                                            "DAMAGE (${value.dmg_count})",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
          );
        });
      },
    );
  }
}
