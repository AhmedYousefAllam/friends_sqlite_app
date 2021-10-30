import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite_app/AppScreens/FriendInfoScreenView.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';

class FriendInfo extends StatelessWidget {
  UserModel userModel ;
  LocationBloc locationBloc;
  FriendInfo(this.userModel,this.locationBloc);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical*30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.padding*2),
      ),
      // width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.all(SizeConfig.padding),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: FileImage(
                File(userModel.imagePath),
              ),
            ),
          ),
          Text('${userModel.firstName} ${userModel.lastName}',
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 18.0
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top:SizeConfig.padding/2),
            child: Text( '${((locationBloc.calculateDistance(locationBloc.currentLatSubject.value,locationBloc.currentLongSubject.value,userModel.userMapLat,userModel.userMapLong)).toInt()).toString()} Km from You'),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding / 1.5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FriendInfoScreenView(userModel)));
              },
              child: Text(
                "View All info",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.teal,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.textFontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
