import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fringleapp/Screens/screens/details/approach_screen.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';

class ViewDrillScreen extends StatefulWidget {
  final User currentUser;
  final DocumentSnapshot snapshot;

  ViewDrillScreen(
    this.currentUser,
    this.snapshot,
  );

  @override
  _ViewDrillScreenState createState() => _ViewDrillScreenState();
}

class _ViewDrillScreenState extends State<ViewDrillScreen> {
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

    // List<bool> selectedCheckbox = [];

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: primaryColor1,
              onPressed: () async {
                await Firestore.instance
                    .collection("MyDrills")
                    .document(widget.currentUser.id)
                    .collection('Drills')
                    .document(docId)
                    .delete();
                drillAdded(context);
              },
              icon: Icon(Icons.remove),
              label: Text("Remove Drill"),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      "\l.lead{$dCat}\n\l.lead.bold{$aName}",
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
                        child: Text('Measurement',
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
                        child: Text(widget.snapshot.data['Measurement'],
                            style: TextStyle(
                              color: Colors.black,
                              //    fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                ),

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
                //           child: Text("Remove Drill",
                //               style: TextStyle(
                //                   color: textColor,
                //                   fontWeight: FontWeight.bold))),
                //     ),
                //      onTap: () async {
                //        print(docId);
                //     await Firestore.instance
                //         .collection("MyDrills")
                //         .document(widget.currentUser.id)
                //         .collection('Drills')
                //         .document(docId).delete();
                //     drillAdded(context);
                //   },

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
                  width: 250.0,
                  height: 150.0,
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
                        'Drill Removed From the List',
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
