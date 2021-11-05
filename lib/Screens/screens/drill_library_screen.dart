import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:fringleapp/util/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';
import 'details/details_screen.dart';

class DrillLibraryScreen extends StatefulWidget {
  final User currentUser;
  DrillLibraryScreen(this.currentUser);

  @override
  _DrillLibraryScreenState createState() => _DrillLibraryScreenState();
}

class _DrillLibraryScreenState extends State<DrillLibraryScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          elevation: 3,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Add a Drill',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('DrillsLibrary').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Text('Something went wrong');
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 7.0, right: 7),
                          child: Container(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              controller: _searchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Search BasketBall Drills",
                                filled: true,
                                fillColor: HexColor("#EFEDED"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: HexColor("#BEBEBE"),
                                  ),
                                ),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Lottie.asset("asset/lottie/filter.json",
                              width: 30),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Container(
                            child: Text(
                              "Available Drills",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.separated(
                              itemCount: snapshot.data.documents.length,
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemBuilder: (context, index) {
                                var drillsnapshot =
                                    snapshot.data.documents[index];
                                return Container(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                              widget.currentUser,
                                              snapshot.data.documents[index]),
                                        ),
                                      );
                                    },
                                    trailing: Icon(Icons.add),
                                    title: Text(
                                      drillsnapshot['dName'],
                                    ),
                                    subtitle: Text(drillsnapshot['dCat']),
                                  ),
                                );

                                // Container(
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(drillsnapshot['dName']),
                                //           Text(
                                //             drillsnapshot['dCat'],
                                //             style: TextStyle(fontSize: 10),
                                //           ),
                                //         ],
                                //       ),
                                //       Icon(Icons.add),
                                //     ],
                                //   ),
                                // );
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => DetailsScreen(
                                //             widget.currentUser,
                                //             snapshot.data.documents[index]),
                                //       ),
                                //     );
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(10.0),
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         image: DecorationImage(
                                //           colorFilter: ColorFilter.mode(
                                //               Colors.black.withOpacity(0.6),
                                //               BlendMode.darken),
                                //           image: NetworkImage(
                                //               drillsnapshot['dDetailImg']),
                                //           fit: BoxFit.cover,
                                //         ),
                                //       ),
                                //       width: 300,
                                //       height: 175,
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment: MainAxisAlignment.end,
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.only(
                                //                 bottom: 5.0, left: 10),
                                //             child: Text(
                                //               drillsnapshot['dName'],
                                //               style: TextStyle(
                                //                   color: Colors.white,
                                //                   fontSize: 18,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: const EdgeInsets.only(
                                //                 bottom: 20.0, left: 10),
                                //             child: Text(
                                //               drillsnapshot['dCat'],
                                //               style: TextStyle(
                                //                   color: Colors.white,
                                //                   fontSize: 12,
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),

                        // Container(
                        //   child: ListView.builder(
                        //     padding: EdgeInsets.zero,
                        //     shrinkWrap: true,
                        //     itemCount: snapshot.data.documents.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         title: Text(
                        //             snapshot.data.documents[index]['dName']),
                        //       );
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class RecomendDrillCard extends StatelessWidget {
  const RecomendDrillCard({
    Key key,
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
        //bottom: kDefaultPadding * 2.5,
      ),
      width: 173,
      height: 185,
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: press,
              child: Container(
                child: Image.network(image),
              ))
        ],
      ),
    );
  }
}

// Container(
//                           height: 200,
//                           child: ListView.builder(
//                               padding: EdgeInsets.zero,
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               itemCount: snapshot.data.documents.length,
//                               itemBuilder: (context, index) {
//                                 var drillsnapshot =
//                                     snapshot.data.documents[index];
//                                 return InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => DetailsScreen(
//                                               widget.currentUser,
//                                               snapshot.data.documents[index]),
//                                         ),
//                                       );
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           image: DecorationImage(
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.6),
//                                                 BlendMode.darken),
//                                             image: NetworkImage(
//                                                 drillsnapshot['dDetailImg']),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         width: 300,
//                                         height: 175,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 5.0, left: 10),
//                                               child: Text(
//                                                 drillsnapshot['dName'],
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 20.0, left: 10),
//                                               child: Text(
//                                                 drillsnapshot['dCat'],
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 12,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ));
//                               }),
//                         ),

// SingleChildScrollView(
//   //color: Colors.red,
//   child: StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection('DrillsLibrary').snapshots(),
//     builder:
//         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError || !snapshot.hasData) {
//         return Text('Something went wrong');
//       } else {
//         return ListView.builder(
//             //itemExtent: 0.0,
//             padding: EdgeInsets.zero,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             itemCount: snapshot.data.documents.length,
//             itemBuilder: (context, index) {
//               //                   Future<QuerySnapshot> _myDoc =  Firestore.instance.collection('product').getDocuments();
//               // List<DocumentSnapshot> _myDocCount = _myDoc.documents;
//               // print(_myDocCount.length);

//               Stream<QuerySnapshot> snapshots = Firestore.instance
//                   .collection('DrillsLibrary')
//                   .document(snapshot.data.documents[index]['id'])
//                   .collection("Approaches")
//                   .snapshots();

//               var drillsnapshot = snapshot.data.documents[index];
//               return ListTile(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetailsScreen(
//                           widget.currentUser,
//                           snapshot.data.documents[index]),
//                     ),
//                   );
//                 },
//                 title: Text(drillsnapshot['dName']),
//                 subtitle: Text(drillsnapshot['dCat']),
//               );
//               // return RecomendDrillCard(
//               //   image: snapshot.data.documents[index]['titleImage'],
//               //   title: "Samantha",
//               //   country: "Russia",
//               //   price: 440,
//               //   press: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //         builder: (context) => DetailsScreen(widget.currentUser,snapshot.data.documents[index]),
//               //       ),
//               //     );
//               //   },
//               // );
//             });
//       }
//     },
//   ),
// ),
