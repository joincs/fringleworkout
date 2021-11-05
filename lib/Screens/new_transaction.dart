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
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  final User currentUser;
  newTransaction(this.currentUser);

  @override
  _newTransactionState createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  Map<String, dynamic> userData = {}; //user personal info
  String username = '';
  bool man = false;
  bool woman = false;
  bool select = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selecteddate;
  final TextEditingController amountCtlr = new TextEditingController();
  final TextEditingController receivingCtlr = new TextEditingController();
  //String ImageUrl;
  List<String> ImageUrl = ['', '', '', '', ''];

  String _dropDownSendingValue;
  String _dropDownReceivingValue;

  bool checkedValue = true;
  //////////////////////////////////////

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
              "New Transaction",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () async {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  "Sending Type",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: DropdownButton(
                  hint: _dropDownSendingValue == null
                      ? Text('Sending Type')
                      : Text(
                          _dropDownSendingValue,
                          style: TextStyle(color: Colors.blue),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: <String>[
                    'Zelle',
                    'Paypal',
                    'Bitcoin',
                    'Ethereum',
                    'Western Union',
                    'Transferencia en EUROS Union Europea',
                    'Deposito o Transferencia en UNITED STATES USD',
                    'Deposito o Transferencia en ESPANA EUR',
                    'Deposito o Transferencia en COLOMBIA COP',
                    'Deposito o transferencia en PANAMA USD',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownSendingValue = val;
                      },
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Receiving/Deposit Type",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: DropdownButton(
                  hint: _dropDownReceivingValue == null
                      ? Text('Receiving/Deposit Type')
                      : Text(
                          _dropDownReceivingValue,
                          style: TextStyle(color: Colors.blue),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: TextStyle(color: Colors.blue),
                  items: <String>[
                    'Zelle',
                    'Paypal',
                    'Bitcoin',
                    'Ethereum',
                    'Western Union',
                    'Transferencia en EUROS Union Europea',
                    'Deposito o Transferencia en UNITED STATES USD',
                    'Deposito o Transferencia en ESPANA EUR',
                    'Deposito o Transferencia en COLOMBIA COP',
                    'Deposito o transferencia en PANAMA USD',
                  ].map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownReceivingValue = val;
                      },
                    );
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Receiving Account No.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: receivingCtlr,
                  cursorColor: primaryColor,
                  placeholder: "Enter account you want money to be transfered",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'TransactionReceivingAccount': text});
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Amount",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: amountCtlr,
                  cursorColor: primaryColor,
                  placeholder: "Enter amount you want to transfer",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'TransactionAmount': text});
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    "We will deduct 5% as service fee",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 0.7,
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.black),
                        child: Checkbox(
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                    // SizedBox(height: 25,),

                    Text(
                      "By checking this box, you agree to our Terms of Service."
                      "\nYou also agree to the terms found in our Privacy Policy.",
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              (receivingCtlr.text.length > 0) && (amountCtlr.text.length > 0) && checkedValue==true && _dropDownSendingValue.length>0 && _dropDownReceivingValue.length>0
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
                                "Proceed",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () async {
                            QuerySnapshot _myDoc = await Firestore.instance.collection('Transaction').getDocuments();
                            List<DocumentSnapshot> _myDocCount = _myDoc.documents;
                            print(_myDocCount.length);
                            int count =_myDocCount.length+1;


                            var now = new DateTime.now();
                            var formatter = new DateFormat('yyyy-MM-dd');
                            String formattedDate = formatter.format(now);
                            print(formattedDate);
                            userData.addAll({'TransactionDate': formattedDate});
                            userData.addAll({'TransactionStaus': 'Pending'});
                            userData.addAll({'TransactionNumber': count});
                            userData.addAll({'userID': widget.currentUser.id});
                            userData.addAll({'userName': widget.currentUser.name});
                            userData.addAll({'userEmail': widget.currentUser.email});
                            userData.addAll({'sendingType': _dropDownSendingValue});
                            userData.addAll({'receivingType': _dropDownReceivingValue});
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
                                "Proceed",
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
    DocumentReference documentReference = Firestore.instance.collection('Transaction').document();
    userData.addAll({'TransactionID': documentReference.documentID});
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
      await Firestore.instance
          .collection("Transaction")
          .document(documentReference.documentID)
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
        Future.delayed(Duration(seconds: 5), () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
        });
        return Center(
            child: Container(
                width: 250.0,
                height: 200.0,
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
                      "Transaction Generated, Please Upload Receipt of transaction to one of our given account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 13),
                    )
                  ],
                )));
      });
}
