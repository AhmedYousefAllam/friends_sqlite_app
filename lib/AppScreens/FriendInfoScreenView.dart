import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite_app/AppScreens/EditFriendInfoButton.dart';
import 'package:sqlite_app/AppScreens/FriendInfoTextWidget.dart';
import 'package:sqlite_app/Bloc/PlayAudioBloc.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';

class FriendInfoScreenView extends StatefulWidget {
  late UserModel userModel;
  FriendInfoScreenView(this.userModel);


  @override
  _FriendInfoScreenViewState createState() => _FriendInfoScreenViewState();
}

class _FriendInfoScreenViewState extends State<FriendInfoScreenView> {
  late PlayAudioBloc playAudioBloc;
  @override
  void initState() {
    super.initState();
    playAudioBloc = PlayAudioBloc();
    playAudioBloc.init();
    print('${widget.userModel.audioPath}paaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaath');
  }
  @override
  void dispose() {
    playAudioBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.userModel.id==1?"Your Profile":
            '${widget.userModel.firstName} ${widget.userModel.lastName} Info'),
        backgroundColor: Colors.black12,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.file(
                  File(widget.userModel.imagePath),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              FriendInfoTextWidget('Name:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget('${widget.userModel.firstName} ${widget.userModel.lastName}',TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: SizeConfig.safeBlockVertical*2),
              FriendInfoTextWidget('ID:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget(widget.userModel.id.toString(),TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: SizeConfig.safeBlockVertical*2),
              FriendInfoTextWidget('Address:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget(widget.userModel.address,TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: SizeConfig.safeBlockVertical*2),
              FriendInfoTextWidget('E-mail:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget(widget.userModel.email,TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: SizeConfig.safeBlockVertical*2),
              FriendInfoTextWidget('Phone Number:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget(widget.userModel.phoneNum,TextStyle(fontSize: 20, color: Colors.black)),
              SizedBox(height: SizeConfig.safeBlockVertical*2),
              FriendInfoTextWidget('Gender:',TextStyle(fontSize: 20, color: Colors.teal,fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.safeBlockVertical),
              FriendInfoTextWidget(widget.userModel.gender,TextStyle(fontSize: 20, color: Colors.black)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.padding),
                child: buildPlay(),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: SizeConfig.padding),
                child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: EditFriendInfoButton(widget.userModel)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlay() {
    final isPlaying = playAudioBloc.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'STOP' : 'Play';
    final primary = isPlaying ? Colors.red : Colors.teal;
    final onPrimary = isPlaying ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        //minimumSize: Size(175, 50),
        primary: primary,
        onPrimary: onPrimary,
      ),
      onPressed: () async {
        // await playAudioBloc.togglePlayStop(path: widget.friendsModel.audioPath, whenFinished: (){});
        await playAudioBloc.togglePlayStop(widget.userModel.audioPath);
        setState(() {
        });
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}