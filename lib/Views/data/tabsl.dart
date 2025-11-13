import 'dart:convert';
import 'package:firstapp/Views/navigation.dart';
import 'package:flutter/material.dart';
import 'skill.dart';
import 'level.dart';

class Tabsl extends StatefulWidget {
  Tabsl({Key? key}) : super(key: key);

  String? Name;
  bool? first;//this is to tell if the child has filled any skill or unhelpful 
  bool? second;
  String? week;
  String? sch;

  @override
  State<Tabsl> createState() => _TabslState();
}

class _TabslState extends State<Tabsl> with TickerProviderStateMixin {
  TabController? _tab;
  Color color = Colors.blue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    //var m = ModalRoute.of(context)!.settings.arguments;
    //print(m);
  }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(child: 
      Scaffold(
        resizeToAvoidBottomInset:false,
        body:Column(
          children: [
            SizedBox(height:h*.04,),
            Row(
              
              children: [  
                SizedBox(width:w*.03,),
                Text('Welcome ${d['Name']}',style:TextStyle(fontStyle:FontStyle.italic,fontWeight:FontWeight.w400,fontSize:w*0.07),),
              ],
            ),
            SizedBox(height:h*.01,),
            TabBar(
              isScrollable: true,
              labelColor:Colors.black,
              unselectedLabelColor:Colors.grey,
              controller: _tab,
              indicator:Line(w:w,h:h,color:color),
              onTap:(int k){
                var m = ModalRoute.of(context)!.settings.arguments;           
                if (k==1){
                 setState((){color=Colors.redAccent;}); 
                }
                else{
                  setState((){color=Colors.blueAccent;});
                }
              },
              tabs:
              [
                Tab(child:Text("Helpful-Skills")),
                Tab(text:'Unhelpful-Behaviours',)
              ],),
            SizedBox(height:h*0.03,),
            Container(
              width:w,
              height:h*.685,
              child: TabBarView(
                controller:_tab,
                children: [
                Skill(),
                Level()
              ],),
            )

          ],
        ) 
      ,   
      )    
    );
    
  }
}

class Line extends Decoration{
  double w;
  double h;
  Color color;

  Line({required this.color,required this.w,required this.h});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return Ind(w:w,h:h,color:color);
  }

}

class Ind extends BoxPainter{
  double w;
  Color color;
  double h;
  Ind({required this.color,required this.w,required this.h});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration c) {
    var paint = Paint()..color=color..strokeCap=StrokeCap.round..strokeWidth=w*0.009;
    canvas.drawLine(Offset(offset.dx+c.size!.width/2-w*.03,c.size!.height/2+h*0.02),Offset((offset.dx+c.size!.width/2+w*.03),c.size!.height/2+h*.02),paint);
  }

} 

