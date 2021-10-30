// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
//
// class EditInfoTextFormField extends StatelessWidget{
//   late String label;
//   late TextEditingController controller;
//   late BehaviorSubject behaviorSubject;
// EditInfoTextFormField(this.label,this.controller,this.behaviorSubject);
//   @override
//   Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(27, 24, 27, 8),
//      child: StreamBuilder(
//        stream: behaviorSubject.stream,
//        builder: (context, snapshot) {
//          return TextFormField(
//            controller: controller,
//            decoration: InputDecoration(
//              enabledBorder: UnderlineInputBorder(
//                borderSide: BorderSide(color: Colors.yellow),
//              ),
//              focusedBorder: UnderlineInputBorder(
//                borderSide: BorderSide(color: Colors.yellow),
//              ),
//              border: UnderlineInputBorder(
//                borderSide: BorderSide(color: Colors.yellow),
//              ),
//              labelText: label,
//              floatingLabelBehavior: FloatingLabelBehavior.auto,
//            ),
//            onChanged: (newValue) {
//              behaviorSubject.sink.add(newValue);
//            },
//            autovalidateMode: AutovalidateMode.onUserInteraction,
//            // validator: (value) {
//            //   if (validator.isNull(value)) {
//            //     return "Enter Your first Name Correctly";
//            //   }
//            //   return null;
//            // },
//            autofocus: false,
//          );
//        }
//      ),
//    );
//   }
//
// }