import 'package:firstapp/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'graph_content/con_2.dart';
import "graph_content/con_3.dart";
import 'graph_content/con_4.dart';
import 'graph_content/con_1.dart';

class layout extends StatefulWidget {
  layout({Key? key}) : super(key: key);
  List<dynamic> week = [];
  List<dynamic>? f = [];
  List<dynamic>? r = [];
  List<dynamic>? d = [];
  List<dynamic>? a = [];
  List<dynamic>? l1 = [];
  List<dynamic>? l2 = [];
  List<dynamic>? l3 = [];
  List<dynamic>? l4 = [];
  String? result_2;
  @override
  State<layout> createState() => _layoutState();
}

class _layoutState extends State<layout> with TickerProviderStateMixin {
  TabController? _control;
  String? check = "load";
  String check_2="load";
  String? check_1 = "load";
  Object? value = "Week 1";
  String? result;
  String? check_3="load";
  List<dynamic>? ff = [];
  List<dynamic>? rr = [];
  List<dynamic>? dd = [];
  List<dynamic>? aa = [];
  List<dynamic>? l1 = [];
  List<dynamic>? l2 = [];
  List<dynamic>? l3 = [];
  List<dynamic>? l4 = [];
  GraphAll g_4 = GraphAll();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _control = TabController(length: 4, vsync: this);
    _control!.addListener(() async {
      var f=_control!.index;
      var d = ModalRoute.of(context)!.settings.arguments as Map;
      
      if (f == 1) {
        first(d);
      } else if (f == 2) {
        var resp = await api.Weeks(
            week: d["week"], sch: d["sch"], user: d["user"]);
        
          widget.result_2 = resp["result"];
          widget.f = resp["f"];
          widget.a = resp["a"];
          widget.d = resp["d"];
          widget.r = resp["r"];
          widget.l1 = resp["l1"];
          widget.l2 = resp["l2"];
          widget.l3 = resp["l3"];
          widget.l4 = resp["l4"];
          widget.week = resp["x"];
          
        
        setState(() {
            check_2 = "";
          });
      } else if (f == 3) {
        var resp = await api.all(
            week: d["week"], sch: d["sch"], user: d["user"]);
        print(resp);
        g_4.result = resp["result"];
        g_4.f = resp["f"];
        g_4.a = resp["a"];
        g_4.d = resp["d"];
        g_4.r = resp["r"];
        g_4.l1 = resp["l1"];
        g_4.l2 = resp["l2"];
        g_4.l3 = resp["l3"];
        g_4.l4 = resp["l4"];
        g_4.week = resp["x"];
        setState(() {
          check_3="";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    List<String> v =
        List.generate(int.parse(d["week"]), (int k) => "Week ${k + 1}");
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            SizedBox(
              height: h * .005,
            ),
            Row(
              children: [
                Text(
                  "Brain Fit Track",
                ),
                SizedBox(
                  width: w * .35,
                ),
                Container(
                    child: DropdownButton(
                        isExpanded: true,
                        items: v
                            .map((e) =>
                                DropdownMenuItem(child: Text(e), value: e))
                            .toList(),
                        value: value,
                        onChanged: (valu) async {
                          setState(() {
                            check = "load";
                            value = valu!;
                            first(d);
                          });
                        }),
                    width: w * .35,
                    height: h * .05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(h * .03)))
              ],
            ),
            SizedBox(
              height: h * 0.006,
            ),
            Expanded(
              child: Container(
                // ignore: sort_child_properties_last
                child: Column(children: [
                  TabBar(
                    indicator: ind(w, h),
                    indicatorColor: Colors.black,
                    isScrollable: true,
                    controller: _control,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    onTap: (int f) async {
                      if (f == 1) {
                        first(d);
                      } else if (f == 2) {
                        var resp = await api.Weeks(
                            week: d["week"], sch: d["sch"], user: d["user"]);
                        if (resp["result"] == "Done") {
                          widget.result_2 = resp["result"];
                          widget.f = resp["f"];
                          widget.a = resp["a"];
                          widget.d = resp["d"];
                          widget.r = resp["r"];
                          widget.l1 = resp["l1"];
                          widget.l2 = resp["l2"];
                          widget.l3 = resp["l3"];
                          widget.l4 = resp["l4"];
                          widget.week = resp["x"];
                          
                        }
                        setState(() {
                            check_2 = "";
                          });
                      } else if (f == 3) {
                        var resp = await api.all(
                            week: d["week"], sch: d["sch"], user: d["user"]);
                        
                        g_4.result = resp["result"];
                        g_4.f = resp["f"];
                        g_4.a = resp["a"];
                        g_4.d = resp["d"];
                        g_4.r = resp["r"];
                        g_4.l1 = resp["l1"];
                        g_4.l2 = resp["l2"];
                        g_4.l3 = resp["l3"];
                        g_4.l4 = resp["l4"];
                        g_4.week = resp["x"];
                        setState(() {
                          check_3="";
                        });
                      }
                    },
                    tabs: [
                      Tab(
                        child: Text("Today"),
                      ),
                      Tab(child: Text("Week")),
                      Tab(child: Text("4 weeks")),
                      Tab(
                        child: Text("All time"),
                      )
                    ],
                  ),
                  Container(
                    width: w,
                    height: h * .74,
                    child: TabBarView(controller: _control, children: [
                      GraphToday(
                          result: d["result_0"],
                          data_1: d["skill"],
                          data_2: d["level"]),
                      check == "load"
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ))
                          : GraphWeek(
                              result: result,
                              f: ff,
                              a: aa,
                              d: dd,
                              r: rr,
                              l1: l1,
                              l2: l2,
                              l3: l3,
                              l4: l4,
                            ),
                      check_2 == "load"
                          ? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ))
                          : GraphMon(
                              f: widget.f,
                              week: widget.week,
                              result: widget.result_2,
                              a: widget.a,
                              d: widget.d,
                              r: widget.r,
                              l1: widget.l1,
                              l2: widget.l2,
                              l3: widget.l3,
                              l4: widget.l4,
                            ),
                      check_3=="load"? Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            )):g_4
                    ]),
                  )
                ]),
                //height: h * .841,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w * 0.2),
                        topRight: Radius.circular(w * 0.2))),
              ),
            )
          ],
        ),
      ),
    );
  }

  first(Map d) async {
    print("ksjs");
    var resp =
        await api.Week(week: value.toString(), sch: d["sch"], user: d["user"]);

    if (resp["result"] == "Done") {
      ff = resp["f"];
      result = "Done";
      aa = resp["a"];
      dd = resp["d"];
      rr = resp["r"];
      l1 = resp["l1"];
      l2 = resp["l2"];
      l3 = resp["l3"];
      l4 = resp["l4"];
    } else {
      result = resp["result"];
    }
    setState(() {
      check = "";
    });
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
}

class ind extends Decoration {
  double w;
  double h;
  ind(this.w, this.h);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return box(w, h);
  }
}

class box extends BoxPainter {
  double w;
  double h;
  box(this.w, this.h);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration c) {
    Paint v = Paint()..color = Colors.black;
    canvas.drawCircle(
        Offset(offset.dx + c.size!.width / 2, c.size!.height - h * .016),
        w * 0.013,
        v);
  }
}

class ch {
  final double Number;
  final String Name;
  ch(this.Name, this.Number);
}
