import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';

import 'screens/Tab.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  final User currentUser;
  Notifications(this.currentUser);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final db = Firestore.instance;
  CollectionReference matchReference;

  @override
  void initState() {
    matchReference = db
        .collection("Users")
        .document(widget.currentUser.id)
        .collection('Matches');

    super.initState();
    // Future.delayed(Duration(seconds: 1), () {
    //   if (widget.notification.length > 1) {
    //     widget.notification.sort((a, b) {
    //       var adate = a.time; //before -> var adate = a.expiry;
    //       var bdate = b.time; //before -> var bdate = b.expiry;
    //       return bdate.compareTo(
    //           adate); //to get the order other way just switch `adate & bdate`
    //     });
    //   }
    // });
    // if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');

    return WillPopScope(
        onWillPop: () async {
          _moveToScreen2(context, );
      // You can do some work here.
      // Returning true allows the pop to happen, returning false prevents it.
      return false;
    },
    child:Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Notification",
              style: TextStyle(color: secondryColor),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              //color: Colors.black,
              color: secondryColor,
              onPressed: () async {
              await Navigator.pop(context);
                await Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Tabbar()));
              },
            ),
            elevation: 0,
            backgroundColor: Colors.white),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: Text(
                //     'this week',
                //     style: TextStyle(
                //       color: primaryColor,
                //       fontSize: 18.0,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1.0,
                //     ),
                //   ),
                // ),
                StreamBuilder<QuerySnapshot>(
                    stream: matchReference
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                            child: Text(
                              "No Notification",
                              style: TextStyle(color: secondryColor, fontSize: 16),
                            ));
                      else if (snapshot.data.documents.length == 0) {
                        return Center(
                            child: Text(
                              "No Notification",
                              style: TextStyle(color: secondryColor, fontSize: 16),
                            ));
                      }
                      return Expanded(
                        child: ListView(
                          children: snapshot.data.documents
                              .map((doc) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: !doc.data['isRead']
                                        ? primaryColor.withOpacity(.15)
                                        : secondryColor
                                        .withOpacity(.15)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(5),
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: secondryColor,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(
                                        25,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        doc.data['pictureUrl'] ??
                                            "",
                                        fit: BoxFit.cover,
                                        useOldImageOnUrlChange: true,
                                        placeholder: (context, url) =>
                                            CupertinoActivityIndicator(
                                              radius: 20,
                                            ),
                                        errorWidget:
                                            (context, url, error) =>
                                            Icon(
                                              Icons.error,
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                    // backgroundImage:
                                    //     NetworkImage(
                                    //   widget.notification[index]
                                    //       .sender.imageUrl[0],
                                    // )
                                  ),
                                  title: Text(
                                      "You have matched with ${doc.data['userName'] ?? "__"}"),
                                  subtitle: Text(
                                      outputFormat.format(DateTime.parse(doc.data['timestamp'].toDate().toString())),style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 9.0,
                                    //fontWeight: FontWeight.w600,
                                  ),
                                  ),
                                  //  Text(
                                  //     "Now you can start chat with ${notification[index].sender.name}"),
                                  // "if you want to match your profile with ${notifications[index].sender.name} just like ${notifications[index].sender.name}'s profile"),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        !doc.data['isRead']
                                            ? Container(
                                          width: 40.0,
                                          height: 20.0,
                                          decoration:
                                          BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                30.0),
                                          ),
                                          alignment:
                                          Alignment.center,
                                          child: Text(
                                            'NEW',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight:
                                              FontWeight.bold,
                                            ),
                                          ),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    print(doc.data["Matches"]);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                              child:
                                              CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                AlwaysStoppedAnimation<
                                                    Color>(
                                                    Colors.white),
                                              ));
                                        });
                                    DocumentSnapshot userdoc = await db
                                        .collection("Users")
                                        .document(doc.data["Matches"])
                                        .get();
                                    if (userdoc.exists) {
                                      Navigator.pop(context);
                                      User tempuser =
                                      User.fromDocument(userdoc);



                                    }
                                  },
                                )
                              //  : Container()
                            ),
                          ))
                              .toList(),
                        ),
                      );
                    })
              ],
            ),
          ),
          ),
        ));
  }
  void _moveToScreen2(BuildContext context) async {
    await Navigator.pop(context);
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Tabbar()));
    /*await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));*/
  }

}
