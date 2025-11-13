import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context,'/signIn');},
        child: Icon(Icons.logout_outlined),
      ),
      body: Column(children: [
        Row(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: w * .1),
            )
          ],
        ),
        Divider(
          height: h * 0.02,
        ),
        SizedBox(
          height: h * .05,
        ),
        ListTile(
          leading: Icon(Icons.email_outlined),
          title: Text("Contact Us"),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: AlertDialog(
                      content:Text("Kindly Contact us on kit@changingchances.co.uk"),
                    ),
                  );
                });
          },
        ),
        SizedBox(
          height: h * .05,
        ),
        ListTile(
          leading: Icon(Icons.password),
          title: Text("Change Password"),
          onTap:(){Navigator.pushNamed(context,'/pass');},
        ),
      ]),
    );
  }
}
