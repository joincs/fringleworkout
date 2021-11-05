import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/home/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:fringleapp/models/user_model.dart';



class DrillLibrary extends StatefulWidget {
  final User currentUser;
  DrillLibrary(this.currentUser);

  @override
  _DrillLibraryState createState() => _DrillLibraryState();
  }

  class _DrillLibraryState extends State<DrillLibrary> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      return Future.value(false);
    },
    child:Scaffold(
      body: Body(widget.currentUser),
    )
    );
  }
}
