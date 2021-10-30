import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite_app/AppScreens/EditFriendInfoButton.dart';
import 'package:sqlite_app/AppScreens/EditInfoTextFormField.dart';
import 'package:sqlite_app/AppScreens/FormFieldItem.dart';
import 'package:sqlite_app/AppScreens/FriendInfoTextWidget.dart';
import 'package:sqlite_app/AppScreens/SaveUpdatesButton.dart';
import 'package:sqlite_app/Bloc/UpdateInfoBloc.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';

import 'GenderDropdownWidget.dart';

class UpdatefriendInfoScreenView extends StatefulWidget {
  late UserModel userModel;
  UpdatefriendInfoScreenView(this.userModel);


  @override
  _UpdatefriendInfoScreenViewState createState() => _UpdatefriendInfoScreenViewState();
}

class _UpdatefriendInfoScreenViewState extends State<UpdatefriendInfoScreenView> {

  late UpdateInfoBloc updateInfoBloc;

  @override
  void initState() {
    super.initState();
    updateInfoBloc = UpdateInfoBloc(widget.userModel);
    updateInfoBloc.getFriendData();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editFriendInformation),
        backgroundColor: Colors.black12,
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: StreamBuilder(
                  stream: updateInfoBloc.imagePathSubject.stream,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Container(
                        color: Colors.grey[500],
                        width: 100,
                        height: 100,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              imageSelectorGallery();
                            },
                            icon: Icon(Icons.camera_alt),
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    else{
                      return Stack(
                        children: [
                          Image.file(
                            File(snapshot.data.toString()),
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400], shape: BoxShape.circle),
                              child: IconButton(icon: Icon(Icons.camera_alt, color: Colors.white,size: SizeConfig.iconSize), onPressed: () {
                                imageSelectorGallery();
                              },),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),
            ),
            Form(
              key: updateInfoBloc.formKey,
                child: Column(
              children: [
                FormFieldItem(controller: updateInfoBloc.firstNameController, type: DefaultFormFieldType.FIRST_NAME, label: AppLocalizations.of(context)!.firstName, subject: updateInfoBloc.firstNameSubject),
                FormFieldItem(controller: updateInfoBloc.lastNameController, type: DefaultFormFieldType.LAST_NAME, label: AppLocalizations.of(context)!.lastName, subject: updateInfoBloc.lastNameSubject),
                FormFieldItem(controller: updateInfoBloc.emailController, type: DefaultFormFieldType.EMAIL, label: AppLocalizations.of(context)!.email, subject: updateInfoBloc.emailSubject),
                FormFieldItem(controller: updateInfoBloc.addressController, type: DefaultFormFieldType.TEXT, label: AppLocalizations.of(context)!.address, subject: updateInfoBloc.addressSubject),
                FormFieldItem(controller: updateInfoBloc.phoneController, type: DefaultFormFieldType.PHONE, label: AppLocalizations.of(context)!.phone, subject: updateInfoBloc.phoneSubject),
              ],
            )),
            GenderDropdownWidget(updateInfoBloc.selectedGenderSubject),
            Padding(
              padding:  EdgeInsets.all( SizeConfig.padding),
              child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: SaveUpdatesButton(
                      (){
                        if(updateInfoBloc.formKey.currentState!.validate()){
                          updateInfoBloc.updateFriendInfo();
                          Navigator.of(context).pop();
                        }
                      }
                  )),
            ),
          ],
        ),
      ),
    );
  }

  imageSelectorGallery() async {
    var galleryFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    print(galleryFile!.path);
    setState(() {
      updateInfoBloc.imagePathSubject.sink.add(galleryFile.path);
    });
  }
}