import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/editProfile.dart';
import 'package:fringleapp/Screens/transaction_history_detail.dart';
import 'package:fringleapp/Screens/uploadReceiptDetail.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionHistory extends StatelessWidget {
  final User currentUser;
  TransactionHistory(this.currentUser);

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
              title: Text('All Transaction'),
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
        child: GestureDetector(
        onTap: () {

        Navigator.push(
        context,
        CupertinoPageRoute(
        builder: (context) => TransactionHistoryDetail(currentUser,data.documents[index]['TransactionID'])));
        },
        child:Card(
            child:
            new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(
                children: [
                  Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                'Transaction ID:\n'+data.documents[index]['TransactionNumber'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
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
                        /*data.documents[index]['TransactionStaus']=='Pending'
                            ?
                        Text('Please Upload Receipt/Screenshot of amount transfer to our account')
                            :
                        Text('Transaction Successfully Completed'),*/
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])
    )
    )
    );
  }
}
