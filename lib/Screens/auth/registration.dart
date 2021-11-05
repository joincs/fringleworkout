import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/Welcome.dart';
import 'package:fringleapp/util/color.dart';
import 'dart:ui';




class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreen createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {


  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController emailCtlr = new TextEditingController();
  final TextEditingController passCtlr = new TextEditingController();
  final TextEditingController cpassCtlr = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  var _firstPress = true;
  String companypassword = '';
  String companyconfirmpassword = '';
  bool checkedValue = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool digitlength = false;
  bool uppercase = false;
  bool specialCharacter = false;
  bool number = false;
  bool valid = false;
  bool passmatch = false;



  String validatePassword(String value) {
    if (!(value.length >= 8)) {
      digitlength = false;
    }
    if (!(RegExp(r'^(?=.*?[A-Z])').hasMatch(value))) {
      uppercase = false;
    }
    if (!(RegExp(r'^(?=.*?[0-9])').hasMatch(value))) {
      number = false;
    }
    if (!(RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value))) {
      specialCharacter = false;
    }
    if (value.length >= 8) {
      digitlength = true;
    }
    if (RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      uppercase = true;
    }
    if (RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
      number = true;
    }
    if (RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value)) {
      specialCharacter = true;
    }
    if (value.length >= 8 &&
        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
      digitlength = true;
      return null;
    } else {
      return "Weak Password";
    }

    /*if (!(value.length >= 8) && value.isNotEmpty) {
      return "Error";
    }*/
    //return null;
  }

  String validateConfirmPassword(String value) {
    if (value.length >= 8 &&
        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value) &&
        cpassCtlr.text == passCtlr.text) {
      passmatch=true;
      valid = true;
      return null;
    } else {
      return "Not Matched";
    }

    /*
    if (!(value.length >= 8) && value.isNotEmpty) {
      return "Error";
    } else if (_confirmpass.text != _pass.text) return 'Not Match';
    return null;*/
  }



  Future<FirebaseUser> handleSignUp(name, email, password,cpassword,BuildContext context) async {

        try {
          //showAlertDialog1(context);
          AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
            await Firestore.instance.collection("Users").document(result.user.uid).setData(
              {
                'userId': result.user.uid,
                'UserName': name,
                'UserType':'Users',
                /*'Pictures': FieldValue.arrayUnion([
                  "https://firebasestorage.googleapis.com/v0/b/churpapp-675d2.appspot.com/o/87449e529e536129932639b4b7e3aee6.jpg?alt=media&token=45fa5b54-5666-4236-9ca8-9e55749b0c35"
                ]),*/
                'Email': result.user.email,
                'timestamp': FieldValue.serverTimestamp()
              },
              merge: true,
            );

          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
          //showAlertDialog(context,'Account Successfully Created');


        } on AuthException catch (e) {
          showAlertDialog(context, e.code.toString());
        } catch (e) {
          showAlertDialog(context, e.code.toString());
          print(e.message);
        }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
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
              )
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: primaryColor1,

              /*image: DecorationImage(
                image: AssetImage(
                  'asset/logobg.png',
                ),
                fit: BoxFit.fill,
              ),*/
            ),
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        height: MediaQuery.of(context).size.height / 1,
                        child: Column(children: [
                          SizedBox(height: 10),
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.supervised_user_circle,
                                      color: secondryColor, size: 17),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: secondryColor),
                                  ),
                                ],
                              )),
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                controller: nameCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "Your Name",
                                padding: EdgeInsets.all(10),
                                onChanged: (text) {},
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      color: secondryColor, size: 17),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                obscureText: true,
                                controller: passCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "********",
                                padding: EdgeInsets.all(10),
                                onChanged: (value) {
                                  validatePassword(value);
                                  setState(() {
                                    companypassword = value;
                                  });
                                }
                              )),

                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.vpn_key,
                                      color: secondryColor, size: 17),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    //"Name ${widget.currentUser.name}",
                                    "Confirm Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: secondryColor),
                                  ),
                                ],
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                obscureText: true,
                                controller: cpassCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "********",
                                padding: EdgeInsets.all(10),
                                  onChanged: (value) {
                                    validateConfirmPassword(value);
                                    setState(() {
                                      companyconfirmpassword = value;
                                    });
                                  }
                              )),


                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                direction: Axis.vertical,
                                spacing: -20,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.grey),
                                          child: Checkbox(
                                              value: passmatch,
                                              onChanged: (value) {
                                                setState(() {
                                                 // passmatch = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        "Password Matched",
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.grey),
                                          child: Checkbox(
                                              value: digitlength,
                                              onChanged: (value) {
                                                setState(() {
                                                  //digitlength = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        "At least 8 characters in length",
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.grey),
                                          child: Checkbox(
                                              value: uppercase,
                                              onChanged: (value) {
                                                setState(() {
                                                 // uppercase = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        "At least one uppercase",
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.grey),
                                          child: Checkbox(
                                              value: specialCharacter,
                                              onChanged: (value) {
                                                setState(() {
                                                  //specialCharacter = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        "At least one special character",
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.grey),
                                          child: Checkbox(
                                              value: number,
                                              onChanged: (value) {
                                                setState(() {
                                                  //number = value;
                                                });
                                              }),
                                        ),
                                      ),
                                      Text(
                                        "At least one number",
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),


                          digitlength &&
                          uppercase &&
                          specialCharacter &&
                          number &&
                          passmatch ?

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
                                  child: Text("Create Account",
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold))),
                            ),
                            onTap: () async {

                              handleSignUp(nameCtlr.text, emailCtlr.text,passCtlr.text,cpassCtlr.text,context);
                            },
                          ):Container(),
                        ]),
                      ),
                    ),
                ]),
          ),
        ),
      ),
    );
  }
  showAlertDialog1(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Creating Account.." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context,String text) {
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























