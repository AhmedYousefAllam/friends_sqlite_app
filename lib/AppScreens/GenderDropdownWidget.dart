import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';

class GenderDropdownWidget extends StatelessWidget {
  late BehaviorSubject behaviorSubject;
  GenderDropdownWidget(this.behaviorSubject);

  List<String> gender = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:  EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding , top: SizeConfig.padding/2 , bottom: SizeConfig.padding/2),
      child: StreamBuilder(
          stream: behaviorSubject.stream,
          builder: (context, snapshot) {
            return DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
                labelText: AppLocalizations.of(context)!.selectGender,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              items: gender.map((e) {
                return DropdownMenuItem(
                    value: e,
                    child: Text(e));
              }).toList(),
              onChanged: (value) {
                behaviorSubject.sink.add(value);
              },
              value: behaviorSubject.value,

            );
          }
      ),
    );
  }
}


