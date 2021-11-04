import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite_app/AppScreens/FormFieldItem.dart';
import 'package:sqlite_app/AppScreens/GenderDropdownWidget.dart';
import 'package:sqlite_app/AppScreens/MapScreenView.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Bloc/RecordAudioBloc.dart';
import 'package:sqlite_app/Bloc/UserBloc.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';
import 'package:validators/validators.dart' as validator;
import 'package:image_picker/image_picker.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //DbHelper? helper ;
  late UserBloc userBloc;
  bool imageIsValidate = true;
  late RecordAudioBloc recordAudioBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
    recordAudioBloc = RecordAudioBloc();
    recordAudioBloc.init();
    //helper = DbHelper();
  }
  @override
  void dispose() {
    recordAudioBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black12,
      ),
      body:Container(
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          child: SingleChildScrollView(
           // controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                signUpForm(),
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding , top: SizeConfig.padding/2 , bottom: SizeConfig.padding/2),
                  child: buildStart(),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding , top: SizeConfig.padding/2 , bottom: SizeConfig.padding/2),
                  child: ListTile(
                    tileColor: Colors.teal,
                    title:Text(AppLocalizations.of(context)!.selectYourLocation),
                    leading: Icon(Icons.location_history,color: Colors.white70,),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreenView(isMapView: false)));
                    },
                  ),
                ),
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: btnRegister()),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget signUpForm() {
    return Form(
      key: userBloc.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.padding),
          userBloc.imageFile == null
              ? Center(
                child: Column(
                 children: [
                  Container(
                  color: Colors.grey[500],
                  width: 100,
                  height: 100,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        userBloc.imageSelectorGallery();
                      },
                      icon: Icon(Icons.camera_alt),
                      color: Colors.white,
                    ),
                  ),
                ),
                imageIsValidate ? SizedBox():
                Text(AppLocalizations.of(context)!.photoValidation,style: TextStyle(color: Colors.red)),
              ],
            ),
          )
              : Center(
                child: CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(
                  userBloc.imageFile,
                  //scale: 1.0,
                  // width: 100,
                  // height: 100,
                  // fit: BoxFit.contain,
                ),
              )
          ),
          FormFieldItem(controller: userBloc.firstNameController, type: DefaultFormFieldType.FIRST_NAME, label: AppLocalizations.of(context)!.firstName, subject: userBloc.firstNameSubject),
          FormFieldItem(controller: userBloc.lastNameController, type: DefaultFormFieldType.LAST_NAME, label: AppLocalizations.of(context)!.lastName, subject: userBloc.lastNameSubject),
          FormFieldItem(controller: userBloc.emailController, type: DefaultFormFieldType.EMAIL, label: AppLocalizations.of(context)!.email, subject: userBloc.emailSubject),
          //FormFieldItem(controller: userBloc.addressController, type: DefaultFormFieldType.TEXT, label: AppLocalizations.of(context)!.address, subject: userBloc.addressSubject),
          FormFieldItem(controller: userBloc.phoneController, type: DefaultFormFieldType.PHONE, label: AppLocalizations.of(context)!.phone, subject: userBloc.phoneSubject),
          GenderDropdownWidget(userBloc.selectedGenderSubject),
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.address,
                ),
                StreamBuilder(
                    stream: LocationBloc.userMapAddressSubject.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Text(
                          snapshot.data.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.textFontSize,
                          ),
                        );
                      else
                        return SizedBox();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget btnRegister() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.padding, vertical: SizeConfig.padding),
      child:ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
        ),
        child:Container(
          child: Text(AppLocalizations.of(context)!.save),
        ),
        onPressed: (){
          if(userBloc.formKey.currentState!.validate()){
            if(userBloc.imageFile!=null){
              userBloc.addNewUser(recordAudioBloc.audioPathSubject.value);
              // int? id = await helper!.createUser(userBloc.addNewUser(),context);
              Navigator.of(context).pop();
            }
            else{
              setState(() {
                imageIsValidate = false;
              });
            }
          }

        },
      )
    );
  }

  Widget buildStart() {
    final isRecording = recordAudioBloc.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'Start';
    final primary = isRecording ? Colors.red : Colors.teal;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        //minimumSize: Size(175, 50),
        primary: primary,
        onPrimary: onPrimary,
      ),
      onPressed: () async {
        await recordAudioBloc.toggleRecording(DateTime.now().toString().replaceAll(RegExp(r'[^\w\s]+'),'_'));
        setState(() {
        });
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }



}