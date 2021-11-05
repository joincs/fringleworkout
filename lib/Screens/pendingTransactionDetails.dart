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

class pendingTransactionDetail extends StatelessWidget {
  final User currentUser;
  pendingTransactionDetail(this.currentUser);

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
              backgroundColor: Color(0xff0f74ff),
              title: Text('Pending Transaction'),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('Transaction')
                    .where('userID', isEqualTo: currentUser.id)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData || streamSnapshot.data==null || streamSnapshot.data.documents.length==0) {
                    return Center(
                      child: Text(
                        'No Record Found',style: TextStyle(color: Colors.black),
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
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:Card(
            child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Column(
                        children: [
                          Container(
                            width: 120,
                            child: Center(
                              child: Text(
                                data.documents[index]['sendingType'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 18,
                                color: Color(0xFF307DF1),
                              ),
                              Text(data.documents[index]['sendingType']),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later,
                                size: 18,
                                color: Color(0xFF307DF1),
                              ),
                              Text(data.documents[index]['receivingType']),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color(0xFF307DF1),
                              ),
                              Text(data.documents[index]['TransactionAmount']),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 18,
                                color: Color(0xFF307DF1),
                              ),
                              Text(data.documents[index]['TransactionReceivingAccount']),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  String homeLat = "37.3230";
                                  String homeLng = "-122.0312";

                                  String googleMapslocationUrl =
                                      "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";
                                  final String encodedURl =
                                  Uri.encodeFull(googleMapslocationUrl);

                                  if (await canLaunch(encodedURl)) {
                                    await launch(encodedURl);
                                  } else {
                                    print('Could not launch $encodedURl');
                                    throw 'Could not launch $encodedURl';
                                  }
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
                                            Color(0xff1087FF),
                                            Color(0xff1087FF),
                                          ])),
                                  //color: Colors.black,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Get Direction',
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
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String number = data.documents[index]['dealerPhone'];
                                  String url = "tel:" + number;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
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
                                            Color(0xff1087FF),
                                            Color(0xff1087FF),
                                          ])),
                                  //color: Colors.black,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Call Us',
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
                        ],
                      ),
                    ],
                  ),
                ]
            )
        )
    );
  }
}
