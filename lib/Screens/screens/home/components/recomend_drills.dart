import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/details/details_screen.dart';
import 'package:fringleapp/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

class RecomendsDrills extends StatelessWidget {
  final User currentUser;

  const RecomendsDrills({
    Key key,
    this.currentUser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //color: Colors.red,
        child: StreamBuilder<QuerySnapshot>(

            stream: Firestore.instance
                .collection('DrillsLibrary')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError || !snapshot.hasData) {
                return Text('Something went wrong');
              }
              else {
                return ListView.builder(
                  //itemExtent: 0.0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return RecomendDrillCard(
                        image: snapshot.data.documents[index]['titleImage'],
                        title: "Samantha",
                        country: "Russia",
                        price: 440,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(currentUser,snapshot.data.documents[index]),
                            ),
                          );
                        },
                      );
                    });
              }
            }
        )
    );
  }


/*Row(
        children: <Widget>[
          RecomendDrillCard(
            image: "asset/images/image_1.png",
            title: "Samantha",
            country: "Russia",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(currentUser),
                ),
              );
            },
          ),
          RecomendDrillCard(
            image: "asset/images/image_2.png",
            title: "Angelica",
            country: "Russia",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsSpotShots(currentUser),
                ),
              );
            },
          ),
          RecomendDrillCard(
            image: "asset/images/image_3.png",
            title: "Samantha",
            country: "Russia",
            price: 440,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsStephCurryShootingDrills(currentUser),
                ),
              );

            },
          ),
        ],
      ),*/
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
            child: Container(child: Image.network(image),
          )
          )
        ],
      ),
    );
  }
}
