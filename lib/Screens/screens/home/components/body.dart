import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/home/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:fringleapp/models/user_model.dart';
import 'featurred_drills.dart';
import 'header_with_seachbox.dart';
import 'recomend_drills.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  final User currentUser;
  Body(this.currentUser);

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          //TitleWithMoreBtn(title: "Featured Drills", press: () {}),
          //FeaturedDrills(),
          TitleWithMoreBtn(title: "Recommended Drills", press: () {}),
          RecomendsDrills(currentUser: currentUser,),

          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
