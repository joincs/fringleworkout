import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:intl/intl.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

class addScoreDrill extends StatefulWidget {
  final User currentUser;
  final DocumentSnapshot snapshot;
  final String workoutName;
  final String workoutID;
  final bool drillCompletion;
  // final String docId;
  addScoreDrill(this.currentUser, this.snapshot, this.workoutName,
      this.workoutID, this.drillCompletion);

  @override
  _addScoreDrillState createState() => _addScoreDrillState();
}

class _addScoreDrillState extends State<addScoreDrill> {
  int bestScore;
  double avgScore;
  int checkStreak;
  int checkStreakExtra;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkScore();
  }

  void checkScore() async {
    var drillLibraryId = widget.snapshot.data['DrillLibraryID'];
    var drillType = widget.snapshot.data['type'];
    var drillApproachId = widget.snapshot.data['drillApproachId'];
    var scoreSnapshot = await Firestore.instance
        .collection(
            "/DrillsLibrary/${drillLibraryId}/${drillType}/${drillApproachId}/Score")
        .where('userId', isEqualTo: widget.currentUser.id)
        .getDocuments();

    int b = 0;
    int checkAvg = 0;
    int s = 0;
    for (int i = 0; i < scoreSnapshot.documents.length; i++) {
      checkAvg = checkAvg + scoreSnapshot.documents[i]['total_makes'];
      setState(() {
        avgScore = checkAvg / scoreSnapshot.documents.length;
      });
    }

    for (int i = 0; i < scoreSnapshot.documents.length; i++) {
      if (b > scoreSnapshot.documents[i]['total_makes']) {
        setState(() {
          bestScore = b;
        });
      } else {
        setState(() {
          b = scoreSnapshot.documents[i]['total_makes'];
          bestScore = b;
        });
      }
    }
    for (int i = 0; i < scoreSnapshot.documents.length; i++) {
      if (scoreSnapshot.documents[i]['streak'] != null) {
        if (s > scoreSnapshot.documents[i]['streak']) {
          setState(() {
            checkStreak = s;
          });
        } else {
          setState(() {
            s = scoreSnapshot.documents[i]['streak'];
            checkStreak = s;
          });
        }
      } else {
        checkStreak = 0;
      }
    }

    print(scoreSnapshot.documents.length);
  }

  @override
  Widget build(BuildContext context) {
    //snapshot.data['titleImage'];

    String dName = widget.snapshot.data['dName'];
    String dCat = widget.snapshot.data['dCat'];
    String cover = widget.snapshot.data['cover'];
    String dDetailImg = widget.snapshot.data['dDetailImg'];
    String video = widget.snapshot.data['video'];
    String aName = widget.snapshot.data['aName'];
    String _url = video;
    String key = widget.snapshot.data['key'];
    String type = widget.snapshot.data['type'];
    String drillId = widget.snapshot.data['drillId'];
    String measurement = widget.snapshot.data['Measurement'];
    String id = widget.snapshot.data['id'];
    String docId = widget.snapshot.data['docID'];

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: widget.drillCompletion == false
              ? Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton.extended(
                      backgroundColor: primaryColor1,
                      onPressed: () {
                        showPopup(context, widget.snapshot);
                      },
                      icon: Icon(Icons.done),
                      label: Text("Complete Drill"),
                    ),
                  ),
                )
              : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                      "\l.lead{$aName}\n\l.lead.bold{$dName}",
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
                          Text(bestScore != null ? bestScore.toString() : "__",
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
                          Text(
                              avgScore != null
                                  ? avgScore.toStringAsFixed(1)
                                  : '__',
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
                          Text(
                              checkStreak != null
                                  ? checkStreak.toString()
                                  : '__',
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
                        child: Text('Description',
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
                        child: Text(
                            'In the faster-is-better world we live in, carving out 30 to 45 minutes a day for a good workout can seem like a major challenge — and that can totally mess with your quest for a strong core. Enter: the 7-minute workout.',
                            style: TextStyle(
                              color: Colors.black,
                              //    fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                ),

                // widget.drillCompletion == false
                //     ? Container(
                //         width: MediaQuery.of(context).size.width,
                //         padding: EdgeInsets.all(16),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(20),
                //               topRight: Radius.circular(20)),
                //           color: Colors.white,
                //         ),
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
                //               child: Text(
                //                 "Complete Drill",
                //                 style: TextStyle(
                //                     color: textColor,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //           ),
                //           onTap: () {
                //             showPopup(context, widget.snapshot);
                //           },

                //         ),
                //       )
                //     : Container(),

                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: Text('Skills Developed',
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.bold)),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: Text('',
                //             style: TextStyle(
                //               color: Colors.black,
                //             )),
                //       ),
                //       Expanded(
                //         child: Text(,
                //             style: TextStyle(
                //               color: Colors.black,
                //             )),
                //       ),
                //     ],
                //   ),
                // ),
                /*Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: InkWell(
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
                          child: Text("Remove from workout",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold))),
                    ),
                    onTap: () async {

                      await Firestore.instance
                          .collection("MyDrills")
                          .document(currentUser.id)
                          .collection('Drills')
                          .document(docId).delete();
                      drillAdded(context);
                    },
                  ),
                ),*/
              ]),
            ),
          ),
        ),
      ),
    );
  }

  showPopup(context, DocumentSnapshot snapshot) {
    TextEditingController _totalAttempts = TextEditingController();
    TextEditingController _totalMakes = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                // key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _totalAttempts,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Total Attempts",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _totalMakes,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Total Makes",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text("Submit"),
                        onPressed: () async {
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(now);

                          var drillLibraryId = snapshot.data['DrillLibraryID'];
                          var drillType = snapshot.data['type'];
                          var drillApproachId =
                              snapshot.data['drillApproachId'];

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////STREAK Code////////////////////////////////////////////////

                          DateTime date = DateTime.now();

                          String formattedchecknewDate =
                              DateFormat('dd-MM-yyyy').format(date);

                          DateTime newDate =
                              new DateTime(date.year, date.month, date.day - 1);
                          String formattednewDate =
                              DateFormat('dd-MM-yyyy').format(newDate);

                          final QuerySnapshot result = await Firestore.instance
                              .collection(
                                  "/DrillsLibrary/${drillLibraryId}/${drillType}/${drillApproachId}/Score")
                              .where('date', isEqualTo: formattedchecknewDate)
                              .getDocuments();

                          final List<DocumentSnapshot> documents =
                              result.documents;

                          if (documents.length > 0) {
                            //checkStreak = 1;
                            checkStreakExtra = 1;
                          } else {
                            var scoreSnapshot = await Firestore.instance
                                .collection(
                                    "/DrillsLibrary/${drillLibraryId}/${drillType}/${drillApproachId}/Score")
                                .where('userId',
                                    isEqualTo: widget.currentUser.id)
                                .where('date', isEqualTo: formattednewDate)
                                .getDocuments();

                            if (scoreSnapshot.documents.length > 0) {
                              print('yes');
                              checkStreak = checkStreak + 1;
                              checkStreakExtra = checkStreak;
                            } else if (scoreSnapshot.documents.length == 0) {
                              checkStreakExtra = 1;
                            } else {}
                          }

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

                          var scoreId = await Firestore.instance
                              .collection(
                                  "/DrillsLibrary/${drillLibraryId}/${drillType}/${drillApproachId}/Score")
                              .document();

                          await Firestore.instance
                              .collection("Workouts")
                              .document(widget.currentUser.id)
                              .collection('myWorkouts')
                              .document(widget.workoutID)
                              .updateData({
                            'workoutCompletionDate': formattedDate,
                            'drillCompletion': true,
                            'drillCompletionDate': formattedDate,
                          });

                          await Firestore.instance
                              .collection(
                                  "/DrillsLibrary/${drillLibraryId}/${drillType}/${drillApproachId}/Score")
                              // .document(snapshot.data['DrillLibraryID'])
                              // .collection(snapshot.data['type'])
                              // .document(snapshot.data['drillApproachId'])
                              // .collection('Score')
                              .document(scoreId.documentID)
                              .setData(
                            {
                              'userId': widget.currentUser.id,
                              'workoutName': widget.workoutName,
                              'workoutID': widget.workoutID,
                              'scoreId': scoreId.documentID,
                              'Email': widget.currentUser.email,
                              'dName': snapshot.data['dName'],
                              'dCat': snapshot.data['dCat'],
                              'DrillLibraryID': snapshot.data['DrillLibraryID'],
                              'cover': snapshot.data['cover'],
                              'dDetailImg': snapshot.data['dDetailImg'],
                              'video': snapshot.data['video'],
                              'type': snapshot.data['type'],
                              'key': snapshot.data['key'],
                              'aName': snapshot.data['aName'],
                              'Measurement': snapshot.data['Measurement'],
                              'drillApproachId':
                                  snapshot.data['drillApproachId'],
                              'totalDrills': snapshot.data['totalDrills'],
                              'total_attempts': int.parse(_totalAttempts.text),
                              'total_makes': int.parse(_totalMakes.text),
                              'date': formattedDate,
                              'drillCompletion': true,
                              'drillCompletionDate': formattedDate,
                              'streak': checkStreakExtra
                            },
                          );

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
        });
        return Center(
          child: Container(
            width: 175.0,
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
                  "Drill Removed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 20),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
