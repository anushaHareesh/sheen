import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/controller/controller.dart';

class ReportTable extends StatefulWidget {
  List<Map<String,dynamic>> list=[];
  ReportTable({required this.list});
  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
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

  Widget myDiveider() {
    return const VerticalDivider(
      color: Colors.grey,
    );
  }

  // final appPrimary = Colors.purple;

  TextStyle headerTextStyle = const TextStyle(
      color: Colors.green, fontSize: 13.7, fontWeight: FontWeight.bold);

  TextStyle lableTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 13.2,
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, value, child) => Row(
        children: [
          Consumer<Controller>(
            builder: (context, value, child) => DataTable(
                horizontalMargin: 10,
                headingRowHeight: 45,
                headingRowColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 252, 240, 137)),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey),
                  ),
                ),
                dataRowHeight: 40,
                columnSpacing: 8,
                dividerThickness: 1.0,
                columns: getColumn(
                  value.fisttableHeader,
                ),
                rows:
                    getRows(widget.list, value.fisttableHeader)),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  dividerThickness: 1.0,
                  horizontalMargin: 10,
                  headingRowHeight: 45,
                  headingTextStyle:
                      TextStyle(color: Colors.white, fontSize: 13),
                  headingRowColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 87, 170, 238)),
                  border: TableBorder(
                    verticalInside: BorderSide(
                        color: Color.fromARGB(255, 214, 214, 214), width: 0.7),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                    ),
                  ),
                  dataRowHeight: 40,
                  columnSpacing: 18,
                  // dividerThickness: 0,
                  columns: getColumn(value.secndtablHeader),
                  rows: getRows(
                      widget.list, value.secndtablHeader)),
            ),
          )
        ],
      ),
    );
  }

  List<DataColumn> getColumn(List list) {
    List<DataColumn> tableColmn = [];
    print("listt-----${list}");
    for (int i = 0; i < list.length; i++) {
      tableColmn.add(DataColumn(
          label: Text(
        list[i],
        style: TextStyle(fontWeight: FontWeight.bold),
      )));
    }
    return tableColmn;
  }

/////////////////////////////////////////////////////////////////////////////////
  List<DataRow> getRows(List<Map<String, dynamic>> listmap, List header) {
    List<DataRow> items = [];
    for (int i = 0; i < listmap.length; i++) {
      items.add(DataRow(cells: getCelle(listmap[i], header)));
    }
    return items;
  }

///////////////////////////////////////////////////////////////////////////////////
  List<DataCell> getCelle(Map<dynamic, dynamic> data, List header) {
    print("data--$data");
    List<DataCell> datacell = [];
    for (var i = 0; i < header.length; i++) {
      data.forEach((key, value) {
        if (header[i].toString().toLowerCase() ==
            key.toString().toLowerCase()) {
          datacell.add(
            DataCell(
              Container(
                // height: 50.0, width: 100.0,
                // decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 141, 139, 139))),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
    return datacell;
  }

/////////////////////////////////////////////////////////////////////
  // getfirstCol(Map<String, dynamic> row) {
  //   print("roww----$row");
  //   List<DataCell> datacell = [];
  //   for (var i = 0; i < tableHeader.length; i++) {
  //     row.forEach((key, value) {
  //       if (tableHeader[i].toString().toLowerCase() == key.toLowerCase()) {
  //         datacell.add(
  //           DataCell(Text(value)),
  //         );
  //       }
  //     });
  //   }
  //   return datacell;
  // }
}
