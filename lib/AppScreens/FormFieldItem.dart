import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/Validation/Validation.dart';
import 'package:sqlite_app/localization/localizations.dart';
import 'package:validators/validators.dart' as validator;

enum DefaultFormFieldType {
  EMAIL,
  PASSWORD,
  NUMBER,
  TEXT,
  PHONE,
  MULTI_TEXT,
  USER_NAME,
  USER_NAME_OR_EMAIL,
  FIRST_NAME,
  LAST_NAME,
  SEARCH,
}


class FormFieldItem extends StatelessWidget {
  TextEditingController? controller;
  final DefaultFormFieldType type;
  String? label;
  BehaviorSubject subject;

  FormFieldItem ({
    required this.controller,
    required this.type,
    required this.label,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:  EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding , top: SizeConfig.padding/2 , bottom: SizeConfig.padding/2),
      child: StreamBuilder(
          stream: subject.stream,
          builder: (context, snapshot) {
            return TextFormField(
              controller: controller,
              keyboardType:  type == DefaultFormFieldType.MULTI_TEXT
                  ? TextInputType.multiline
                  : type == DefaultFormFieldType.PHONE ||
                  type == DefaultFormFieldType.NUMBER
                  ? TextInputType.phone
                  : type == DefaultFormFieldType.EMAIL
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              autofocus: true,
              onChanged: (String input) {
                subject.sink.add(input);
              },
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
                labelText: label,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                if (type == DefaultFormFieldType.EMAIL &&
                    (validator.isNull(value) ||
                        !validator.isEmail(value!))) {
                  return AppLocalizations.of(context)!.emailValidation;
                  /// username or email
                }
                else if (type ==
                    DefaultFormFieldType.USER_NAME_OR_EMAIL &&
                    (validator.isNull(value) ||
                        !validator.isLength(value!, 8, 50))) {
                  return AppLocalizations.of(context)!
                      .emailOrUserNameValidation;

                  ///=====================
                }
                else if (type ==
                    DefaultFormFieldType.PASSWORD &&
                    !Validations.validatePassword(value!)) {
                  return AppLocalizations.of(context)!.passwordValidation;

                  ///=====================
                }
                else if (type ==
                    DefaultFormFieldType.USER_NAME) {
                  if (validator.isNull(value) ||
                      validator.contains(value!, " ")) {
                    return AppLocalizations.of(context)!.userNameValidation;
                  } else if (Validations.isHasArabicChar(value)) {
                    return AppLocalizations.of(context)!
                        .userNameValidationArabic;
                  } else if (!validator.isLength(value, 8, 50)) {
                    return AppLocalizations.of(context)!.userNameValidation;
                  }

                  ///=====================

                }
                else if (type ==
                    DefaultFormFieldType.FIRST_NAME) {
                  if (validator.isNull(value) ||
                      validator.contains(value!, " ")) {
                    return AppLocalizations.of(context)!.pleaseEnter +
                        AppLocalizations.of(context)!.firstName;
                  } else if (!validator.isLength(value, 3, 50)) {
                    return AppLocalizations.of(context)!.nameValidation;
                  }

                  ///=====================

                }
                else if (type == DefaultFormFieldType.LAST_NAME) {
                  if (validator.isNull(value) ||
                      validator.contains(value!, " ")) {
                    return AppLocalizations.of(context)!.pleaseEnter +
                        AppLocalizations.of(context)!.lastName;
                  } else if (!validator.isLength(value, 3, 50)) {
                    return AppLocalizations.of(context)!.nameValidation;
                  }

                  ///=====================

                }
                else if (type == DefaultFormFieldType.PHONE &&
                    ( !Validations.isMobileNumberNotValid(value!) || !validator.isLength(value, 8, 11))) {
                  return AppLocalizations.of(context)!.phoneValidation;

                  ///=====================

                }
                else if (type ==
                    DefaultFormFieldType.MULTI_TEXT &&
                    (validator.isNull(value!.trim()) ||
                        !validator.isLength(value, 1, 150))) {
                  return AppLocalizations.of(context)!.pleaseEnter +
                      ' ' +
                      label!;
                } else if (type == DefaultFormFieldType.TEXT &&
                    (validator.isNull(value!.trim()) ||
                        !validator.isLength(value, 3, 50))) {
                  return AppLocalizations.of(context)!.pleaseEnter +
                      ' ' +
                      label!;
                }else if (type == DefaultFormFieldType.NUMBER &&
                    (validator.isNull(value!.trim()) ||
                        !validator.isLength(value, 1, 50))) {
                  return AppLocalizations.of(context)!.pleaseEnter +
                      ' ' +
                      label!;
                }

                return null;
              },
            );
          }
      ),
    );
  }
}

