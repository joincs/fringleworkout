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
import 'view_workout_screen.dart';

List userRemoved = [];

class HomeScreen extends StatefulWidget {
  final User currentUser;
  HomeScreen(this.currentUser);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          body: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: Container(
              padding: EdgeInsets.only(bottom: 70.0),
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
              // height: MediaQuery.of(context).size.height - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset("asset/lottie/menu.json", height: 80),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          "Tranings of any ",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 37.0),
                        child: Text(
                          "Difficult level",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 34,
                          ),
                        ),
                      )
                    ],
                  ),

                  Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: ViewWorkoutScreen(widget.currentUser),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor1,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                color: Colors.grey.shade100,
                              ),
                              height: 40.0,
                              width: 150.0,
                              child: Center(
                                child: Text(
                                  'My Workouts',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Gesture Detector 2 #######
                          GestureDetector(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: BuildWorkout(widget.currentUser),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor1,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                color: Colors.grey.shade100,
                              ),
                              height: 40.0,
                              width: 150.0,
                              child: Center(
                                child: Text(
                                  'Drills',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),

                  // Flexible(
                  //     flex: 1,
                  //     child: Column(children: [
                  //       LText(
                  //         "\l.lead.bold{My Workouts}",
                  //         baseStyle: TextStyle(color: Colors.black),
                  //       ),
                  //       Container(
                  //         height: 150,
                  //         child: Lottie.asset(
                  //           'asset/lottie/cashball.json',
                  //         ),
                  //       ),
                  //       InkWell(
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.rectangle,
                  //         borderRadius: BorderRadius.circular(5),
                  //         gradient: LinearGradient(
                  //             begin: Alignment.topRight,
                  //             end: Alignment.bottomLeft,
                  //             colors: [
                  //               primaryColor1,
                  //               primaryColor1,
                  //               primaryColor1,
                  //               primaryColor1,
                  //             ])),
                  //     height:
                  //         MediaQuery.of(context).size.height * .065,
                  //     width:
                  //         MediaQuery.of(context).size.width / 1.5,
                  //     child: Center(
                  //         child: Text("Build Your Workout",
                  //             style: TextStyle(
                  //                 color: textColor,
                  //                 fontWeight: FontWeight.bold))),
                  //   ),
                  //   onTap: () async {
                  //     pushNewScreen(
                  //       context,
                  //       screen: BuildWorkout(widget.currentUser),
                  //       withNavBar: false,
                  //       pageTransitionAnimation:
                  //           PageTransitionAnimation.cupertino,
                  //     );
                  //   },
                  // ),
                  //     ]),
                  //   )

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // SizedBox(height: 80),
                        // Center(
                        //   child:
                        //       Lottie.asset("asset/lottie/cashball.json"),
                        // ),
                        Center(
                          child: Lottie.asset(
                            "asset/lottie/basketball.json",
                            width: 250,
                          ),
                        ),
                        // Center(
                        //   child: Image.asset(
                        //     "asset/Bitmap.png",
                        //   ),
                        // ),
                      ],
                    ),
                  )

                  /*         Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 20),
                              child: LText(
                                "\l.lead.bold{Continue Session}",
                                baseStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('DrillsLibrary')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError || !snapshot.hasData) {
                                  return Text('Something went wrong');
                                } else {
                                  return ListView.builder(
                                      //itemExtent: 0.0,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      //physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            left: kDefaultPadding / 2,
                                            right: kDefaultPadding / 2,
                                            top: kDefaultPadding / 2,
                                            //bottom: kDefaultPadding * 2.5,
                                          ),
                                          width: 210,
                                          height: 180,
                                          child: Column(
                                            children: <Widget>[
                                              GestureDetector(
                                                  onTap: null,
                                                  child: Container(
                                                    child: Image.network(
                                                        'https://firebasestorage.googleapis.com/v0/b/drivesportsapp.appspot.com/o/Big.png?alt=media&token=06b74f23-a7e6-4027-b560-48ea22895374'),
                                                  ))
                                            ],
                                          ),
                                        );
                                      });
                                }
                              }))),*/
                  // workoutName != null
                  //     ? Flexible(
                  //         flex: 1,
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     top: 10.0, left: 20),
                  //                 child: LText(
                  //                   "\l.lead.bold{Saved Workout}",
                  //                   baseStyle: TextStyle(color: Colors.black),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ))
                  //     : Container(),
                  // workoutName != null
                  //     ? Flexible(
                  //         child: Container(
                  //         child: ListView.builder(
                  //             padding: EdgeInsets.zero,
                  //             shrinkWrap: true,
                  //             scrollDirection: Axis.horizontal,
                  //             itemCount: workoutName.length,
                  //             itemBuilder: (context, index) {
                  //               return InkWell(
                  //                   onTap: () {
                  //                     pushNewScreen(
                  //                       context,
                  //                       screen: myWorkoutdrills(
                  //                           widget.currentUser,
                  //                           workoutName[index]),
                  //                       withNavBar: false,
                  //                       pageTransitionAnimation:
                  //                           PageTransitionAnimation.cupertino,
                  //                     );
                  //                   },
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(10.0),
                  //                     child: Container(
                  //                       decoration: BoxDecoration(
                  //                         borderRadius:
                  //                             BorderRadius.circular(15),
                  //                         image: DecorationImage(
                  //                             colorFilter: new ColorFilter.mode(
                  //                                 Colors.black.withOpacity(0.4),
                  //                                 BlendMode.darken),
                  //                             image: AssetImage('asset/1.png'),
                  //                             fit: BoxFit.cover),
                  //                       ),
                  //                       width: 225,
                  //                       height: 175,
                  //                       child: Center(
                  //                         child: Text(
                  //                             workoutName[index]
                  //                                 .toString()
                  //                                 .toUpperCase(),
                  //                             style: TextStyle(
                  //                                 color: Colors.white,
                  //                                 fontSize: 18,
                  //                                 fontWeight: FontWeight.bold)),
                  //                       ),
                  //                     ),
                  //                   ));
                  //             }),
                  //       ))
                  //     : Container(),
                  /* Flexible(
                      flex: 1,
                      child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection("/Workouts/${widget.currentUser.id}/myWorkouts")
                              .where('workoutName',isEqualTo: abc.first)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError || !snapshot.hasData) {
                                  return Text('Something went wrong');
                                } else {
                                  return ListView.builder(
                                      //itemExtent: 0.0,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      //physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (context, index) {
                                        return workoutCard(
                                          image: snapshot.data.documents[index]
                                              ['dDetailImg'],
                                          title: "Samantha",
                                          country: "Russia",
                                          price: 440,
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen(
                                                        widget.currentUser,
                                                        snapshot.data
                                                            .documents[index]),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              }))),*/

                  // workoutName != null
                  //     ? Flexible(
                  //         flex: 1,
                  //         child: InkWell(
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 shape: BoxShape.rectangle,
                  //                 borderRadius: BorderRadius.circular(5),
                  //                 gradient: LinearGradient(
                  //                     begin: Alignment.topRight,
                  //                     end: Alignment.bottomLeft,
                  //                     colors: [
                  //                       primaryColor1,
                  //                       primaryColor1,
                  //                       primaryColor1,
                  //                       primaryColor1,
                  //                     ])),
                  //             height: MediaQuery.of(context).size.height * .065,
                  //             width: MediaQuery.of(context).size.width / 1.5,
                  //             child: Center(
                  //                 child: Text("Build Your Workout",
                  //                     style: TextStyle(
                  //                         color: textColor,
                  //                         fontWeight: FontWeight.bold))),
                  //           ),
                  //           onTap: () async {
                  //             pushNewScreen(
                  //               context,
                  //               screen: BuildWorkout(widget.currentUser),
                  //               withNavBar: false,
                  //               pageTransitionAnimation:
                  //                   PageTransitionAnimation.cupertino,
                  //             );
                  //           },
                  //         ),
                  //       )
                  //     : Container(),
                ],
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
