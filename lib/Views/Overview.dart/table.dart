import 'package:flutter/material.dart';
import 'package:firstapp/api.dart' as api;
class tab extends StatefulWidget {
  tab({Key? key}) : super(key: key);

  
  @override
  State<tab> createState() => _TabState();
}

class _TabState extends State<tab> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var d=ModalRoute.of(context)!.settings.arguments as Map;
    
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisSize: MainAxisSize.max,
              children: [
          SizedBox(
            height: h * .005,
          ),
          Text("Scores For Today's Helpful Skills"),
          Expanded(child: tab_gen(d["skill"])),
          Container(
              alignment: Alignment.bottomRight,
              child: Text("Total:${(d["skill"].length==0)? "--":d["skill"][0]+d["skill"][1]+d["skill"][2]+d["skill"][3]}"),
              //height: h * .02,
              width: w),
          SizedBox(
            height: h * .01,
          ),
          Text("Scores For Today's Unhelpful Behaviour"),
          Expanded(child: gen_lev(d["level"])),
          Container(
              alignment: Alignment.bottomRight,
              child: Text("Total:${(d["level"].length==0)? "--":d["level"][0]+d["level"][1]+d["level"][2]+d["level"][3]}"),
              height: h * .025,
              width: w),
              ],
            ),
        ));
  }
  
  DataTable gen_lev(List<dynamic> h) {
    if(h.length ==0){
    return DataTable(columns: [
          DataColumn(label: Text("level")),
          DataColumn(label: Text("Option")),
          DataColumn(label: Text("Score"))
        ], rows: [
          DataRow(cells: [
            DataCell(Text("Level1")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 2")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 3")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 4")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
        ]);}
    else{
      Map<dynamic,String> trans = {5:'All the time',4:'Most of the time',3:'Some of the time',1:'Once or twice',0:'Not at all'};
      return DataTable(columns: [
          DataColumn(label: Text("Skill")),
          DataColumn(label: Text("Option")),
          DataColumn(label: Text("Score"))
        ], rows: [
          DataRow(cells: [
            DataCell(Text("level 1")),
            DataCell(Text(trans[h[0]]!)),
            DataCell(Text("${h[0]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 2")),
            DataCell(Text(trans[h[1]/2]!)),
            DataCell(Text("${h[1]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 3")),
            DataCell(Text(trans[h[2]/3]!)),
            DataCell(Text("${h[2]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 4")),
            DataCell(Text(trans[h[3]/4]!)),
            DataCell(Text("${h[3]}"))
          ])
        ]); 
    }
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

  

  Widget tab_gen(List<dynamic> h) {
    if(h.length==0){
    return DataTable(columns: [
          DataColumn(label: Text("level")),
          DataColumn(label: Text("Option")),
          DataColumn(label: Text("Score"))
        ], rows: [
          DataRow(cells: [
            DataCell(Text("Level1")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 2")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 3")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
          DataRow(cells: [
            DataCell(Text("level 4")),
            DataCell(Text("--")),
            DataCell(Text("--"))
          ]),
        ]);}
    else{
      Map<dynamic,String> trans = {5:'All the time',4:'Most of the time',3:'Some of the time',1:'Once or twice',0:'Not at all'};
      return DataTable(columns: [
          DataColumn(label: Text("Skill")),
          DataColumn(label: Text("Option")),
          DataColumn(label: Text("Score"))
        ], rows: [
          DataRow(cells: [
            DataCell(Text("Flexible")),
            DataCell(Text(trans[h[0]]!)),
            DataCell(Text("${h[0]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("Regulate")),
            DataCell(Text(trans[h[1]]!)),
            DataCell(Text("${h[1]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("Deliberate")),
            DataCell(Text(trans[h[2]]!)),
            DataCell(Text("${h[2]}"))
          ]),
          DataRow(cells: [
            DataCell(Text("Attentive")),
            DataCell(Text(trans[h[3]]!)),
            DataCell(Text("${h[3]}"))
          ])
        ]);}
    }
  }

