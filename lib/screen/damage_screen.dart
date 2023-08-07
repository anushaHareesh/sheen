import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sheenbakery/controller/controller.dart';

class DamageScreen extends StatefulWidget {
  String brName;
  DamageScreen({required this.brName});

  @override
  State<DamageScreen> createState() => _DamageScreenState();
}

class _DamageScreenState extends State<DamageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 45, 45),
        elevation: 0,
        title: Text(
          widget.brName.toString().toUpperCase(),
          style: TextStyle(color: Colors.yellow, fontSize: 17),
        ),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.isLoading
            ? SpinKitCircle(
                color: Colors.black,
              )
            : ListView.builder(
                itemCount: value.damage_list.length,
                itemBuilder: (context, index) {
                  return Card(
                    // color: Color.fromARGB(255, 46, 45, 45),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage("assets/noimg.png"),
                      ),
                      title: Text(
                        value.damage_list[index]["p_name"]
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "Qty   :   ",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            value.damage_list[index]["qty"],
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
