import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/api.dart' as api;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  Object? schools;
  SignUp({Key? key, this.schools}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _formkey = GlobalKey<FormState>();
  bool obscureText_1 = true;
  bool obsecureText = true;
  bool call = false;
  IconData icon_1 = Icons.key_off;
  IconData icon_2 = Icons.key_off;
  List<String> schools = ['loading'];

  List<String>? get_school; //gottrn school from the server
  int x = 0; //not to make the snackar come out twice
  Object? val; //for the val of the string

  String? Name;
  String? Email;
  String? Password;
  String? Con;
  String? sch;

  Future<List<String>>? grt;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    grt = api.School();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var deta = Hive.openBox('details');
    return Form(
      key: _formkey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: h * .15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: TextFormField(
                  maxLength: 20,
                  validator: (value) {
                    if (value!.length <= 3) {
                      return "Provide your full Name";
                    } else {
                      Name = value;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding: EdgeInsets.only(top: h * 0.065),
                      //border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: h * 0.065),
                        child: Icon(
                          Icons.card_membership,
                          color: Colors.blueAccent,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: TextFormField(
                  validator: (value) {
                    Email = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.only(top: h * 0.065),
                      //border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: h * 0.065),
                        child: Icon(
                          Icons.email,
                          color: Colors.blueAccent,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: TextFormField(
                  onChanged: (String m) {
                    Password = m;
                  },
                  obscureText: obsecureText,
                  validator: (value) {
                    if (value!.length < 7) {
                      return "Password has to be atleast 7 characters";
                    } else {
                      if (value != Con || value.isEmpty) {
                        return "Password and Confirm don't match";
                      }
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.only(top: h * 0.065),
                      //border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(top: h * .06),
                          onPressed: () {
                            if (icon_1 == Icons.key_off) {
                              setState(() {
                                obsecureText = false;
                                icon_1 = Icons.key;
                              });
                            } else {
                              setState(() {
                                icon_1 = Icons.key_off;
                                obsecureText = true;
                              });
                            }
                          },
                          icon: Icon(icon_1, color: Colors.blue)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: h * 0.065),
                        child: Icon(
                          Icons.password_sharp,
                          color: Colors.blueAccent,
                        ),
                      )),
                  maxLength: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                child: TextFormField(
                  obscureText: obscureText_1,
                  onChanged: (String m) {
                    Con = m;
                  },
                  validator: (value) {
                    if (value != Password || value!.isEmpty) {
                      //Con='';
                      return "Password and Confirm  don't match";
                    }
                  },
                  maxLength: 50,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      contentPadding: EdgeInsets.only(top: h * 0.065),
                      //border: InputBorder.none,
                      suffixIcon: IconButton(
                          padding: EdgeInsets.only(top: h * 0.06),
                          onPressed: () {
                            if (icon_2 == Icons.key_off) {
                              setState(() {
                                obscureText_1 = false;
                                icon_2 = Icons.key;
                              });
                            } else {
                              setState(() {
                                icon_2 = Icons.key_off;
                                obscureText_1 = true;
                              });
                            }
                          },
                          icon: Icon(
                            icon_2,
                            color: Colors.blue,
                          )),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(top: h * 0.065),
                        child: Icon(
                          Icons.password,
                          color: Colors.blueAccent,
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('School Name:', style: TextStyle(color: Colors.blue)),
                  SizedBox(
                    width: w * .05,
                  ),
                  Container(
                      height: h * .08,
                      width: w * .4,
                      child: FutureBuilder<List<String>>(
                        future: grt,
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            if (get_school == null) {
                              get_school = snapshot.data;
                              val = get_school![0];
                              sch = get_school![0];
                            }
                            return DropdownButton(
                                isExpanded: true,
                                //borderRadius: BorderRadius.circular(w * .08),
                                value: val,
                                items: get_school!
                                    .map((e) => DropdownMenuItem(
                                          child: Text(
                                            e,
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    val = value;
                                    
                                    sch = value.toString();
                                  });
                                });
                          } else {
                            x += 1;
                            if (x == 2) {
                              scaf('No data Connecton');
                            }
                            x >= 2 ? x = 0 : '';
                            return DropdownButton(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(w * .08),
                                value: schools[0],
                                items: schools
                                    .map((e) => DropdownMenuItem(
                                          child: Text(
                                            e,
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    sch = value.toString();
                                  });
                                });
                          }
                        }),
                      )),
                  IconButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (get_school == null) {
                          setState(() {
                            grt = api.School();
                          });
                        }
                      },
                      icon: Icon(Icons.refresh))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Check(context);
                  },
                  child: Text('Sign Up')),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signIn');
                  },
                  child: Text('Sign in here')),
              Container(
                height: h * .05,
              )
            ],
          )),
        ),
      ),
    );
  }

  Future<dynamic> Check(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      if(1==1){
        call =true;
        if(sch!="loading"){
        
        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Center(
                              child:CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                );});
        var resp=await api.Post_Cred(name: Name, Password: Password, email: Email, School: sch);
        Navigator.pop(context);
        
        if (resp["result"]=="No internet connection" || resp["result"]=="You have no data connection."){
          scaf("No internet connection");
          call=false;
        } 
        else if(resp["result"]=="Done"){
          Hive.box("details").putAll({"user":Email,"password":Password});
          Hive.box('details').close();
          Navigator.pushNamed(context,'/navig',arguments: {
                                            "Name":Name,
                                            "first":false,
                                            "second": false,
                                            "week": "1",
                                            "sch": sch,
                                            "user":resp["user"],
                                            "0":false,//to stop calling the db when it has succefullyloaded b4,
                                            "2":false,
                                            "3":false,
                                          });
          call=false;
        }
        else{
          call=false;
          scaf(resp["result"]);
        } 
        }
        else{
          call=false;
          return scaf('No data Connecton');    
        }
        
      }
    } else {
      call=false;
      //return scaf('No data Connecton');

    }
  }

  //for displaying no data
  Future<dynamic> scaf(String text) async {
    await Future.delayed(Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
        ),
        Text(text),
      ],
    )));
  }
}
