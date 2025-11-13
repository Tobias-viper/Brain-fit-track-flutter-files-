import 'package:flutter/material.dart';
import 'skill.dart'; //for the custom widget 

class Level extends StatefulWidget {
  Level({Key? key}) : super(key: key);
  String? Name;
  bool? first;//this is to tell if the child has filled any skill or unhelpful 
  bool? second;
  String? week;
  String? sch;

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  List<int> f = [-1,-1,-1,-1];
  List<String> dir = ['L1.jpg','L2.jpg','L3.jpg','L4.jpg'];
  List<String> text = ['Level 1','Level 2',"Level 3","Level 4"];
  @override
  Widget build(BuildContext context) {
    var d = ModalRoute.of(context)!.settings.arguments as Map;
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          shrinkWrap:true,
          itemCount:4,
          itemBuilder:(context,i){
          return Custom(Colors.red,user:d["user"],l_s:"l",sch:d["sch"],week:d['week'],active:d['second'],last:'red.jpg',k:f,w:i,key:ValueKey(i),directory:dir[i],text: text[i],); 
          }
        ),
      ),
    );
    
  }
}