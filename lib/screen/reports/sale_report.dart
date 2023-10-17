import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/controller/controller.dart';

class SaleReport extends StatefulWidget {
  String brId;
  String brName;
  SaleReport({required this.brId, required this.brName});

  @override
  State<SaleReport> createState() => _SaleReportState();
}

class _SaleReportState extends State<SaleReport> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String formattedDate = DateFormat('yyyy-MM').format(now);
    Provider.of<Controller>(context, listen: false)
        .getSaleReport(context, widget.brId.toString(), formattedDate);
  }

  DateTime now = DateTime.now();
  DateTime? _selected;
  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary:
                    Color.fromARGB(255, 54, 51, 51), // header background color
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
            child: child!);
      },
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
        print("selected-0----$_selected");
        String formattedDate = DateFormat('yyyy-MM').format(_selected!);
        Provider.of<Controller>(context, listen: false)
            .getSaleReport(context, widget.brId.toString(), formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          title: Text(
            "SMan report  ( ${widget.brName} )",
            style: TextStyle(fontSize: 13,color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 54, 51, 51),
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            InkWell(
              // onTap: () => _onPressed(context: context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_selected == null)
                    Text(
                      DateFormat().add_yM().format(now),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )
                  else
                    Text(
                      DateFormat().add_yM().format(_selected!),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  IconButton(
                      onPressed: () => _onPressed(context: context),
                      icon: Icon(Icons.date_range_outlined))
                  // onPressed: () => _onPressed(context: context),
                  // Icon(Icons.date_range_outlined)
                  // TextButton(
                  //   child: const Text('DEFAULT LOCALE'),
                  //   onPressed: () => _onPressed(context: context),
                  // ),
                ],
              ),
            ),
            Consumer<Controller>(
              builder: (context, value, child) => value.isLoading
                  ? Container(
                      height: size.height * 0.7,
                      child: Center(
                        child: SpinKitCircle(
                          color: Color.fromARGB(255, 54, 51, 51),
                        ),
                      ),
                    )
                  : value.sale_report_list.length == 0
                      ? Container(
                          height: size.height * 0.7,
                          child: Center(
                            child: Lottie.asset("assets/nodata.json",
                                height: size.height * 0.27),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemCount: value.sale_report_list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  // side: BorderSide(color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.red[400],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15))),
                                      child: Center(
                                          child: Text(
                                        value.sale_report_list[index]
                                                ["staff_name"]
                                            .toString()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 17),
                                      )),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.007,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          top: 3,
                                          bottom: 3),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/money.png",
                                                height: size.height * 0.016,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.3,
                                                child: Text(
                                                  "Bill Total",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Text(
                                              ": \u{20B9}${value.sale_report_list[index]["bill_total"]}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          top: 3,
                                          bottom: 3),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/money.png",
                                                height: size.height * 0.016,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.3,
                                                child: Text(
                                                  "Incentive Amt",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Text(
                                              ": \u{20B9}${value.sale_report_list[index]["staff_total"]}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
            )
          ],
        ));
  }
}
