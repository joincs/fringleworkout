import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/seach_location.dart';
import 'package:fringleapp/util/color.dart';
import 'package:geolocator/geolocator.dart';

class AllowLocation extends StatelessWidget {
  final Map<String, dynamic> userData;
  AllowLocation(this.userData);

  @override
  Widget build(BuildContext context) {
    DateTime selecteddate;

    return WillPopScope(
        onWillPop: ()async {
      if (Navigator.of(context).userGestureInProgress)
        return false;
      else
        return true;
    },
    child: Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white12),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: secondryColor.withOpacity(.2),
                      radius: 110,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: "Enable location",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                        children: [
                          TextSpan(
                              text: """\nYou'll need to provide a
location
in order to search users around you.
                              """,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: secondryColor,
                                  textBaseline: TextBaseline.alphabetic,
                                  fontSize: 18)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Align(
                    alignment: Alignment.topCenter,
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
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .75,
                          child: Center(
                              child: Text(
                            "ALLOW LOCATION",
                            style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ))),
                      onTap: () async {
                        var currentLocation = await Geolocator()
                            .getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.best);
                        List<Placemark> pm = await Geolocator()
                            .placemarkFromCoordinates(currentLocation.latitude,
                                currentLocation.longitude);
                        userData.addAll(
                          {
                            'location': {
                              'latitude': currentLocation.latitude,
                              'longitude': currentLocation.longitude,
                              'address':
                                  //"${pm[0].locality} ${pm[0].subLocality} ${pm[0].subAdministrativeArea} ${pm[0].country} ${pm[0].postalCode}"
                                  //"${pm[0].locality},${pm[0].subAdministrativeArea} ${pm[0].country} ${pm[0].postalCode}"
                                  "${pm[0].locality},${pm[0].administrativeArea}"
                            },
                            'maximum_distance': 20,
                            'age_range': {
                              'min': "18",
                              'max': "50",
                            },
                          },
                        );
                        showWelcomDialog(context);
                        setUserData(userData);
                      },
                    ),
                  ),
                ),
              ]),
        ),
      ),
      ),
    );
  }
}

Future setUserData(Map<String, dynamic> userData) async {
  await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
    await Firestore.instance
        .collection("Users")
        .document(user.uid)
        .setData(userData, merge: true);
  });
}

Future showWelcomDialog(context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Tabbar()));
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
                      color: primaryColor,
                      colorBlendMode: BlendMode.color,
                    ),
                    Text(
                      "You're in",
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
