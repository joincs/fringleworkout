import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fringleapp/Screens/Splash.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/Welcome.dart';
import 'package:fringleapp/Screens/auth/Landing.dart';
import 'package:fringleapp/Screens/auth/emailLogin.dart';
import 'package:fringleapp/Screens/screens/buildworkout.dart';
import 'package:fringleapp/util/color.dart';
import 'package:liquid_ui/liquid_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(new Waiting());
  });
}

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool voxt = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (ctx, timer) => timer.connectionState == ConnectionState.done
          ? MyApp() //Screen to navigate to once the splashScreen is done.
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/Splash.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future _checkAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.currentUser().then((FirebaseUser user) async {
      print(user);
      if (user != null) {
        await Firestore.instance
            .collection('Users')
            .where('userId', isEqualTo: user.uid)
            .getDocuments()
            .then((QuerySnapshot snapshot) async {
          if (snapshot.documents.length > 0 ) {

              setState(() {
                isAuth = true;
                isLoading = false;
              });
            print("loggedin ${user.uid}");
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiquidApp(
        materialApp: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: primaryColor,
            ),
            home: isLoading
                ? Splash()
                : isAuth
                        ? Tabbar()
                        : LandingPage()

        ));
  }
}
