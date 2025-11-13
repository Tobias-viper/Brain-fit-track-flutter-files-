import 'package:flutter/material.dart';
import 'package:firstapp/api.dart' as api;
import 'package:hive/hive.dart';

class signIn extends StatefulWidget {
  signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  var password = TextEditingController(text:Hive.box('details').get('password',defaultValue:'') );
  var email = TextEditingController(text:Hive.box('details').get('user',defaultValue:''));
  var call = false;
  
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  height: h,
                  width: w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/2.jpg'),
                          fit: BoxFit.fill))),
              Padding(
                padding: EdgeInsets.only(top: h * 0.03, left: w * .1),
                child: Container(
                  width: w * .8,
                  height: h * .4,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Container(
                          width: w * .8,
                          height: h * .06,
                          child: Card(
                              elevation: h * .003,
                              child: TextField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: h * 0.0175),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Colors.blueAccent,
                                      ))))),
                      Container(
                        height: h * .03,
                      ),
                      Container(
                          width: w * .8,
                          height: h * .06,
                          child: Card(
                              elevation: h * .003,
                              child: TextField(
                                controller: password,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: h * 0.0175),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.blueAccent,
                                    )),
                              ))),
                      SizedBox(
                        height: h * .03,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: h * .05),
                        alignment: Alignment.topLeft,
                        width: w * .8,
                        height: h * .06,
                        child: ElevatedButton(
                            onPressed: () async {
                              if(!FocusScope.of(context).hasPrimaryFocus){
                                FocusScope.of(context).unfocus();
                              }
                              if (call == false) {
                                call = true;
                                if (password.text.length >= 7) {
                                  //Navigator.pushNamed(context,'/skill');
                                  if (email.text.length <= 3) {
                                    scaf('Invalid_email');
                                    call = false;
                                  } else {
                                    showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Center(
                              child:CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                );});
                                    var x = await api.Login(
                                        email: email.text,
                                        Password: password.text);
                                    
                                    if (x["result"] == "Done") {

                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, '/navig',
                                          arguments: {
                                            "Name": x["Name"],
                                            "first": x["bool"],
                                            "second": x["bool_2"],
                                            "week": x["week"],
                                            "sch": x["sch"],
                                            "user": x["user"],
                                            "0":false,//to stop calling the db when it has succefullyloaded b4,
                                            "2":false,
                                            "3":false,
                                          });
                                      await Hive.openBox('details');
                                      Hive.box("details").putAll({"user":email.text,"password":password.text});
                                      
                                      //Hive.box('details').close();
                                    } else {
                                      Navigator.pop(context);
                                      call = false;
                                      scaf(x["result"]);
                                    }
                                    //call the api and get the response

                                    //Navigator.pushNamed(context, '/navig');
                                  }
                                } else {
                                  scaf('Incorrect_Password');
                                  call = false;
                                }
                              } else {
                                call = false;
                              }
                            },
                            child: Text('Sign in')),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                actions: [TextButton(onPressed:(){Navigator.pop(context);}, child:Text("Ok"))],
                                title: Text("Notice"),
                                content:Text(
                                  "If your school is not part of the school listed,kindly choose others.Incase you want your school added to the list kindly message kit@changingchances.co.uk"),
                                );
                          });
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.blueAccent, fontSize: w * 0.035),
                    )),
                right: w * .65,
                top: h * .55,
              ),
              Positioned(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pass');
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.blueAccent, fontSize: w * 0.035),
                    )),
                left: w * .704,
                top: h * .55,
              )
            ],
          ),
        ));
  }

  scaf(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(dismissDirection: DismissDirection.up, content: Text(text)));
    api.resend(name:text);

  }
}
