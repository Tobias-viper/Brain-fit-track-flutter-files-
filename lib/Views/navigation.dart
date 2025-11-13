import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'data/tabsl.dart';
import 'package:firstapp/api.dart' as api;
import 'settings.dart';
import 'Overview.dart/table.dart';
import 'Overview.dart/graph.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);
  int index = 0;

  List<int> skill = [];
  List<int> level = [];
  List<dynamic> Screen = [Tabsl(), tab(), layout(), Setting()];

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
        child: Scaffold(
            body: widget.Screen[widget.index],
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Container(
              child: GNav(
                  padding: EdgeInsets.only(
                      left: w * .03,
                      top: h * .02,
                      right: w * .03,
                      bottom: h * .02),
                  //backgroundColor:Colors.black,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.black,
                  selectedIndex: widget.index,
                  onTabChange: (inde) async {
                    if (inde == 1) {
                      show();
                      var rev = await api.table_data(
                          week: d["week"], sch: d["sch"], user: d["user"]);
                      
                      if (rev["result"] == "Done") {
                        d["skill"] = rev["skill"];
                        d["level"] = rev["level"];
                        Navigator.pop(context);
                      } else if (rev["result"] == "No Internet Connection") {
                        scaf("No Internet Connection");
                        d["skill"] = rev["skill"];
                        d["level"] = rev["level"];
                        Navigator.pop(context);
                      } else {
                        d["skill"] = rev["skill"];
                        d["level"] = rev["level"];
                        Navigator.pop(context);
                      }
                    } else if (inde == 2) {
                      if (d["0"] == false) {
                        show();
                        
                        var rev = await api.table_data(
                            week: d["week"], sch: d["sch"], user: d["user"]);
                        
                        d["skill"] = rev["skill"];
                        d["level"] = rev["level"];
                        d["result_0"] = rev["result"];
                        rev["skill"].length == 4 && rev["level"].length == 4
                            ? d["0"] = true
                            : "";
                        Navigator.pop(context);
                      }
                    }
                    setState(() {
                      widget.index = inde;
                    });
                  },
                  tabs: [
                    GButton(
                      icon: Icons.book_sharp,
                      text: 'Data Entry',
                    ),
                    GButton(icon: Icons.all_inbox, text: 'Overall'),
                    GButton(icon: Icons.auto_graph, text: 'Graph'),
                    GButton(icon: Icons.settings, text: 'Settings')
                  ]),
            )));
  }

  Future<dynamic> show() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          );
        });
  }

  scaf(String text) {
    
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(dismissDirection: DismissDirection.up, content: Text(text)));
  }
}
