import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/buildworkout.dart';
import 'package:fringleapp/Screens/screens/myWorkoutdrills.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:lottie/lottie.dart';
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

List userRemoved = [];

class ViewWorkoutScreen extends StatefulWidget {
  final User currentUser;
  ViewWorkoutScreen(this.currentUser);

  @override
  _ViewWorkoutScreenState createState() => _ViewWorkoutScreenState();
}

class _ViewWorkoutScreenState extends State<ViewWorkoutScreen> {
  User infoUser;
  bool churp = false;
  bool onEnd = false;
  int num;
  bool notif = false;

  GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  final GlobalKey<SideMenuState> _sideMenuKey1 = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey1 = GlobalKey<SideMenuState>();

  String Name;
  List workoutName;

  Future<void> getWorkout() async {
    DocumentSnapshot variable = await Firestore.instance
        .collection('Workouts')
        .document(widget.currentUser.id)
        .get();
    setState(() {
      workoutName = variable.data['workoutName'];
    });
  }

  @override
  void initState() {
    getWorkout();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: primaryColor1,
          //   centerTitle: true,
          //   title: Text('Home'),
          // ),
          body: Scaffold(
            appBar: AppBar(
              elevation: 3,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Saved Workout',
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: Colors.white,
            floatingActionButton: Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  backgroundColor: primaryColor1,
                  onPressed: () {
                    pushNewScreen(
                      context,
                      screen: BuildWorkout(widget.currentUser),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Build Your Workout"),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // workoutName != null
                    //     ? Flexible(
                    //         flex: 1,
                    //         child: Row(
                    //           children: [
                    //             Expanded(
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     top: 30.0, left: 10),
                    //                 child: LText(
                    //                   "\l.lead.bold{Your Workout}",
                    //                   baseStyle: TextStyle(color: Colors.black),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ))
                    //     : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    workoutName != null
                        ? SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.count(
                                crossAxisCount: 2,
                                children:
                                    List.generate(workoutName.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      pushNewScreen(
                                        context,
                                        screen: myWorkoutdrills(
                                            widget.currentUser,
                                            workoutName[index]),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: Container(
                                      child: Card(
                                        child: Container(
                                          height: 300,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                colorFilter:
                                                    new ColorFilter.mode(
                                                        Colors.black
                                                            .withOpacity(0.4),
                                                        BlendMode.darken),
                                                image:
                                                    AssetImage('asset/3.png'),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0),
                                                child: Text(
                                                  workoutName[index]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        : Container(),

                    // Card(
                    //   color: Colors.white,
                    //   elevation: 3,
                    //   child: Column(
                    //     mainAxisAlignment:
                    //         MainAxisAlignment.end,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //             bottom: 20.0),
                    //         child: Text(
                    //           workoutName[index]
                    //               .toString()
                    //               .toUpperCase(),
                    //           style: TextStyle(
                    //             fontSize: 20,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    //),

                    // Flexible(
                    //     child: Container(
                    //     child: ListView.builder(
                    //         padding: EdgeInsets.zero,
                    //         shrinkWrap: true,
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: workoutName.length,
                    //         itemBuilder: (context, index) {
                    //           return InkWell(
                    //               onTap: () {
                    //                 pushNewScreen(
                    //                   context,
                    //                   screen: myWorkoutdrills(
                    //                       widget.currentUser,
                    //                       workoutName[index]),
                    //                   withNavBar: false,
                    //                   pageTransitionAnimation:
                    //                       PageTransitionAnimation.cupertino,
                    //                 );
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(10.0),
                    //                 child: Container(
                    //                   decoration: BoxDecoration(
                    //                     borderRadius:
                    //                         BorderRadius.circular(15),
                    //                     image: DecorationImage(
                    //                         colorFilter:
                    //                             new ColorFilter.mode(
                    //                                 Colors.black
                    //                                     .withOpacity(0.4),
                    //                                 BlendMode.darken),
                    //                         image:
                    //                             AssetImage('asset/1.png'),
                    //                         fit: BoxFit.cover),
                    //                   ),
                    //                   width: 225,
                    //                   height: 175,
                    //                   child: Center(
                    //                     child: Text(
                    //                         workoutName[index]
                    //                             .toString()
                    //                             .toUpperCase(),
                    //                         style: TextStyle(
                    //                             color: Colors.white,
                    //                             fontSize: 18,
                    //                             fontWeight:
                    //                                 FontWeight.bold)),
                    //                   ),
                    //                 ),
                    //               ));
                    //         }),
                    //   ))
                    // : Container(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LText(
                  "\l.lead{Drive}\n\l.lead.bold{Sports}",
                  baseStyle: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final _state = _sideMenuKey.currentState;
              if (_state.isOpened)
                _state.closeSideMenu();
              else
                _state.openSideMenu();
            },
            leading: Icon(Icons.home, size: 20.0, color: Colors.white),
            title: Text("Home"),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final _state = _sideMenuKey.currentState;
              _state.closeSideMenu();
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => Privacy()));
            },
            leading: Icon(Icons.local_police_rounded,
                size: 20.0, color: Colors.white),
            title: Text("Privacy Policy"),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () {
              final _state = _sideMenuKey.currentState;
              _state.closeSideMenu();
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => Privacy()));
            },
            leading: Icon(Icons.local_police_rounded,
                size: 20.0, color: Colors.white),
            title: Text("Terms & Conditions"),
            textColor: Colors.white,
            dense: true,
          ),
          LListItem(
            backgroundColor: Colors.transparent,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              final _state = _sideMenuKey.currentState;
              _state.closeSideMenu();
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => LandingPage()));
            },
            leading: Icon(Icons.logout, size: 20.0, color: Colors.white),
            title: Text("Logout"),
            textColor: Colors.white,
            dense: true,
          ),
        ],
      ),
    );
  }

  Future showAlertDialog(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
          return Center(
              child: Container(
                  width: 250.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "asset/auth/verified.jpg",
                        height: 60,
                        color: primaryColor,
                        colorBlendMode: BlendMode.color,
                      ),
                      Text(
                        "Successfully Reported",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "User is successfully reported, Our Team will review this shortly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.grey,
                            fontSize: 15),
                      )
                    ],
                  )));
        });
  }
}

class workoutCard extends StatelessWidget {
  const workoutCard({
    Key key,
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding / 2,
        right: kDefaultPadding / 2,
        top: kDefaultPadding / 2,
        //bottom: kDefaultPadding * 2.5,
      ),
      width: 210,
      height: 165,
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: press,
              child: Container(
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ))
        ],
      ),
    );
  }
}
