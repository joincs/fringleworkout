import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/editProfile.dart';
import 'package:fringleapp/Screens/uploadReceiptDetail.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';

class uploadReceipt extends StatefulWidget {
  final User currentUser;
  uploadReceipt(this.currentUser);

  @override
  uploadReceiptState createState() => uploadReceiptState();
}

//_
class uploadReceiptState extends State<uploadReceipt> {
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
              title: Text('Pending Transaction'),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('Transaction')
                    .where('userID', isEqualTo: widget.currentUser.id)
                    .where('TransactionStaus', isEqualTo: 'Pending')
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
            child:
                new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Row(
            children: [

                    GestureDetector(
                    onTap: () {

        Navigator.push(
        context,
        CupertinoPageRoute(
        builder: (context) => uploadReceiptDetail(widget.currentUser,data.documents[index]['TransactionID'])));
        },
          child:Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: new BoxDecoration(
                        color: Colors.black,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                        )),
                    child: Center(
                      child: Text(
                        'Upload Receipt',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sending  : ' + data.documents[index]['sendingType'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Receiving: ' + data.documents[index]['receivingType'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 18,
                          color: Colors.black,
                        ),
                        Text(data.documents[index]['TransactionAmount']),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            data.documents[index]['sendingType'] == 'Zelle'
                                ? showAccountDialog(
                                    context, AdminZelle, 'Zelle')
                                : null;
                            data.documents[index]['sendingType'] == 'Paypal'
                                ? showAccountDialog(
                                    context, AdminPaypal, 'Paypal')
                                : null;
                            data.documents[index]['sendingType'] == 'Bitcoin'
                                ? showAccountDialog(
                                    context, AdminBitcoin, 'Bitcoin')
                                : null;
                            data.documents[index]['sendingType'] == 'Ethereum'
                                ? showAccountDialog(
                                    context, AdminEthereum, 'Ethereum')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Western Union'
                                ? showAccountDialog(
                                    context, AdminWesternUnion, 'Western Union')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Transferencia en EUROS Union Europea'
                                ? showAccountDialog(
                                    context, AdminEuros, 'EUROS Union Europe')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Deposito o Transferencia en UNITED STATES USD'
                                ? showAccountDialog(
                                    context, AdminUSD, 'UNITED STATES USD')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Deposito o Transferencia en ESPANA EUR'
                                ? showAccountDialog(
                                    context, AdminESPANA_EUR, 'ESPANA EUR')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Deposito o Transferencia en COLOMBIA COP'
                                ? showAccountDialog(
                                    context, AdminCOLOMBIA_COP, 'COLOMBIA COP')
                                : null;
                            data.documents[index]['sendingType'] ==
                                    'Deposito o transferencia en PANAMA USD'
                                ? showAccountDialog(
                                    context, AdminPANAMA_USD, 'PANAMA USD')
                                : null;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
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
                              child: Row(
                                children: [
                                  Text(
                                    'Company Account Detail',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ])));
  }
}

Future showAccountDialog(context, String account, String accountType) async {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        /*Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
        });*/
        return Center(
            child: Container(
          width: 1750.0,
          height: 175.0,
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

//          Navigator.of(context, rootNavigator: true).pop('dialog');
