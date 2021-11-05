import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/AllowLocation.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/Screens/auth/login.dart';
import 'package:fringleapp/util/color.dart';
import 'package:fringleapp/util/snackbar.dart';
import 'package:fringleapp/util/drop_list_model.dart';
import 'package:fringleapp/util/select_drop_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as i;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:fringleapp/models/user_model.dart';


class editProfile extends StatefulWidget {

  final User currentUser;
  editProfile(this.currentUser);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  Map<String, dynamic> userData = {}; //user personal info
  String username = '';
  bool man = false;
  bool woman = false;
  bool select = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selecteddate;
  TextEditingController dobctlr = new TextEditingController();
  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController firstCtlr = new TextEditingController();
  final TextEditingController lastCtlr = new TextEditingController();
  final TextEditingController phoneCtlr = new TextEditingController();
  final TextEditingController carLicenseCtlr = new TextEditingController();
  final TextEditingController cartypeCtlr = new TextEditingController();
  final TextEditingController carbrandCtlr = new TextEditingController();
  //String ImageUrl;
  List<String> ImageUrl = ['', '', '', '',''];




  bool checkedValue=true;
  //////////////////////////////////////


  @override
  void initState() {
    // selecteddate=DateTime.parse(widget.currentUser.dob);
    //dobctlr.text=DateTime.parse(widget.currentUser.dob).toString().toString().substring(0,11);
     nameCtlr.text=widget.currentUser.name;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () async {
                  Navigator.pop(context);
                }
            ),
            backgroundColor: Colors.white),

        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),




              ListTile(
                title: Text(
                  "Car License Plate Number",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: carLicenseCtlr,
                  cursorColor: primaryColor,
                  placeholder: "Enter vehicle license plate number",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'carLicense': text});

                  },
                ),
              ),

              ListTile(
                title: Text(
                  "First Name",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: firstCtlr,
                  cursorColor: primaryColor,
                  placeholder: "Enter your first name",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'firstName': text});

                  },
                ),
              ),

              ListTile(
                title: Text(
                  "Last Name",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: lastCtlr,
                  cursorColor: primaryColor,
                  placeholder: "enter your last name",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'lastName': text});

                  },
                ),
              ),


              ListTile(
                title: Text(
                  "Username",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: nameCtlr,
                  cursorColor: primaryColor,
                  placeholder: "enter username",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'UserName': text});

                  },
                ),
              ),

              ListTile(
                title: Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: phoneCtlr,
                  cursorColor: primaryColor,
                  placeholder: "enter your phone number",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'phoneNumber': text});
                  },
                ),
              ),

              SizedBox(height: 10,),
              Padding(
                child: Text(
                  "Select Date of Birth",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 20),
              ),
              Padding(
                //padding: EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                      child: ListTile(
                        title: CupertinoTextField(
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          prefix: IconButton(
                            icon: (Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                            )),
                            onPressed: () {},
                          ),
                          onTap: () => showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    height:
                                    MediaQuery.of(context).size.height * .25,
                                    child: GestureDetector(
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        initialDateTime: DateTime(2000, 10, 12),
                                        onDateTimeChanged: (DateTime newdate) {
                                          setState(() {
                                            dobctlr.text = newdate.day.toString() +
                                                '/' +
                                                newdate.month.toString() +
                                                '/' +
                                                newdate.year.toString();
                                            selecteddate = newdate;
                                          });
                                        },
                                        maximumYear: 2002,
                                        minimumYear: 1800,
                                        maximumDate: DateTime(2002, 03, 12),
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                      onTap: () {
                                        print(dobctlr.text);
                                        Navigator.pop(context);
                                      },
                                    ));
                              }),
                          placeholder: "DD/MM/YYYY",
                          controller: dobctlr,
                        ),
                      ))),
              SizedBox(height: 20,),
              (dobctlr.text.length > 0) && (nameCtlr.text.length >0)
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Align(
                  alignment: Alignment.bottomCenter,
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
                              "Save Changes",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ))),
                    onTap: () {

                      userData.addAll({'UserName': nameCtlr.text});
                      userData.addAll({
                        'user_DOB': "$selecteddate",
                        'age': ((DateTime.now()
                            .difference(selecteddate)
                            .inDays) /
                            365.2425)
                            .truncate(),
                      });
                      updateUserData(userData);


                    },
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: MediaQuery.of(context).size.height * .065,
                        width: MediaQuery.of(context).size.width * .75,
                        child: Center(
                            child: Text(
                              "Save Changes",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: secondryColor,
                                  fontWeight: FontWeight.bold),
                            ))),
                    onTap: () {
                      CustomSnackbar.snackbar(
                          "Please select one", _scaffoldKey);
                    },
                  ),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }

  Future updateUserData(Map<String, dynamic> userData) async {
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
      await Firestore.instance
          .collection("Users")
          .document(widget.currentUser.id)
          .setData(userData, merge: true);
    });
    showWelcomDialog(context);
  }
}

Future showWelcomDialog(context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Tabbar()));
        });
        return Center(
            child: Container(
                width: 150.0,
                height: 120.0,
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
                      "Profile Successfully Updated",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 15),
                    )
                  ],
                )));
      });
}
