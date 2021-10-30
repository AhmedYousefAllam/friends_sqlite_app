import 'package:flutter/material.dart';
import 'package:sqlite_app/AppScreens/UpdateFriendInfoScreenView.dart';
import 'package:sqlite_app/Model/userModel.dart';

class EditFriendInfoButton extends StatelessWidget{
  late UserModel userModel;
  EditFriendInfoButton(this.userModel);
  // late String text;
  // TextStyle style;
  // EditFriendInfoButton(this.text,this.style);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      ),
        child:Container(
          child: Text('Edit Information'),
        ),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>UpdatefriendInfoScreenView(userModel)));
      },
    );
  }

}