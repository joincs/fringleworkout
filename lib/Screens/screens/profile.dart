import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/buildworkout.dart';
import 'package:fringleapp/Screens/screens/myWorkoutdrills.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fringleapp/Screens/auth/Landing.dart';
import 'package:fringleapp/Screens/privacy.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:fringleapp/Screens/screens/details/details_screen.dart';
import 'package:fringleapp/Screens/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fringleapp/util/color.dart';

class ProfileScreen extends StatefulWidget {
  final User currentUser;
  ProfileScreen(this.currentUser);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    String name = widget.currentUser.name;
    String email = widget.currentUser.email;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor1,
            centerTitle: true,
            title: Text('Profile'),
          ),
          body: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                //padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 75, left: 12, right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: primaryColor1),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Container(
                                    child: Image.network(
                                      'https://image.flaticon.com/icons/png/512/149/149071.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LText(
                                    "\l.lead.bold{$name}\n\l.lead.bold{$email}",
                                    textAlign: TextAlign.center,
                                    baseStyle: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                              LListItem(
                                backgroundColor: Colors.transparent,
                                onTap: () {},
                                leading: Icon(Icons.notifications,
                                    size: 20.0, color: Colors.black),
                                title: Text("Notification"),
                                textColor: Colors.black,
                                dense: true,

                                // padding: EdgeInsets.zero,
                              ),
                              LListItem(
                                backgroundColor: Colors.transparent,
                                onTap: () {},
                                leading: Icon(Icons.support_agent,
                                    size: 20.0, color: Colors.black),
                                title: Text("Support"),
                                textColor: Colors.black,
                                dense: true,

                                // padding: EdgeInsets.zero,
                              ),
                              LListItem(
                                backgroundColor: Colors.transparent,
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: Privacy(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                                  );

                                },
                                leading: Icon(Icons.local_police_rounded,
                                    size: 20.0, color: Colors.black),
                                title: Text("Privacy Policy"),
                                textColor: Colors.black,
                                dense: true,

                                // padding: EdgeInsets.zero,
                              ),
                              LListItem(
                                backgroundColor: Colors.transparent,
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: Privacy(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                                  );
                                },
                                leading: Icon(Icons.local_police_rounded,
                                    size: 20.0, color: Colors.black),
                                title: Text("Terms & Conditions"),
                                textColor: Colors.black,
                                dense: true,

                                // padding: EdgeInsets.zero,
                              ),
                              LListItem(
                                backgroundColor: Colors.transparent,
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();

                                  pushNewScreen(
                                    context,
                                    screen: LandingPage(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                leading: Icon(Icons.logout,
                                    size: 20.0, color: Colors.black),
                                title: Text("Logout"),
                                textColor: Colors.black,
                                dense: true,

                                // padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
