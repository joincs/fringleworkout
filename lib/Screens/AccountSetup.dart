import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fringleapp/Screens/screens/Tab.dart';
import 'package:fringleapp/util/color.dart';
import 'package:fringleapp/util/snackbar.dart';
import 'package:fringleapp/util/drop_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as i;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';


class Interest {
  final String name;

  Interest({
    this.name,
  });
}

class AccountSetup extends StatefulWidget {
  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  Map<String, dynamic> userData = {}; //user personal info
  String username = '';
  bool man = false;
  bool woman = false;
  bool select = true;
  bool imgupload = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selecteddate;
  TextEditingController dobctlr = new TextEditingController();
  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController phoneCtlr = new TextEditingController();
  //String ImageUrl;
  List<String> ImageUrl = ['', '', '', '', ''];

  bool checkedValue = true;
  //////////////////////////////////////

  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "BMW"),
    OptionItem(id: "2", title: "Mercedes"),
    OptionItem(id: "3", title: "Range Rover"),
    OptionItem(id: "4", title: "Audi"),
    OptionItem(id: "5", title: "Porsche"),
    OptionItem(id: "6", title: "Toyota"),
    OptionItem(id: "7", title: "Lexus"),
    OptionItem(id: "8", title: "Kia"),
    OptionItem(id: "9", title: "Hyundai"),
    OptionItem(id: "10", title: "Volkswagen"),
    OptionItem(id: "11", title: "mini Cooper")
  ]);
  OptionItem optionItemSelected =
      OptionItem(id: null, title: "Please Choose Car Brand");

  DropListModel dropListModel1 = DropListModel(
      [OptionItem(id: "1", title: "SUV"), OptionItem(id: "2", title: "Sedan")]);
  OptionItem optionItemSelected1 =
      OptionItem(id: null, title: "Please Choose Car Type");

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
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Setup Account",
              style: TextStyle(color: Colors.black),
            ),

            backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Verify Your Identity",
                    style: TextStyle(color: Colors.black),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Note: Upload Selfie with ID\n"
                        "Note: Upload ID i.e. driving license, passport or ID Card\n"
                        "Note: Enter All Fields",
                    style: TextStyle(color: secondryColor),
                  )),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .45,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 1.5,
                    crossAxisSpacing: 4,
                    padding: EdgeInsets.all(10),
                    children: List.generate(2, (index) {
                      return InkWell(
                        onTap: () =>
                            source(context, index, false),
                          child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // image: DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: CachedNetworkImageProvider(
                              //       widget.currentUser.imageUrl[index],
                              //     )),
                            ),
                            child: Stack(
                              children: <Widget>[
                            Align(
                            alignment: Alignment.topCenter,
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: ImageUrl[index] != null
                                      ? ImageUrl[index].toString()
                                      : 'https://firebasestorage.googleapis.com/v0/b/churpapp-675d2.appspot.com/o/87449e529e536129932639b4b7e3aee6.jpg?alt=media&token=45fa5b54-5666-4236-9ca8-9e55749b0c35',
                                  placeholder: (context, url) => Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 10,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        index == 0
                                            ? CachedNetworkImage(

                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    'https://firebasestorage.googleapis.com/v0/b/xchange-544bf.appspot.com/o/selfie.png?alt=media&token=a035a35e-8c6b-41f8-9805-de0c34b700d4',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    radius: 10,
                                                  ),
                                                ),
                                              )
                                            : CachedNetworkImage(

                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    'https://firebasestorage.googleapis.com/v0/b/xchange-544bf.appspot.com/o/id.png?alt=media&token=82c15ee8-24fa-4d28-b30c-fbfd31a00e8a',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    radius: 10,
                                                  ),
                                                ),
                                              ),

                                        /* Icon(
                                          Icons.error,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        Text(
                                          "Select Image",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )*/
                                      ],
                                    ),
                                  ),
                                ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      //width: 12,
                                      // height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primaryColor,
                                      ),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        /*onTap: () =>
                                            source(context, index, false),*/
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        ),
                      );
                    })),
              ),

              ListTile(
                title: Text(
                  "Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: nameCtlr,
                  cursorColor: primaryColor,
                  placeholder: "enter your name",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'UserName': text});
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: CupertinoTextField(
                  controller: phoneCtlr,
                  cursorColor: primaryColor,
                  placeholder: "enter your phone number",
                  padding: EdgeInsets.all(10),
                  onChanged: (text) {
                    userData.addAll({'phoneNumber': text});
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                child: Text(
                  "Select Date of Birth",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 20),
              ),
              Padding(
                  //padding: EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                      child: ListTile(
                    title: CupertinoTextField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      prefix: IconButton(
                        icon: (Icon(
                          Icons.calendar_today,
                          color: primaryColor,
                        )),
                        onPressed: () {},
                      ),
                      onTap: () => showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                child: GestureDetector(
                                  child: CupertinoDatePicker(
                                    backgroundColor: Colors.white,
                                    initialDateTime: DateTime(2000, 10, 12),
                                    onDateTimeChanged: (DateTime newdate) {
                                      setState(() {
                                        dobctlr.text = newdate.day.toString() +
                                            '/' +
                                            newdate.month.toString() +
                                            '/' +
                                            newdate.year.toString();
                                        selecteddate = newdate;
                                      });
                                    },
                                    maximumYear: 2002,
                                    minimumYear: 1800,
                                    maximumDate: DateTime(2002, 03, 12),
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                  onTap: () {
                                    print(dobctlr.text);
                                    Navigator.pop(context);
                                  },
                                ));
                          }),
                      placeholder: "DD/MM/YYYY",
                      controller: dobctlr,
                    ),
                  ))),
              SizedBox(
                height: 20,
              ),
              (dobctlr.text.length > 0) && (nameCtlr.text.length > 0) && (imgupload==true) && (phoneCtlr.text.length>0)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        primaryColor,
                                        primaryColor,
                                        primaryColor,
                                        primaryColor
                                      ])),
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                  child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () {
                            userData.addAll({'UserName': nameCtlr.text});
                            userData.addAll({
                              'user_DOB': "$selecteddate",
                              'age': ((DateTime.now()
                                          .difference(selecteddate)
                                          .inDays) /
                                      365.2425)
                                  .truncate(),
                            });
                            print(userData);

                            userData.addAll(
                              {
                                'Verification': 'Pending',
                                'maximum_distance': 20,
                              },
                            );
                            showWelcomDialog(context);
                            setUserData(userData);
                          },
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: MediaQuery.of(context).size.height * .065,
                              width: MediaQuery.of(context).size.width * .75,
                              child: Center(
                                  child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: secondryColor,
                                    fontWeight: FontWeight.bold),
                              ))),
                          onTap: () {
                            CustomSnackbar.snackbar(
                                "Please select one", _scaffoldKey);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future source(BuildContext context, int index, bool isProfilePicture) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text(
                  isProfilePicture ? "Update profile picture" : "Add pictures"),
              content: Text(
                "Select source",
              ),
              insetAnimationCurve: Curves.decelerate,
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          getImage(ImageSource.camera, index, context,
                              isProfilePicture);
                          return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                              ));
                        });
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_camera,
                          size: 28,
                        ),
                        Text(
                          " Camera",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),

                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          getImage(ImageSource.gallery, index, context,
                              isProfilePicture);
                          return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                              ));
                        });
                  },
                  child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          " Gallery",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),

                  ),
                ),
              ]);
        });
  }

  Future getImage(
      ImageSource imageSource, int index, context, isProfilePicture) async {
    PickedFile image = await ImagePicker().getImage(source: imageSource);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.original],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Selected Image',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        await uploadFile(
            await compressimage(croppedFile), index, isProfilePicture);
      }
    }
    Navigator.pop(context);
  }

  Future uploadFile(File image, int index, isProfilePicture) async {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${image.hashCode + randomNumber}/${image.hashCode}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) {
      storageReference.getDownloadURL().then((fileURL) async {
        ImageUrl[index] = fileURL.toString();
        if (index == 1) {

          userData.addAll({
            'Selfie': ImageUrl[0],
            'ID': ImageUrl[1]
          });
          imgupload=true;
        }


        try {
          if (isProfilePicture) {
            //currentUser.imageUrl.removeAt(0);
            //currentUser.imageUrl.insert(0, fileURL);
            //print("object");
            //await Firestore.instance
            //  .collection("Users")
            //.document(currentUser.id)
            //.setData({"Pictures": currentUser.imageUrl}, merge: true);
          } else {
            //await Firestore.instance
            //  .collection("Users")
            //.document(currentUser.id)
            // .setData(updateObject, merge: true);
            //widget.currentUser.imageUrl.add(fileURL);
          }
          if (mounted) setState(() {});
        } catch (err) {
          print("Error: $err");
        }
      });
    }
  }

  Future compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    // setState(() {

    return compressedImagefile;
    // });
  }
}


Future setUserData(Map<String, dynamic> userData) async {
  await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
    await Firestore.instance
        .collection("Users")
        .document(user.uid)
        .setData(userData, merge: true);
  });
}

Future showWelcomDialog(context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Tabbar()));
        });
        return Center(
            child: Container(
                width: 150.0,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      "asset/auth/verified.jpg",
                      height: 60,
                      color: primaryColor,
                      colorBlendMode: BlendMode.color,
                    ),
                    Text(
                      "You're in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 20),
                    )
                  ],
                )));
      });
}