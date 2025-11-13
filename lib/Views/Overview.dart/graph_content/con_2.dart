import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class GraphWeek extends StatefulWidget {
  GraphWeek({Key? key,this.result,this.f,this.r,this.d,this.a,this.l1,this.l2,this.l3,this.l4}) : super(key: key);
  String? result;
  List<dynamic>? f=[];
  List<dynamic>? r=[];
  List<dynamic>? d=[];
  List<dynamic>? a=[];
  List<dynamic>? l1=[];
  List<dynamic>? l2=[];
  List<dynamic>? l3=[];
  List<dynamic>? l4=[];

  @override
  State<GraphWeek> createState() => _GraphWeekState();
}

class _GraphWeekState extends State<GraphWeek> {
  List<String> x_axis = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
  List<String> n =["Flexible","Regulated","Deliberate","Attentive","Level 1","Level 2","Level 3","Level 4"];
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    
    if(widget.result=="Done"){
      List<ch> _child_1 =[];
      List<ch> _child_2 =[];
      List<ch> _child_3 =[];
      List<ch> _child_4 =[];
      List<ch> _child_5 =[];
      List<ch> _child_6 =[];
      List<ch> _child_7 =[];
      List<ch> _child_8 =[];
      List<List<ch>> _child=[];
      for(int i=0;i<7;i++){
        _child_1.add(ch(x_axis[i],widget.f![i]));
        _child_2.add(ch(x_axis[i],widget.r![i]));
        _child_3.add(ch(x_axis[i],widget.d![i]));
        _child_4.add(ch(x_axis[i],widget.a![i]));
        _child_5.add(ch(x_axis[i],widget.l1![i]));
        _child_6.add(ch(x_axis[i],widget.l2![i]));
        _child_7.add(ch(x_axis[i],widget.l3![i]));
        _child_8.add(ch(x_axis[i],widget.l4![i]));
      }
      _child.add(_child_1);
      _child.add(_child_2);
      _child.add(_child_3);
      _child.add(_child_4);
      _child.add(_child_5);
      _child.add(_child_6);
      _child.add(_child_7);
      _child.add(_child_8);
    
      return ListView.builder(itemCount:8,itemBuilder:(context,int i){
          return Container(
            height:h*.65,
            child:SfCartesianChart(
                      title:ChartTitle(text:n[i]),
                      primaryXAxis:CategoryAxis(title:AxisTitle(text:"Days of the week")),
                      primaryYAxis:NumericAxis(title:AxisTitle(text:"points")),
                      series: [
                        LineSeries(
                            dataSource: _child[i],
                            xValueMapper:(ch j,_)=>j.Name,
                            yValueMapper:(ch j,_)=>j.Number)
                      ],
                    ));

        });

    }
    else{
      
      return Center(child: Text(widget.result.toString()));
    }
  }
}

class ch {
  int Number;
  String Name;
  ch(this.Name, this.Number);
}
