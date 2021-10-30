import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';
class UpdateInfoBloc {
  late UserModel userModel;
  UpdateInfoBloc(this.userModel);
  BehaviorSubject<String> firstNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> lastNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> phoneSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> addressSubject = BehaviorSubject.seeded("");
  BehaviorSubject<dynamic> selectedGenderSubject = BehaviorSubject.seeded("Male");
  BehaviorSubject<String> imagePathSubject = BehaviorSubject();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DbHelper helper = DbHelper();

  getFriendData(){
    firstNameSubject.sink.add(userModel.firstName);
    lastNameSubject.sink.add(userModel.lastName);
    emailSubject.sink.add(userModel.email);
    addressSubject.sink.add(userModel.address);
    phoneSubject.sink.add(userModel.phoneNum);
    selectedGenderSubject.sink.add(userModel.gender);
    imagePathSubject.sink.add(userModel.imagePath);
    firstNameController.text= userModel.firstName;
    lastNameController.text=userModel.lastName;
    emailController.text=userModel.email;
    addressController.text=userModel.address;
    phoneController.text=userModel.phoneNum;
  }

  updateFriendInfo(){
    UserModel updatedFriend = UserModel({
      'id':userModel.id,
      'firstName':firstNameSubject.value,
      'lastName':lastNameSubject.value,
      'email':emailSubject.value,
      'address' : addressSubject.value,
      'phoneNum':phoneSubject.value,
      'gender':selectedGenderSubject.value,
      'imagePath':imagePathSubject.value,
    });
    helper.updateUser(updatedFriend);
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
