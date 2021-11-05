import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/auth/forgetpasswordemailsent.dart';
import 'package:fringleapp/util/color.dart';
import 'dart:ui';
import 'dart:async';
import 'package:fringleapp/models/user_model.dart';


class forgetPassword extends StatefulWidget {
  @override
  _forgetPasswordState createState() => _forgetPasswordState();
}
class _forgetPasswordState extends State<forgetPassword> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController emailCtlr = new TextEditingController();
  User currentUser;
  CollectionReference docRef = Firestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<User> users = [];



  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  String abc;
  @override
  void initState() {
    super.initState();

  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showAlertDialog(context,'Email Verification Sent To Your Email');

    } on AuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog1(context,'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showAlertDialog1(context,'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog1(context,'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showAlertDialog1(context,'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
      else
      {
        showAlertDialog1(context, 'Error Try Again');
        print(e);
      }
    }

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
                      Text(
                        'Enter Registered Email',
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
                        'Please Enter Your Registered Email Address to Reset Your Password.',
                        style: TextStyle(fontSize: 15, color: secondryColor
                        ),
                        ),
                      ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.email, color: secondryColor, size: 17),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                //"Name ${widget.currentUser.name}",
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: secondryColor),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: CupertinoTextField(
                            controller: emailCtlr,
                            cursorColor: primaryColor,
                            //maxLines: 1,
                            //minLines: 3,
                            placeholder: "Your Email",
                            padding: EdgeInsets.all(10),
                            onChanged: (text) {},
                          )),


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
                                    primaryColor1,
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Reset Password",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () async {
                            resetPassword(emailCtlr.text);
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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  //builder: (context) => forgetPassword()));
                    builder: (context) => forgetPasswordEmailSent()));
          });
          return Center(
              child: Container(
                  width: 180.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius:
                      BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "asset/auth/verified.jpg",
                        height: 100,
                      ),
                      Text(
                        "Link Sent \n to your email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20),
                      )
                    ],
                  )));
        });
  }
  showAlertDialog1(BuildContext context,String text) {
    AlertDialog alert = AlertDialog(
      content: Text(text),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          //Navigator.pop(context);
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

