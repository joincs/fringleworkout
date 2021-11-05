import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fringleapp/Screens/screens/details/approach_screen.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

class DetailsScreen extends StatefulWidget {
  final User currentUser;
  final DocumentSnapshot snapshot;

  DetailsScreen(this.currentUser, this.snapshot);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<bool> _isCheckedApproaches = <bool>[];

  @override
  void initState() {
    super.initState();
    _isCheckedApproaches =
        List<bool>.filled(widget.snapshot.data.length, false);
  }

  @override
  Widget build(BuildContext context) {
    //snapshot.data['titleImage'];

    String dName = widget.snapshot.data['dName'];
    String dCat = widget.snapshot.data['dCat'];
    String cover = widget.snapshot.data['cover'];
    String dDetailImg = widget.snapshot.data['dDetailImg'];
    String video = widget.snapshot.data['video'];

    String _url = video;
    List<bool> selectedCheckbox = [];

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
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.darken),
                        image: NetworkImage(
                          cover,
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
                      "\l.lead{$dCat}\n\l.lead.bold{$dName}",
                      //"\l.lead{Dribbling}\n",
                      baseStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
                Container(
                  height: 80,
                  color: primaryColor1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Center(
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('__',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Best Score',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ))),
                      Flexible(
                          child: Center(
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('__',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Avg. Score',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ))),
                      Flexible(
                          child: Center(
                              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('__',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Streak',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 120,
                          width: 120,
                          child: Image.network(
                            dDetailImg,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () async => await canLaunch(_url)
                                    ? await launch(_url)
                                    : throw 'Could not launch $_url',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Drill Preview',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Icon(Icons.play_circle_outline_outlined,
                                        size: 20.0, color: primaryColor1),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text("Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(widget.snapshot.data['desc'],
                            style: TextStyle(
                              color: Colors.black,
                              //    fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                ),
                widget.snapshot.data['Approaches'] == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('DrillsLibrary')
                              .document(widget.snapshot.data['id'])
                              .collection("Approaches")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> approachSnapshot) {
                            if (approachSnapshot.hasError ||
                                !approachSnapshot.hasData) {
                              return Text('Something went wrong');
                            } else {
                              return ListView.builder(
                                  //itemExtent: 0.0,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      approachSnapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    var drillsnapshot =
                                        approachSnapshot.data.documents[index];

                                    return ExpansionTile(
                                        title: Text(
                                          "Approches",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        children: [
                                          ListTile(
                                            leading: Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text(
                                                  index.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApproachScreen(
                                                          widget.currentUser,
                                                          approachSnapshot.data
                                                                  .documents[
                                                              index]),
                                                ),
                                              );
                                            },
                                            title: Row(
                                              children: [
                                                Text(
                                                  drillsnapshot['aName'],
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  drillsnapshot['key'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.brown[400],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Text(drillsnapshot['aName']),
                                          ),
                                        ]);

                                    //  InkWell(
                                    //   onTap: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ApproachScreen(
                                    //                 widget.currentUser,
                                    //                 approachSnapshot
                                    //                     .data.documents[index]),
                                    //       ),
                                    //     );

                                    //   },
                                    //                                       child: CheckboxListTile(
                                    //     title: Text(drillsnapshot['aName']),
                                    //     value: false,
                                    //     onChanged: (val) {
                                    //        _isChecked[index] = val;
                                    //       setState(() {
                                    //         _isCheckedApproaches[index] = val;
                                    //       });
                                    //     },
                                    //   ),
                                    // );
                                  });
                            }
                          },
                        ))
                    : Container(),
                widget.snapshot.data['Finishes'] == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('DrillsLibrary')
                              .document(widget.snapshot.data['id'])
                              .collection("Finishes")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> fininshSnapshot) {
                            if (fininshSnapshot.hasError ||
                                !fininshSnapshot.hasData) {
                              return Text('Something went wrong');
                            } else {
                              return ListView.builder(
                                  //itemExtent: 0.0,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      fininshSnapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    var drillsnapshot =
                                        fininshSnapshot.data.documents[index];

                                    return ExpansionTile(
                                        title: Text(
                                          "Finishes",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        children: [
                                          ListTile(
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                            ),
                                            leading: Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text(
                                                  index.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApproachScreen(
                                                          widget.currentUser,
                                                          fininshSnapshot.data
                                                                  .documents[
                                                              index]),
                                                ),
                                              );
                                            },
                                            title: Row(
                                              children: [
                                                Text(
                                                  drillsnapshot['aName'],
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  drillsnapshot['key'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.brown[400],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]);
                                  });
                            }
                          },
                        ))
                    : Container(),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(20),
                //         topRight: Radius.circular(20)),
                //     color: Colors.white,
                //   ),
                //   child: InkWell(
                //     child: Container(
                //       decoration: BoxDecoration(
                //           shape: BoxShape.rectangle,
                //           borderRadius: BorderRadius.circular(5),
                //           gradient: LinearGradient(
                //               begin: Alignment.topRight,
                //               end: Alignment.bottomLeft,
                //               colors: [
                //                 primaryColor1,
                //                 primaryColor1,
                //                 primaryColor1,
                //                 primaryColor1,
                //               ])),
                //       height: MediaQuery.of(context).size.height * .065,
                //       width: MediaQuery.of(context).size.width / 1.5,
                //       child: Center(
                //           child: Text("Add to Workout",
                //               style: TextStyle(
                //                   color: textColor,
                //                   fontWeight: FontWeight.bold))),
                //     ),
                //     onTap: () async {
                //       var randomDoc = await Firestore.instance
                //           .collection("MyDrills")
                //           .document(widget.currentUser.id)
                //           .collection('Drills')
                //           .document();

                //       await Firestore.instance
                //           .collection("MyDrills")
                //           .document(widget.currentUser.id)
                //           .collection('Drills')
                //           .document(randomDoc.documentID)
                //           .setData(
                //         {
                //           'userId': widget.currentUser.id,
                //           'workoutName': 'Default',
                //           'docID': randomDoc.documentID,
                //           'Email': widget.currentUser.email,
                //           'dName': dName,
                //           'dCat': dCat,
                //           'DrillLibraryID': widget.snapshot.data['id'],
                //           'cover': cover,
                //           'dDetailImg': dDetailImg,
                //           'video': video,
                //           'dSkillDev': dSkillDev,
                //         },
                //         merge: true,
                //       );
                //       drillAdded(context);
                //     },
                //   ),
                // ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future drillAdded(context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            Navigator.pop(context);
            Navigator.pop(context);
          });
          return Center(
              child: Container(
                  width: 150.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "asset/auth/verified.jpg",
                        height: 60,
                        color: primaryColor1,
                        colorBlendMode: BlendMode.color,
                      ),
                      Text(
                        "Drill Added",
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
}
