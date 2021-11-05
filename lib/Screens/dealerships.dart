import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/editProfile.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class dealerships extends StatelessWidget {
  final User currentUser;
  dealerships(this.currentUser);

  @override
  Widget build(BuildContext context) {
    String dealerPhone='090078601';
    String dealerLocation='Al Fabi 10/20';
    String dealerName = "Alex Shop";
    String dealerEmail="test@gmail.com";
    String dealerImage = 'https://www.autoguide.com/blog/wp-content/uploads/2015/02/new-car-dealership.jpg';
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
          title: Text('Dealerships'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            //height: MediaQuery.of(context).size.height / 2,
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Column(
                      children: [
                        Container(
                          width: 120,
                          child: Center(
                            child: Text(
                              dealerName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Image.network(
                              dealerImage,
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            //margin: EdgeInsets.all(10),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {

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
                                    'Booking Now',
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
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: Color(0xFF307DF1),
                            ),
                            Text(dealerPhone),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 18,
                              color: Color(0xFF307DF1),
                            ),
                            Text(dealerEmail),
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
                            Text(dealerLocation),
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
                                String url = "tel:"+dealerPhone;
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
                    )
                  ],
                ),
              ),
              Divider(),
            ]),
          ),
        ),
      ),
    );
  }
}
