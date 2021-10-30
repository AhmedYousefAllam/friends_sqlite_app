import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sqlite_app/AppScreens/CircularButtonWidget.dart';
import 'package:sqlite_app/AppScreens/FriendInfoScreenView.dart';
import 'package:sqlite_app/AppScreens/HomePageScreenView.dart';
import 'package:sqlite_app/AppScreens/ProfileScreenView.dart';
import 'package:sqlite_app/Bloc/GetAllUsefrsBloc.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:sqlite_app/localization/localizations.dart';

class AboutAppScreenView extends StatefulWidget {

  @override
  _AboutAppScreenViewState createState() => _AboutAppScreenViewState();
}

class _AboutAppScreenViewState extends State<AboutAppScreenView>{


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
        backgroundColor: Colors.black12,
      ),
      body:Container(),
    );
  }


}

