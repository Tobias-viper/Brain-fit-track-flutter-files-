import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;




Future<List<String>>? School() async{
  List<String> _school=[];
  var _et =await http.get(Uri.parse('http://viper2003.pythonanywhere.com/schools?format=json'));
  var f =jsonDecode(_et.body);
  
  for(int i =0;i<f.length;i++){
    _school.add(f[i]['School_name']);
  }
  return _school;
}


Future<dynamic> Week({String? week,String? sch,String? user}) async{
try{
  var info ={"week":week,"School_name":sch,"user":user};
  print("sent"); 
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/week"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  
  return jsonDecode(send.body);
  //return {"result": "Done", "f": [1, 1, 3, 1, 1, 1, 1], "r": [1, 1, 1, 1, 1, 5, 1], "d": [1, 1, 1, 7, 1, 1, 1], "a": [1, 1, 1, 1, 1, 6, 1], "l1": [3, 3, 3, 1, 3, 3, 3], "l2": [3, 3, 3, 3, 2, 3, 3], "l3": [3, 5, 3, 3, 3, 3, 3], "l4": [3, 0, 3, 3, 3, 3, 3]};
}
catch(e){
  return {"result":"No internet connection"};
}
}

Future<dynamic> Post_Cred({String? name,String? email,String? Password,String? School}) async{
  try{
  var user_info = {"Password":Password,"Name":name,"Email":email,"School_name":School};
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/signup"),headers:{"Content-Type": "application/json"},body:jsonEncode(user_info));
  
  return jsonDecode(send.body);
  }
  catch(e){
    return "No internet connection";
  }
}


Future<dynamic> Login({String? email,String? Password }) async{
  try{
  var user_info = {"Password":Password,"Email":email};
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/login"),headers:{"Content-Type": "application/json"},body:jsonEncode(user_info));
  //print(send.body);
  //return {"result":"Done","Name":"Alani","bool":false,"bool_2":false,"user":"free123","week":"3","sch":"Ksc"};
  //
  return jsonDecode(send.body);
  }
  catch (e){
    return {"result":"No internet connection"};
  }
}


Future<dynamic> upload({String? week,String? sch,String? l_s,List<int>? data,String? user}) async{
  try{
  var info ={"week":week,"School_name":sch,"data":data,"l_s":l_s,"user":user};
  
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/upload"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  
  return jsonDecode(send.body);}
  catch (e){
    return {"result":"No Internet Connection"};
  }
}

Future<dynamic> table_data({String? week,String? sch,String? user}) async{
 try{
  var info ={"week":week,"School_name":sch,"user":user};
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/table"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  
  return jsonDecode(send.body);
 }
 catch (e){
   return {"result":"No Internet Connection","skill":[],"level":[]};
 }
}

Future<dynamic> Weeks({String? week,String? sch,String? user}) async{
try{
  var info ={"week":week,"School_name":sch,"user":user};
  print("called");
  print("shsj");
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/weks"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  print(send.body);
  return jsonDecode(send.body);
  //return {"result":"Done","x":["Week 1","Week 2","Week 3"],"f":[6,7,7],"r":[6,7,7],"d":[6,7,7],"a":[6,7,7],"l1":[18,21,21],"l2":[18,21,21],"l3":[18,21,21],"l4":[18,21,21]};
}
catch(e){
  return {"result":"No internet connection"};
}
}

Future<dynamic> all({String? week,String? sch,String? user}) async{
 try{
  var info ={"week":week,"School_name":sch,"user":user};
  var send = await http.post(Uri.parse("http://viper2003.pythonanywhere.com/all"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  //return {"result": "Done", "f": [6, 7,10,13,18,23,15,14,27,18,28, 7,10,13,18,23,15,14,27,18,28, 1, 10, 34, 12, 37, 17, 6, 15, 22, 13, 28, 11], "a": [6, 7,10,13,18,23,15,14,27,18,28, 7, 10,13,18,23,15,14,27,18,28,7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7], "d": [6, 7, 7, 7, 7,10,13,18,23,15,14,27,18,28, 7, 7, 10,13,18,23,15,14,27,18,28,7, 7, 7, 7, 7, 7, 7, 7], "r": [6, 7, 10,13,18,23,15,14,27,18,28,7, 7, 7,10,13,18,23,15,14,27,18,28, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7], "l1": [18, 21, 10,13,18,23,15,14,27,18,28,21, 21, 10,13,18,23,15,14,27,18,28,21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21], "l2": [18, 10,13,18,23,15,14,27,18,28,21, 21, 21, 21, 21, 21, 21, 21,10,13,18,23,15,14,27,18,28, 21, 21, 21, 21, 21, 21], "l3": [10,13,18,23,15,14,27,18,28,18, 21, 21, 21, 21, 21, 21, 21, 21, 21,10,13,18,23,15,14,27,18,28, 21, 21, 21, 21, 21], "l4": [18,10,13,18,23,15,14,27,18,28, 21, 21, 21, 21, 21, 21, 21,10,13,18,23,15,14,27,18,28, 21, 21, 21, 21, 21, 21, 21]};
  return jsonDecode(send.body);
  //return jsonDecode(send.body);
 } 
 catch (e){
   return {"result":"No Internet Connection"};
 }
}

Future<dynamic> resend({String? name}) async{
try{
  var info={"email":name};
  var send=await http.post(Uri.parse("http://viper2003.pythonanywhere.com/resend"),headers:{"Content-Type": "application/json"},body:jsonEncode(info));
  return jsonDecode(send.body);
  //return {"result":"sent please check your primary inbox and spam section"};
 } 
 catch (e){
   return {"result":"No Internet Connection"};
 }
}