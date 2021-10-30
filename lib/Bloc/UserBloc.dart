import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Bloc/GetAllUsefrsBloc.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';
class UserBloc {
  var imageFile;
  BehaviorSubject<String> firstNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> lastNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> phoneSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> addressSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> imagePathSubject = BehaviorSubject.seeded("");
  BehaviorSubject<dynamic> selectedGenderSubject = BehaviorSubject.seeded("Male");
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  DbHelper helper = DbHelper();
 // late GetAllUsersBloc getAllUsersBloc = GetAllUsersBloc();


  imageSelectorGallery() async {
    var galleryFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    print(galleryFile!.path);
    imageFile = File(galleryFile.path) ;
    print(imageFile);
    imagePathSubject.sink.add(galleryFile.path);
  }
   addNewUser()async{
    UserModel userModel = UserModel({
      'firstName':firstNameSubject.value,
      'lastName':lastNameSubject.value,
      'address' :LocationBloc.userMapAddressSubject.value,
      'email':emailSubject.value,
      'phoneNum':phoneSubject.value,
      'gender':selectedGenderSubject.value,
      'imagePath':imagePathSubject.value,
      'userMapLat':LocationBloc.userMapLatSubject.value,
      'userMapLong':LocationBloc.userMapLongSubject.value

    });
   await helper.createUser(userModel);
    //getAllUsersBloc.getAllUsers();
    //helper.getAllUsers();
    // return userModel;
  }


  void dispose(){
    firstNameSubject.close();
    lastNameSubject.close();
    emailSubject.close();
    phoneSubject.close();
    addressSubject.close();
    selectedGenderSubject.close();
    imagePathSubject.close();
  }
}

// Stream<dynamic> get selectedGenderStream => selectedGenderSubject;

// final Map<String, bool> genderMap = {
//   "Male": true,
//   "Female": false
// };
//
// changeGender(var gender) {
//   _genderSubject.sink.add(genderMap[gender]!);
//   selectedGenderSubject.sink.add(gender);
// } // BehaviorSubject<bool> _genderSubject = BehaviorSubject.seeded(true);
