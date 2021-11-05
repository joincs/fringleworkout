import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/util/color.dart';
import 'dart:ui';
import 'dart:async';
import 'package:fringleapp/models/user_model.dart';

class forgetPasswordEmailSent extends StatefulWidget {
  @override
  _forgetPasswordEmailSentState createState() => _forgetPasswordEmailSentState();
}
class _forgetPasswordEmailSentState extends State<forgetPasswordEmailSent> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  User currentUser;
  CollectionReference docRef = Firestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<User> users = [];
  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  String abvc;
  @override
  void initState() {
    super.initState();

  }

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showAlertDialog(context,'Email Verification Sent To Your Email');
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: secondryColor, //change your color here
            ),
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              'Forget Password',
              style: TextStyle(fontSize: 15, color: secondryColor
              ),
            ),
            backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                    children: [
                      SizedBox(
                        height: 75,
                      ),
                      Image.asset(
                        "asset/auth/verified.jpg",
                        height: 100,
                      ),
                      Text(
                        'Link Sent For Password Reset',
                        style: TextStyle(fontSize: 17, color: secondryColor,fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child:Text(
                            'A link has been sent to your registered email to reset your password.',
                            style: TextStyle(fontSize: 15, color: secondryColor
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),



                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    primaryColor1,
                                    primaryColor.withOpacity(.8),
                                    primaryColor,
                                    primaryColor,
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Okay",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                        },
                      ),

                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,String text) {
    AlertDialog alert = AlertDialog(
      content: Text(text),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pop(context);
        });
        return alert;
      },
    );
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

