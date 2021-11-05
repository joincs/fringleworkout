import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/allTransaction.dart';
import 'package:fringleapp/Screens/auth/Landing.dart';
import 'package:fringleapp/Screens/dealerships.dart';
import 'package:fringleapp/Screens/pendingTransaction.dart';
import 'package:fringleapp/Screens/new_transaction.dart';
import 'package:fringleapp/Screens/privacy.dart';
import 'package:fringleapp/Screens/screens/profile.dart';
import 'package:fringleapp/Screens/screens/home.dart';
import 'package:fringleapp/Screens/screens/phase.dart';
import 'package:fringleapp/Screens/transaction_history.dart';
import 'package:fringleapp/Screens/uploadReceipt.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/Welcome.dart';
import 'package:fringleapp/Screens/auth/emailLogin.dart';
import 'package:fringleapp/util/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fringleapp/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fringleapp/Screens/Splash.dart';
import 'package:fringleapp/Screens/blockUserByAdmin.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List likedByList = [];

class Tabbar extends StatefulWidget {
  @override
  TabbarState createState() => TabbarState();
}

//_
class TabbarState extends State<Tabbar> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  CollectionReference docRef = Firestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  List<User> matches = [];
  List<User> newmatches = [];
  List<User> churpReq = [];
  List<User> newchurpReq = [];
  List<User> users = [];
  //bool verify;
  String AdminPhone;
  String AdminEmail;

  PersistentTabController _controller;
  bool _hideNavBar;

  Future getAdmin() async {
    return Firestore.instance
        .collection("Admin")
        .document('VuuUUjj1jSxlb1kLaMxj')
        .snapshots()
        .listen((data) async {
      AdminPhone = data['phoneNumber'];
      AdminEmail = data['Email'];
      print('Admin Email: ' + AdminEmail);
      print('Admin Phone: ' + AdminPhone);
      if (mounted) setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    //getAdmin();
  }

  _getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return docRef.document("${user.uid}").snapshots().listen((data) async {
      currentUser = User.fromDocument(data);
      //currentUser.verification == 'Pending' ? verify = false : verify = true;
      //print(currentUser.verification);
      //print(verify);
      if (mounted) setState(() {});
      users.clear();
      //getUserList();
      return currentUser;
    });
  }

  Future getUserList() async {
    List checkedUser = [];
    Firestore.instance
        .collection('/Users/${currentUser.id}/CheckedUser')
        .getDocuments()
        .then((data) {
      checkedUser.addAll(data.documents.map((f) => f['DislikedUser']));
      checkedUser.addAll(data.documents.map((f) => f['LikedUser']));
    }).then((_) {
      docRef.getDocuments().then((data) async {
        if (data.documents.length < 1) {
          print("no more data");
          return;
        }
        users.clear();
        for (var doc in data.documents) {
          User temp = User.fromDocument(doc);
          if (checkedUser.any(
            (value) => value == temp.id,
          )) {
          } else {
            users.add(temp);
          }
        }
        if (mounted) setState(() {});
      });
    });
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  String Name;

  List<Widget> _buildScreens() {
    return [
      HomeScreen(currentUser),
      PhaseScreen(currentUser),
      PhaseScreen(currentUser),
      ProfileScreen(currentUser),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("asset/icon0.png"),
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("asset/icon1.png"),
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("asset/icon2.png"),
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("asset/icon3.png"),
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
      ),
    ];
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
        body: currentUser == null
            ? Center(child: Splash())
            : PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: primaryColor1,
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset: true,
                stateManagement: true,
                navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                    ? 0.0
                    : kBottomNavigationBarHeight,
                hideNavigationBarWhenKeyboardShows: true,
                margin: EdgeInsets.all(0.0),
                popActionScreens: PopActionScreensType.once,
                bottomScreenMargin: 0.0,

                /*onWillPop: () async {
            await showDialog(
              context: context,
              useSafeArea: true,
              builder: (context) => Container(
                height: 50.0,
                width: 50.0,
                color: Colors.white,
                child: RaisedButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
            return false;
          },*/
                hideNavigationBar: _hideNavBar,
                decoration: NavBarDecoration(
                    colorBehindNavBar: Colors.indigo,
                    borderRadius: BorderRadius.circular(0.0)),
                popAllScreensOnTapOfSelectedTab: true,
                itemAnimationProperties: ItemAnimationProperties(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle
                    .style6, // Choose the nav bar style with this property
              ),
      ),
    );
  }

  showAlertDialog(
      BuildContext context, String service, String serviceBy, DateTime date) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(service),
      content: Text("The " +
          service +
          " is completed By " +
          serviceBy +
          " at " +
          date.toString()),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
