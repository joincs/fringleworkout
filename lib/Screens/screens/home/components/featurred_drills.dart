import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/details/details_screen.dart';
import 'package:fringleapp/Screens/screens/home/components/recomend_drills.dart';
import 'package:fringleapp/models/user_model.dart';
import '../../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FeaturedDrills extends StatelessWidget {
  final User currentUser;

  const FeaturedDrills({
    Key key,
    this.currentUser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //scrollDirection: Axis.horizontal,
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
                  //physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
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
}

class FeatureDrillCard extends StatelessWidget {
  const FeatureDrillCard({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
