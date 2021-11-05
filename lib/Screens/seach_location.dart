import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/util/color.dart';
import 'package:fringleapp/util/snackbar.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'AllowLocation.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as i;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SearchLocation extends StatefulWidget {
  final User userData;
  SearchLocation(this.userData);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  Map<String, dynamic> changeValues = {};

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MapBoxPlace _mapBoxPlace;
  TextEditingController _city = TextEditingController();
  //Add here your mapbox token
  String _mapboxApi = "pk.eyJ1IjoiaGFtemEwMDEiLCJhIjoiY2s3ZzhlNXk4MDl5bzNmbThzcGxrNXBtayJ9.yO2qYg4YDb8LGJ1zUEHP3g";


  Future updateData() async {
    Firestore.instance
        .collection("Users")
        .document(widget.userData.id)
        .setData(changeValues, merge: true);
    // lastVisible = null;
    // print('ewew$lastVisible');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: FloatingActionButton(
            elevation: 4,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Padding(
                  child: Text(
                    "Select\nyour city",
                    style: TextStyle(fontSize: 40),
                  ),
                  padding: EdgeInsets.only(left: 50, top: 120),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter your city name",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          helperText: "This is how it will appear in App.",
                          helperStyle:
                              TextStyle(color: secondryColor, fontSize: 15),
                        ),
                        controller: _city,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Material(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 80),
                                            child: MapBoxPlaceSearchWidget(
                                              language: 'en',
                                              popOnSelect: true,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .5,
                                              apiKey: _mapboxApi,
                                              limit: 10,
                                              searchHint:
                                                  'Enter your city name',
                                              onSelected: (place) {
                                                setState(() {
                                                  _mapBoxPlace = place;
                                                  _city.text =
                                                      _mapBoxPlace.placeName;
                                                });
                                              },
                                              context: context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))),
                      ),
                    ),
                    _city.text.length > 0
                        ? Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        primaryColor,
                                        primaryColor,
                                        primaryColor,
                                        primaryColor
                                      ])),
                              height:
                              MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          onTap: () async {
                            changeValues.addAll(
                              {
                                'location': {
                                  'latitude':
                                  _mapBoxPlace.geometry.coordinates[1],
                                  'longitude':
                                  _mapBoxPlace.geometry.coordinates[0],
                                  'address': "${_mapBoxPlace.placeName}"
                                },
                                'maximum_distance': 20,
                                'age_range': {
                                  'min': "20",
                                  'max': "50",
                                },
                              },
                            );

                            showWelcomDialog(context);
                            updateData();



                          },
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height:
                              MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                  child: Text(
                                    "CONTINUE",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: secondryColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          onTap: () {
                            CustomSnackbar.snackbar(
                                "Select a location !", _scaffoldKey);
                          },
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
