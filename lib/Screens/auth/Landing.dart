import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/Welcome.dart';
import 'package:fringleapp/Screens/auth/emailLogin.dart';
import 'package:fringleapp/Screens/privacy.dart';
import 'package:fringleapp/util/color.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  bool checkedValue = true;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: primaryColor1,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
             // colorFilter:
              //ColorFilter.mode(Colors.yellowAccent[100], BlendMode.colorBurn),
              //ColorFilter.mode(Colors.grey[700], BlendMode.modulate),
              image: AssetImage("asset/newbg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[

              Stack(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Image.asset(
                      'asset/DS Logo.png',
                      height: 50,
                      //fit: BoxFit.fill,
                    )),
                  ),
                ],
              ),
              Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: RichText(
                      text: TextSpan(
                        text: "Welcome To Drive Sports",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        children: [
                          TextSpan(
                              text: "\nThe App will help you to track your training",
                              style: TextStyle(
                                 // fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 15)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 30,
                ),
                checkedValue
                    ? InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    primaryColor,
                                    primaryColor,
                                    primaryColor,
                                    primaryColor
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .85,
                          child: Center(
                              child: Text("Get Started",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () {
                          bool updateNumber = false;
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => emailLogin()));
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 0.7,
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.black),
                          child: Checkbox(
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      // SizedBox(height: 25,),

                      Text(
                        "By checking this box, you agree to our\nTerms of Service."
                        "\nYou also agree to the terms found in our\n"
                        "Privacy Policy.",
                        style: TextStyle(fontSize: 10.0, color: Colors.black),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        child: new Text(
                          'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: primaryColor,
                            fontSize: 10,
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context, CupertinoPageRoute(builder: (context) => Privacy()))),
                    SizedBox(
                      width: 35,
                    ),
                    InkWell(
                        child: new Text(
                          'Terms & Condition',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: primaryColor,
                            fontSize: 10,
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context, CupertinoPageRoute(builder: (context) => Privacy()))),
                  ],
                )),
                SizedBox(
                  height: 25,
                ),
              ]),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit'),
              content: Text('Do you want to exit the app?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  Future navigationCheck(FirebaseUser currentUser, context) async {
    await Firestore.instance
        .collection('Users')
        .where('userId', isEqualTo: currentUser.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.documents.length > 0) {
        if (snapshot.documents[0].data['location'] != null) {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Tabbar()));
        } else {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Welcome()));
        }
      } else {
        await _setDataUser(currentUser);
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Welcome()));
      }
    });
  }


}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

Future _setDataUser(FirebaseUser user) async {
  await Firestore.instance.collection("Users").document(user.uid).setData(
    {
      'userId': user.uid,
      'UserName': user.displayName,
      'phoneNumber': user.phoneNumber,
      'timestamp': FieldValue.serverTimestamp()
    },
    merge: true,
  );
}
showAlertDialog(BuildContext context, String text) {
  AlertDialog alert = AlertDialog(
    content: Text(text),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      });
      return alert;
    },
  );
}