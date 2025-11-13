import 'package:flutter/material.dart';
import 'package:firstapp/api.dart' as api;

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  var _control =TextEditingController();
  String? _error;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(child:Scaffold(
      appBar:AppBar(title:Row(children: [Text("Reset Password")]),),
      body:Center(
        child: Column(
          children: [
            SizedBox(height:h*.4,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:w*.04),
              child: TextField(decoration:InputDecoration(hintText:"Please enter your email",
                errorText: _error              
              ,border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(w*.3)))),controller: _control,),
            ),
            ElevatedButton(onPressed:(){change(_control.text);}, child:Text("Proceed")),
            
          ],
        ),
      )
    ));
    
  }
  scaf(String text) {
    
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration:Duration(seconds:10),dismissDirection: DismissDirection.up, content: Text(text)));
  }

  change(String x) async{
    showDialog(barrierDismissible: false,context: context, builder:(context){
      
      return Center(child: CircularProgressIndicator());
    });
    var resp=await api.resend(name:x);
    Navigator.pop(context);
    if (resp["result"]=="sent please check your primary inbox and spam section"){
      Navigator.pushNamed(context, '/signIn');
      scaf("A password resent link as being sent to your mail.please check your primary inbox and spam section");
    }
    else if(resp["result"]=="This Mail doesn't exist"){
      setState(() {
        _error=resp["result"];
      });
    }
    else{
      scaf(resp["result"]);
    }

    
  }
}