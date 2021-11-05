import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/Welcome.dart';
import 'package:fringleapp/Screens/auth/forgetpassword.dart';
import 'package:fringleapp/Screens/auth/registration.dart';
import 'package:fringleapp/util/color.dart';
import 'dart:ui';
import 'dart:async';
import 'package:fringleapp/models/user_model.dart';
import 'package:flutter/services.dart';

class emailLogin extends StatefulWidget {
  @override
  _emailLoginState createState() => _emailLoginState();
}

class _emailLoginState extends State<emailLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController passCtlr = new TextEditingController();
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
    getAdmin();
  }

  String AdminPhone;
  String AdminEmail;
  String AdminPass;

  Future getAdmin() async {
    return Firestore.instance
        .collection("Admin")
        .document('VuuUUjj1jSxlb1kLaMxj')
        .snapshots()
        .listen((data) async {
      //AdminPhone = data['phoneNumber'];
      //AdminEmail = data['Email'];
      //AdminPass = data['Password'];

      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor1,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Container(
              child: Image.asset(
            'asset/DS Logo.png',
            height: 25,
            //fit: BoxFit.fill,
          )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 140,
            decoration: BoxDecoration(
              color: primaryColor1,
            ),
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: primaryColor1,
                    image: DecorationImage(
                      image: AssetImage(
                        'asset/TRACKMYTRAINING.png',
                      ),
                      //fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(children: [
                      SizedBox(
                        height: 10,
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
                            controller: nameCtlr,
                            cursorColor: primaryColor,
                            //maxLines: 1,
                            //minLines: 3,
                            placeholder: "example@mail.com",
                            padding: EdgeInsets.all(10),
                            onChanged: (text) {},
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.vpn_key,
                                  color: secondryColor, size: 17),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                //"Name ${widget.currentUser.name}",
                                "Password",
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
                            obscureText: true,
                            controller: passCtlr,
                            cursorColor: primaryColor,
                            //maxLines: 1,
                            //minLines: 3,
                            placeholder: "********",

                            padding: EdgeInsets.all(10),
                            onChanged: (text) {},
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .065,
                            //width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text("Forget Password ?",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    //builder: (context) => forgetPassword()));
                                    builder: (context) => forgetPassword()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                                    primaryColor1,
                                    primaryColor1,
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Sign in",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () async {
                          try {
                            AuthResult result =
                                await _auth.signInWithEmailAndPassword(
                                    email: nameCtlr.text,
                                    password: passCtlr.text);
                            /* if(nameCtlr.text==AdminEmail && passCtlr.text==AdminPass)
                              {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => AdminTabbar()));
                              }
                            else
                              {*/

                            /* Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Tabbar(null, null)));*/

                            _auth.currentUser().then((FirebaseUser user) async {
                              print(user);
                              if (user != null) {
                                await Firestore.instance
                                    .collection('Users')
                                    .where('userId', isEqualTo: user.uid)
                                    .getDocuments()
                                    .then((QuerySnapshot snapshot) async {
                                  if (snapshot.documents.length > 0) {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => Tabbar()));
                                    });

                                    print("loggedin ${user.uid}");
                                  }
                                });
                              }
                            });

                            // }

                          } on AuthException catch (e) {
                            showAlertDialog(context, e.code.toString());
                          } catch (e) {
                            showAlertDialog(context, e.code.toString());
                            print(e.message);
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Have no account? Register Now",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
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
/*  showAlertDialog(BuildContext context,String text) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(text),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
        return alert;
      },
    );
  }*/

  Future navigationCheck(FirebaseUser currentUser, context) async {
    await Firestore.instance
        .collection('Users')
        .where('userId', isEqualTo: currentUser.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.documents.length > 0) {
        if (snapshot.documents[0].data['location'] != null) {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
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
      'Pictures': FieldValue.arrayUnion([user.photoUrl]),
      'phoneNumber': user.phoneNumber,
      'timestamp': FieldValue.serverTimestamp()
    },
    merge: true,
  );
}
