import 'package:flutter/material.dart';

class FriendInfoTextWidget extends StatelessWidget{
  late String text;
  TextStyle style;
  FriendInfoTextWidget(this.text,this.style);

  @override
  Widget build(BuildContext context) {
   return Text(
     text,
     maxLines: null,
     style: style,
   );
  }

}