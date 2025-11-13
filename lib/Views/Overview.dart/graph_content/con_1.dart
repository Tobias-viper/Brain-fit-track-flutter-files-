import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class GraphToday extends StatefulWidget {
  String? result;
  List<dynamic>? data_1=[];
  List<dynamic>? data_2=[]; 
  GraphToday({Key? key,this.result,this.data_1,this.data_2}) : super(key: key);

  @override
  State<GraphToday> createState() => _GraphTodayState();
}

class _GraphTodayState extends State<GraphToday> {

  List<String> skill=["Flexible","Regulate","Deliberate","Attentive"];
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.height; 
    if(widget.result=="No Internet Connection"){
      
      return Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.wifi_off),
          Text("No data connection")
        ],)
      );
  
    }
    else if(widget.result=="Done" && widget.data_1!.length==0 && widget.data_2!.length==0){
      return Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(child: Text("Make sure you fill both helpful and unhelpful\nbehaviour"))
        ],)
      );
    }
    else{
      if(widget.data_1!.length !=0 && widget.data_2!.length !=0){
        List<ch> _child_1 =[];
        List<ch> _child_2=[];
        List<List<ch>> _child=[];
        for(int i=0;i<4;i++){
          _child_1.add(ch(skill[i],widget.data_1![i]));
          _child_2.add(ch("level ${i+1}",widget.data_2![i]));

        }
        _child.add(_child_1);
        _child.add(_child_2);

        return ListView.builder(itemCount:2,itemBuilder:(context,int k){
          return Container(
            
            child:SfCartesianChart(
                      primaryXAxis:CategoryAxis(),
                    
                      series: [
                        ColumnSeries(
                            dataSource: _child[k],
                            xValueMapper:(ch j,_)=>j.Name,
                            yValueMapper:(ch j,_)=>j.Number)
                      ],
                    ));

        });
      }
      else if(widget.data_1!.length ==0 && widget.data_2!.length !=0){
        
        List<ch> _child_2=[];
        List<List<ch>> _child=[];
        for(int i=0;i<4;i++){
          
          _child_2.add(ch("level ${i+1}",widget.data_2![i]));

        }
        _child.add(_child_2);
        return ListView.builder(itemCount:1,itemBuilder:(context,int i){
          return Container(
            child:SfCartesianChart(
                      primaryXAxis:CategoryAxis(),
                      primaryYAxis:NumericAxis(),
                      series: [
                        ColumnSeries(
                            dataSource: _child[0],
                            xValueMapper:(ch j,_)=>j.Name,
                            yValueMapper:(ch j,_)=>j.Number,
                            dataLabelSettings:DataLabelSettings(
                              isVisible: true,
                              labelAlignment:ChartDataLabelAlignment.middle
                              
                            )
                            )
                      ],
                    ));

        });
        
      }
      else{
        List<ch> _child_1 =[];
        List<List<ch>> _child=[];
        for(int i=0;i<4;i++){
          _child_1.add(ch(skill[i],widget.data_1![i]));
        }
        _child.add(_child_1);
        
        return ListView.builder(itemCount:1,itemBuilder:(context,int i){
          return Container(
            
            child:SfCartesianChart(
                      primaryXAxis:CategoryAxis(),
                    
                      series: [
                        ColumnSeries(
                            dataSource: _child[0],
                            xValueMapper:(ch j,_)=>j.Name,
                            yValueMapper:(ch j,_)=>j.Number)
                      ],
                    ));

        });
        
      }

    }
  }
}

class ch {
  final int Number;
  final String Name;
  ch(this.Name, this.Number);
}
