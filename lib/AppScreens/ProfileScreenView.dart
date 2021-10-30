// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:sqlite_app/AppScreens/EditFriendInfoButton.dart';
// import 'package:sqlite_app/AppScreens/FriendInfoTextWidget.dart';
// import 'package:sqlite_app/Database/dbhelper.dart';
// import 'package:sqlite_app/Model/userModel.dart';
//
// class ProfileScreenView extends StatefulWidget {
//   late UserModel userModel ;
//   ProfileScreenView(this.userModel);
//
//   @override
//   _ProfileScreenViewState createState() => _ProfileScreenViewState();
// }
//
// class _ProfileScreenViewState extends State<ProfileScreenView> {
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.userModel.firstName} ${widget.userModel.lastName} Info'),
//         backgroundColor: Colors.black12,
//       ),
//       body:SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Center(
//                 child: Image.file(
//                   File(widget.userModel.imagePath),
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               FriendInfoTextWidget('Name:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget('${widget.userModel.firstName} ${widget.userModel.lastName}',TextStyle(fontSize: 20, color: Colors.black)),
//               SizedBox(height: 20),
//               FriendInfoTextWidget('ID:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget(widget.userModel.id.toString(),TextStyle(fontSize: 20, color: Colors.black)),
//               SizedBox(height: 20),
//               FriendInfoTextWidget('Address:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget(widget.userModel.address,TextStyle(fontSize: 20, color: Colors.black)),
//               SizedBox(height: 20),
//               FriendInfoTextWidget('E-mail:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget(widget.userModel.email,TextStyle(fontSize: 20, color: Colors.black)),
//               SizedBox(height: 20),
//               FriendInfoTextWidget('Phone Number:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget(widget.userModel.phoneNum,TextStyle(fontSize: 20, color: Colors.black)),
//               SizedBox(height: 20),
//               FriendInfoTextWidget('Gender:',TextStyle(fontSize: 20, color: Colors.amberAccent,fontWeight: FontWeight.w700)),
//               SizedBox(height: 10),
//               FriendInfoTextWidget(widget.userModel.gender,TextStyle(fontSize: 20, color: Colors.black)),
//               Padding(
//                 padding:  EdgeInsets.symmetric(vertical: 16),
//                 child: Align(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     child: EditFriendInfoButton(widget.userModel)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }