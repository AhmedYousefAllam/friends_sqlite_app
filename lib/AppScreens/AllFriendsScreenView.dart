import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'AboutAppScreenView.dart';
import 'package:sqlite_app/AppScreens/CircularButtonWidget.dart';
import 'package:sqlite_app/AppScreens/FriendInfoScreenView.dart';
import 'package:sqlite_app/AppScreens/HomePageScreenView.dart';
import 'package:sqlite_app/AppScreens/MapScreenView.dart';
import 'package:sqlite_app/AppScreens/ProfileScreenView.dart';
import 'package:sqlite_app/Bloc/GetAllUsefrsBloc.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';

class AllFriendsScreenView extends StatefulWidget {

  @override
  _AllFriendsScreenViewState createState() => _AllFriendsScreenViewState();
}

class _AllFriendsScreenViewState extends State<AllFriendsScreenView> with SingleTickerProviderStateMixin {

  late UserModel profileUserModel;
  late DbHelper helper;
   late GetAllUsersBloc getAllUsersBloc ;
   List<UserModel> allUserInApp = [];

  @override
  void initState() {
    super.initState();
     getAllUsersBloc = GetAllUsersBloc();
    getAllUsersBloc.animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    helper = DbHelper();
    // getAllUsersBloc.getAllUsers();

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.yourFriends),
        backgroundColor: Colors.black12,
      ),
      body:StreamBuilder(
        stream: getAllUsersBloc.getAllFriends(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  UserModel userModel = UserModel.fromMap(snapshot.data[index]);
                  allUserInApp.add(userModel);
                  if(userModel.id==1){
                    profileUserModel = userModel;
                    return Container();
                  }
                  else{
                    return Card(
                      elevation: 5.0,
                      margin: EdgeInsets.all(SizeConfig.padding/3),
                      color: Colors.white70,
                      child: ListTile(
                        title: Text(
                            '${userModel.firstName} ${userModel.lastName}'),
                        subtitle: Text(userModel.email),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              helper.deleteUser(userModel.id!);
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FriendInfoScreenView(userModel)));
                        },
                      ),
                    );}
                });

          } else {
            return Center(
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title: AppLocalizations.of(context)!.addNewFriends)));
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        animatedIcon: AnimatedIcons.menu_close,
        activeBackgroundColor:Colors.red,
        backgroundColor: Colors.teal,
        animationSpeed: 150,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            label: AppLocalizations.of(context)!.addNewFriends,
            onTap:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title: AppLocalizations.of(context)!.addNewFriends)));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.person_outline),
            label: "profile",
            onTap: () {
              if(profileUserModel.id==null){
                return;
              }
              else{
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FriendInfoScreenView(profileUserModel)));
              }
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.location_pin),
            label: "View All Friends Location",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapScreenView(allUsers:allUserInApp,isMapView: true)));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.help),
            label: "About App",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutAppScreenView()));
            },
          ),
        ],
      ),
    );
  }


}



//
// StreamBuilder(
// stream: getAllUsersBloc.usersSubject.stream,
// builder:(context ,AsyncSnapshot snapshot){
// print('${snapshot.data} hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
// if(!snapshot.hasData){
// return Center(child: CircularProgressIndicator());
// }
// else{
// return ListView.builder(
// itemCount: snapshot.data.length,
// itemBuilder: (context, index){
// //UserModel userModel = UserModel.fromMap(snapshot.data[index]);
// return Card(
// color: Colors.amberAccent,
// child: ListTile(
// title: Text(
// '${snapshot.data[index].firstName} ${snapshot.data[index].lastName}'
// ),
// subtitle: Text(
// 'ID : ${snapshot.data[index].id}'
// ),
// trailing: IconButton(
// icon: Icon(Icons.delete,color: Colors.red),
// onPressed: (){
// setState(() {
// helper.deleteUser(snapshot.data[index].id!);
// });
// },
// ),
// onTap: (){
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FriendInfoScreenView(snapshot.data[index])));
// },
// ),
// );
// });
// }
// },
// ),