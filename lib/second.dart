import 'package:flutter/material.dart';
import 'dart:math';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var height = h * .65; //height for the Container
    var width = w * .8; //width for the Container
    return Center(
        child: Container(
      child: Stack(children: [
        Positioned(
          child: Rotate(height, width, h * 0.0009),
          top: 0,
          right: 0,
        ),
        Positioned(
          child: Rotate(height, width, h * .0013),
          bottom: 0,
          right: 0,
        ),
        Positioned(
          child: Rotate(height, width, h * 0.005),
          top: 0,
          left: 0,
        ),
        Positioned(
          child: Rotate(height, width, h * .002),
          bottom: 0,
          left: 0,
        ), //continue adding your widgets here
      ]),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(h * 0.03)),
    ));
  }

  Transform Rotate(double height, double width, double angle) {
    return Transform.rotate(
      angle: -pi / angle,
      child: Container(
        height: height * .198,
        width: width * .15,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
    );
  }
}

