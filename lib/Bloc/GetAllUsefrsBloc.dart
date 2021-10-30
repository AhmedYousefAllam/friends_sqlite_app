import 'package:flutter/animation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';

class GetAllUsersBloc {

  BehaviorSubject<List<UserModel>> usersSubject = BehaviorSubject();
  DbHelper helper = DbHelper();
  late AnimationController animationController;
  late Animation degOneTranslationAnimation;

 getAllUsers()async{
   List<UserModel> users = await helper.dogs();
   print(users);
  usersSubject.sink.add(users);
}
getAllFriends()=> Stream.fromFuture(helper.getAllUsers());


  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.259779513;
    return degree / unitRadian;
  }
}