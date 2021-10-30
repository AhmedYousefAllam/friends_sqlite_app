import 'package:flutter/widgets.dart';

class SizeConfig {
  static late  MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  // static double fontSize12;
  // static double fontSize13;
  // static double fontSize14;
  // static double fontSize15;
  // static double fontSize16;
  // static double fontSize17;
  // static double fontSize18;
  // static double fontSize20;
  // static double fontSize22;
  static late double titleFontSize;
  static late double textFontSize;
  static late double smallTextFontSize;
  static late double iconSize;
  static late double iconSizeSmall;
  static late double btnHeight;
  static late double padding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    // fontSize12 = safeBlockHorizontal * 2.75;
    // fontSize13 = safeBlockHorizontal * 3;
    // fontSize14 = safeBlockHorizontal * 3.75;
    // fontSize15 = safeBlockHorizontal * 4.5;
    // fontSize16 = safeBlockHorizontal * 5;
    // fontSize17 = safeBlockHorizontal * 6.5;
    // fontSize18 = safeBlockHorizontal * 8;
    // fontSize20 = safeBlockHorizontal * 10;
    // fontSize22 = safeBlockHorizontal * 12;

    titleFontSize = SizeConfig.safeBlockHorizontal * 4.5;
    textFontSize = SizeConfig.safeBlockHorizontal * 3.25;
    smallTextFontSize = SizeConfig.safeBlockHorizontal * 2.25;
    iconSize = SizeConfig.safeBlockHorizontal * 6;
    iconSizeSmall = SizeConfig.safeBlockHorizontal * 4;
    btnHeight = SizeConfig.safeBlockHorizontal * 10;
    padding = SizeConfig.safeBlockHorizontal * 4;
  }
}
