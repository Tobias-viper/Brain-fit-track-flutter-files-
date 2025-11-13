import 'package:firstapp/api.dart' as api;
import 'package:flutter/material.dart';

class Skill extends StatefulWidget {
  Skill({Key? key}) : super(key: key);

  

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  List<int> f = [-1,-1,-1,-1];
  List<String> dir = ['4.jpg','2.jpg','1.jpg','3.jpg'];
  List<String> text = ['How flexible were you today?','How regulated were you today?',"How deliberate were today?","How attentive were you today?"];
  
  
  @override
  Widget build(BuildContext context) {
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          shrinkWrap:true,
          itemCount:4,
          itemBuilder:(context,i){
          return Custom(Colors.green,user:d["user"],l_s:"s",sch:d["sch"],week:d['week'],active:d["first"],last:'green.jpg',k:f,w:i,key:ValueKey(i),directory:dir[i],text: text[i],); 
          }
        ),
      ),
    );
  }
}

class Custom extends StatefulWidget {
  List<int> k;
  int w;
  String directory;
  String user;
  String text;
  String sch;
  String l_s;//to tell if on the level or skill page
  String last;
  Color color;
  bool active;
  String week;
  Custom(this.color,{required this.user,required this.l_s,required this.sch,required this.week,required this.active,required this.last,required this.text,required this.directory,required this.w,required this.k,Key? key}) : super(key: key);
  
  
  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  
  @override
  Widget build(BuildContext context) {
    
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    
    return Column(
      children: [
        Image.asset('assets/${widget.directory}'),
        Text(widget.text,style:TextStyle(color: widget.color),),
        Row(children: [
          Container(width:w*.2,height:h*.1,child:Card(child:
          Radio<int>(activeColor:widget.color,value:0, groupValue:widget.k[widget.w], onChanged:(value){setState((){
            if(value! == widget.k[widget.w]){
              widget.k[widget.w] = -1;
            }
            else{
              widget.k[widget.w] =value;
            }
            });})
          ,elevation:10,shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),topRight:Radius.circular(20)))),),
          Container(width:w*.2,height:h*.1,child:Card(child:
          Radio<int>(activeColor:widget.color,value: 1, groupValue:widget.k[widget.w], onChanged:(value){setState((){widget.k[widget.w]=value!;});})
          ,elevation:10,shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),topRight:Radius.circular(20)))),),
          Container(width:w*.2,height:h*.1,child:Card(child:
          Radio<int>(activeColor:widget.color,value: 3, groupValue:widget.k[widget.w], onChanged:(value){setState((){widget.k[widget.w]=value!;});})
          ,elevation:10,shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),topRight:Radius.circular(20)))),),
          Container(width:w*.2,height:h*.1,child:Card(child:
          Radio<int>(activeColor:widget.color,value: 4, groupValue:widget.k[widget.w], onChanged:(value){setState((){widget.k[widget.w]=value!;});})
          ,elevation:10,shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),topRight:Radius.circular(20)))),),
          Container(width:w*.2,height:h*.1,child:Card(child:
          Radio<int>(value: 5,activeColor:widget.color, groupValue:widget.k[widget.w], onChanged:(value){setState((){widget.k[widget.w]=value!;});})
          ,elevation:10,shape:RoundedRectangleBorder(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),topRight:Radius.circular(20)))),),
        ],
        ),
      Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children:[
        Text("Not\nat\nall"),
        Text('Once\n   or \nTwice'),
        Text('Some\n  of\n  the\n time'),
        Text('Most\n  of\n  the\n time'),
        Text(' All\n the\n time')
        ]
      ),
      Image.asset('assets/${widget.last}'),
      widget.w ==3? ElevatedButton(child:Text("Submit",style:TextStyle(color:widget.color),),onPressed:(){
        if(widget.active==false){
          Pressed(w);
        }
        else{
          scaf( w,"You already filled this section today");
        }
        
        },):SizedBox()          
      ],
      
    );
    
  }

  void Pressed(double w) async {
    bool check = true;
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    for(int i =0;i<widget.k.length;i++){
      if(widget.k[i]==-1){
        check=false;
        break;
      }
    }
    if(check==true){
      //null;
      //pass to the backend
      showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child:CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            );});
      if(widget.l_s != "s"){
        for(int f=2;f<=4;f++){
          widget.k[f-1]=widget.k[f-1]*f;
        }
      }
      var send = await api.upload(week:widget.week,sch:widget.sch,l_s:widget.l_s,data:widget.k,user:widget.user);
      if(send["result"]=="Done"){
        setState((){widget.k=[-1,-1,-1,-1];});
        widget.active=true;
        if(widget.l_s=="s"){
          d["first"]=true;
        }
        else{
          d["second"]=true;
        }
        Navigator.pop(context);
      }
      else{
        Navigator.pop(context);
        scaf(w,send["result"]);
      }
      //set widget.active to true
    }
    else{
      scaf( w,"Thick all boxes before submitting");
    }
   
  }

  void scaf( double w,String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(seconds:2),content:Text(text),margin:EdgeInsets.symmetric(horizontal:w*0.065),behavior:SnackBarBehavior.floating,));
  }
}
