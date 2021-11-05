import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/details/approach_screen.dart';
import 'package:fringleapp/Screens/screens/details/details_screen.dart';

import 'package:fringleapp/Screens/screens/details/view_drill_screen.dart';
import 'package:fringleapp/Screens/screens/home/DrillLibrary.dart';
import 'package:fringleapp/main.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:intl/intl.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fringleapp/Screens/auth/Landing.dart';
import 'package:fringleapp/Screens/privacy.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'drill_library_screen.dart';

List userRemoved = [];

class BuildWorkout extends StatefulWidget {
  final User currentUser;
  BuildWorkout(this.currentUser);

  @override
  _BuildWorkoutState createState() => _BuildWorkoutState();
}

class _BuildWorkoutState extends State<BuildWorkout> {
  User infoUser;
  bool churp = false;
  bool onEnd = false;
  int num;
  bool notif = false;
  bool drill = false;

  GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  TextEditingController _workoutController = TextEditingController();

  String Name;
  List drillid;

  CreateListofCourses(QuerySnapshot snapshot) async {
    var docs = snapshot.documents;
    for (var Doc in docs) {
      setState(() {
        drillid = docs;
      });
    }
  }

  Future<void> getWorkout() async {
    Firestore.instance
        .collection("MyDrills")
        .document(widget.currentUser.id)
        .collection("Drills")
        .snapshots()
        .listen(CreateListofCourses);
  }

  @override
  void initState() {
    super.initState();
    getWorkout();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                Stack(children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.darken),
                        image: AssetImage(
                          'asset/bgworkout.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0, left: 20),
                    child: LText(
                      //"\l.lead{New Workout}\n \l.lead.bold{Enter Name}",
                      "\l.lead{New Workout}",
                      baseStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
                Divider(),
                LListItem(
                  backgroundColor: Colors.transparent,
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: DrillLibraryScreen(widget.currentUser),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  leading: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(Icons.add_rounded,
                            size: 20.0, color: Colors.grey)),
                  ),
                  title: Text("Add a drill"),
                  textColor: Colors.grey,
                  dense: false,
                ),
                Divider(),
                Container(
                    //color: Colors.red,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection(
                                "/MyDrills/${widget.currentUser.id}/Drills")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Text('Something went wrong');
                          } else {
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      LListItem(
                                        backgroundColor: Colors.transparent,
                                        onTap: () async {
                                          _onLoading();
                                          DocumentSnapshot snapshotDetail;
                                          final DocumentReference document =
                                              Firestore.instance
                                                  .collection("DrillsLibrary")
                                                  .document(snapshot
                                                          .data.documents[index]
                                                      ['DrillLibraryID']);
                                          await document.get().then<dynamic>(
                                              (DocumentSnapshot
                                                  snapshotFetch) async {
                                            setState(() {
                                              snapshotDetail = snapshotFetch;
                                            });
                                          });
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop('dialog');
                                          pushNewScreen(
                                            context,
                                            screen: ViewDrillScreen(
                                              widget.currentUser,
                                              snapshot.data.documents[index],
                                            ),
                                            withNavBar: false,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          );
                                        },
                                        leading: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            padding: const EdgeInsets.all(0),
                                            child: Center(
                                                child: Text(index.toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16))),
                                          ),
                                        ),
                                        title: Text(
                                            snapshot.data.documents[index]
                                                ['aName'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                        subtitle: Text(snapshot
                                            .data.documents[index]['dCat']),
                                        textColor: Colors.grey,
                                        dense: true,
                                      ),
                                      Divider(),
                                      snapshot.data.documents.length - 1 ==
                                              index
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                                color: Colors.white,
                                              ),
                                              child: InkWell(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end: Alignment
                                                              .bottomLeft,
                                                          colors: [
                                                            primaryColor1,
                                                            primaryColor1,
                                                            primaryColor1,
                                                            primaryColor1,
                                                          ])),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .065,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Center(
                                                      child: Text(
                                                          "Save Workout",
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                                onTap: () async {
                                                  _displayTextInputDialog(
                                                      context,
                                                      snapshot,
                                                      snapshot.data.documents
                                                          .length);
                                                },
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                });
                          }
                        })),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, int totalDrills) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Workout Name'),
          content: TextField(
            controller: _workoutController,
            decoration: InputDecoration(hintText: "e.g. Ball Handling"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () async {
                DateTime now = DateTime.now();
                String formattedDate = DateFormat('dd-MM-yyyy').format(now);

                //Navigator.of(context, rootNavigator: true).pop('dialog');
                _onLoading();
                await Firestore.instance
                    .collection("Workouts")
                    .document(widget.currentUser.id)
                    .setData(
                  {
                    'totalDrills': totalDrills,
                    'workoutName':
                        FieldValue.arrayUnion([_workoutController.text]),
                  },
                  merge: true,
                );

                for (var i = 0; i < totalDrills; i++) {
                  var randomDoc = await Firestore.instance
                      .collection("Workouts")
                      .document(widget.currentUser.id)
                      .collection('myWorkouts')
                      .document();

                  await Firestore.instance
                      .collection("Workouts")
                      .document(widget.currentUser.id)
                      .collection('myWorkouts')
                      .document(randomDoc.documentID)
                      .setData(
                    {
                      'workoutName': _workoutController.text,
                      'workoutID': randomDoc.documentID,
                      'dName': snapshot.data.documents[i]['dName'],
                      'dCat': snapshot.data.documents[i]['dCat'],
                      'aName': snapshot.data.documents[i]['aName'],
                      'key': snapshot.data.documents[i]['key'],
                      'type': snapshot.data.documents[i]['type'],
                      'Measurement': snapshot.data.documents[i]['Measurement'],
                      'drillApproachId': snapshot.data.documents[i]['id'],
                      'totalDrills': totalDrills,
                      'userId': widget.currentUser.id,
                      'DrillLibraryID': snapshot.data.documents[i]['drillId'],
                      'cover': snapshot.data.documents[i]['cover'],
                      'dDetailImg': snapshot.data.documents[i]['dDetailImg'],
                      'video': snapshot.data.documents[i]['video'],
                      'workoutCreationDate': formattedDate,
                      'workoutCompletionDate': formattedDate,
                      'drillCompletion': false,
                      'drillCompletionDate': formattedDate,
                      'workoutCompletion': false,
                    },
                    merge: true,
                  );
                }

                for (int i = 0; i <= drillid.length; i++) {
                  print(i);
                  print(i);
                  print(drillid.length);
                  print(drillid.length);

                  //int j=i+1;
                  await Firestore.instance
                      .collection("MyDrills")
                      .document(widget.currentUser.id)
                      .collection('Drills')
                      .document(drillid.first['docID'])
                      .delete();
                  await Firestore.instance
                      .collection("MyDrills")
                      .document(widget.currentUser.id)
                      .collection('Drills')
                      .document(drillid.last['docID'])
                      .delete();
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Waiting(),
                  ),
                );

                //Navigator.of(context, rootNavigator: true).pop('dialog');
                //Navigator.pop(context);
                //Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              height: 30,
              width: 20,
              //width: 0,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(primaryColor1),
                  ),
                  /*new Text("Loading",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.white),),*/
                ],
              ),
            ));
      },
    );
  }
}
