import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/editProfile.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/editProfile.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/util/color.dart';
import 'package:fringleapp/util/snackbar.dart';
import 'package:fringleapp/util/drop_list_model.dart';
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

class TransactionHistoryDetail extends StatefulWidget {
  final User currentUser;
  final String docId;
  TransactionHistoryDetail(this.currentUser, this.docId);

  @override
  TransactionHistoryDetailState createState() =>
      TransactionHistoryDetailState();
}

class TransactionHistoryDetailState extends State<TransactionHistoryDetail> {
  List<String> ImageUrl = ['', '', '', '', ''];
  bool imgupload = false;
  Map<String, dynamic> userData = {}; //user personal info

  String account;
  @override
  void initState() {
    super.initState();
    getAdmin();
  }

  String AdminPhone;
  String AdminEmail;
  String AdminZelle;
  String AdminPaypal;
  String AdminBitcoin;
  String AdminEthereum;
  String AdminWesternUnion;
  String AdminEuros;
  String AdminUSD;
  String AdminESPANA_EUR;
  String AdminCOLOMBIA_COP;
  String AdminPANAMA_USD;

  Future getAdmin() async {
    return Firestore.instance
        .collection("Admin")
        .document('VuuUUjj1jSxlb1kLaMxj')
        .snapshots()
        .listen((data) async {
      AdminPhone = data['phoneNumber'];
      AdminEmail = data['Email'];
      AdminZelle = data['Zelle'];
      AdminPaypal = data['Paypal'];
      AdminBitcoin = data['Bitcoin'];
      AdminEthereum = data['Ethereum'];
      AdminWesternUnion = data['WesternUnion'];
      AdminEuros = data['Euros'];
      AdminUSD = data['USD'];
      AdminESPANA_EUR = data['ESPANA_EUR'];
      AdminCOLOMBIA_COP = data['COLOMBIA_COP'];
      AdminPANAMA_USD = data['PANAMA_USD'];

      if (mounted) setState(() {});
    });
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
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('Transaction Details'),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('Transaction')
                    .where('TransactionID', isEqualTo: widget.docId)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData ||
                      streamSnapshot.data == null ||
                      streamSnapshot.data.documents.length == 0) {
                    return Center(
                      child: Text(
                        'No Record Found',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: streamSnapshot.data.documents.length,
                        itemBuilder: (ctx, index) =>
                            list(context, index, streamSnapshot.data)
                        //Text(streamSnapshot.data.documents[index]['bookingDate']),
                        );
                  }
                })));
  }

  Widget list(BuildContext context, int index, QuerySnapshot data) {
    data.documents[index]['sendingType'] == 'Zelle'
        ? account = AdminZelle
        : null;
    data.documents[index]['sendingType'] == 'Paypal'
        ? account = AdminPaypal
        : null;
    data.documents[index]['sendingType'] == 'Bitcoin'
        ? account = AdminBitcoin
        : null;
    data.documents[index]['sendingType'] == 'Ethereum'
        ? account = AdminEthereum
        : null;
    data.documents[index]['sendingType'] == 'Western Union'
        ? account = AdminWesternUnion
        : null;
    data.documents[index]['sendingType'] ==
            'Transferencia en EUROS Union Europea'
        ? account = AdminEuros
        : null;
    data.documents[index]['sendingType'] ==
            'Deposito o Transferencia en UNITED STATES USD'
        ? account = AdminUSD
        : null;
    data.documents[index]['sendingType'] ==
            'Deposito o Transferencia en ESPANA EUR'
        ? account = AdminESPANA_EUR
        : null;
    data.documents[index]['sendingType'] ==
            'Deposito o Transferencia en COLOMBIA COP'
        ? account = AdminCOLOMBIA_COP
        : null;
    data.documents[index]['sendingType'] ==
            'Deposito o transferencia en PANAMA USD'
        ? account = AdminPANAMA_USD
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.black,
                              Colors.black,
                            ])),
                    //color: Colors.black,
                    child: Center(
                      child: Text(
                        'Company Account Detail',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                data.documents[index]['sendingType'] == 'Zelle'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: Zelle\n\n' + AdminZelle))
                    : Container(),
                data.documents[index]['sendingType'] == 'Paypal'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: Paypal\n\n' + AdminPaypal))
                    : Container(),
                data.documents[index]['sendingType'] == 'Bitcoin'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: Bitcoin\n\n' + AdminBitcoin))
                    : Container(),
                data.documents[index]['sendingType'] == 'Ethereum'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            Text('Account Type: Ethereum\n\n' + AdminEthereum))
                    : Container(),
                data.documents[index]['sendingType'] == 'Western Union'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: Western Union\n\n' +
                            AdminWesternUnion))
                    : Container(),
                data.documents[index]['sendingType'] ==
                        'Transferencia en EUROS Union Europea'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: EUROS Union Europe\n\n' +
                            AdminEuros))
                    : Container(),
                data.documents[index]['sendingType'] ==
                        'Deposito o Transferencia en UNITED STATES USD'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            'Account Type: UNITED STATES USD\n\n' + AdminUSD))
                    : Container(),
                data.documents[index]['sendingType'] ==
                        'Deposito o Transferencia en ESPANA EUR'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            'Account Type: ESPANA EUR\n\n' + AdminESPANA_EUR))
                    : Container(),
                data.documents[index]['sendingType'] ==
                        'Deposito o Transferencia en COLOMBIA COP'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Account Type: COLOMBIA COP\n\n' +
                            AdminCOLOMBIA_COP))
                    : Container(),
                data.documents[index]['sendingType'] ==
                        'Deposito o transferencia en PANAMA USD'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            'Account Type: PANAMA USD\n\n' + AdminPANAMA_USD))
                    : Container(),
                /*GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(account)
                        .then((value) => Text(account));
                    copiedDialogue(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      width: 75,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text('Copy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white))),
                    ),
                  ),
                ),*/
                SizedBox(height: 15,),



                GestureDetector(
                  onTap: () async {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.black,
                              Colors.black,
                            ])),
                    //color: Colors.black,
                    child: Center(
                      child: Text(
                        'Transaction Detail',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Sending  : ' + data.documents[index]['sendingType'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Receiving: ' + data.documents[index]['receivingType'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 18,
                        color: Colors.black,
                      ),
                      Text(
                        data.documents[index]['TransactionReceivingAccount'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 18,
                        color: Colors.black,
                      ),
                      Text(data.documents[index]['TransactionAmount']),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2,
                      crossAxisSpacing: 4,
                      padding: EdgeInsets.all(10),
                      children: List.generate(1, (index) {
                        return InkWell(
                          //onTap: () => source(context, index, false),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: CachedNetworkImageProvider(
                                  //       widget.currentUser.imageUrl[index],
                                  //     )),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: CachedNetworkImage(
                                        //fit: BoxFit.fitHeight,
                                        imageUrl: data.documents[index]['receipt'] != null
                                            ? data.documents[index]['receipt']
                                            : 'https://media.istockphoto.com/vectors/vector-receipt-icon-flat-design-vector-illustration-vector-id655840038?k=6&m=655840038&s=612x612&w=0&h=CSjjXMsd1EEwbrp6hqjtyS6qu4H1jEWDAHvBohNt48I=',
                                        placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 10,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl:
                                                'https://media.istockphoto.com/vectors/vector-receipt-icon-flat-design-vector-illustration-vector-id655840038?k=6&m=655840038&s=612x612&w=0&h=CSjjXMsd1EEwbrp6hqjtyS6qu4H1jEWDAHvBohNt48I=',
                                            placeholder: (context, url) =>
                                                Center(
                                              child: CupertinoActivityIndicator(
                                                radius: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                ),
                Center(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
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
                                  child: Text(data.documents[index]['TransactionStaus']=='Completed'?
                                    'Transaction is Completed':'Transaction not Completed yet',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () {

                            //setUserData(userData);
                          },
                        ),
                      )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

Future showAccountDialog(context, String account, String accountType) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        /*Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
        });*/
        return Center(
            child: Container(
          width: 150.0,
          height: 300.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                    child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Account : ' + accountType,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    )),
                  ],
                )),
              ),
              GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(account).then((value) => Text(account));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      child: Column(
                    children: [
                      Center(child: Text(account)),
                    ],
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(account).then((value) => Text(account));
                  copiedDialogue(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    width: 75,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text('COPY',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12))),
                  ),
                ),
              ),
            ],
          ),

          //Text('Click on text and it will be copied'),
          // ],
        ));
      });
}

Future copiedDialogue(context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
        return Center(
            child: Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: <Widget>[
              Image.asset(
                "asset/auth/verified.jpg",
                height: 40,
                color: Colors.black,
                colorBlendMode: BlendMode.color,
              ),
              Text(
                "Copied",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 15),
              )
            ],
          ),

          //Text('Click on text and it will be copied'),
          // ],
        ));
      });
}

Future showWelcomDialog(context) async {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.pop(context);
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
        });
        return Center(
            child: Container(
                width: 200.0,
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
                      "Receipt submitted, it'll take 24-48 hours for us to transfer the amount to your receiving account",
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
