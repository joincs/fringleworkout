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


class PhaseScreen extends StatefulWidget {
  final User currentUser;
  PhaseScreen(this.currentUser);

  @override
  _PhaseScreenState createState() => _PhaseScreenState();
}

class _PhaseScreenState extends State<PhaseScreen> {


  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor1,
            centerTitle: true,
            //title: Text('Home'),
          ),
          body: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Under Development (Phase 2)')
    ],
              ),
            ),
            ),
          ),
        ));
  }

}

