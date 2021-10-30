import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqlite_app/AppScreens/AllFriendsScreenView.dart';
import 'localization/LocaleHelper.dart';
import 'localization/localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpecificLocalizationDelegate _specificLocalizationDelegate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale('en'));
  }
  onLocaleChange(Locale locale) {
    if (this.mounted) {
      setState(() {
        _specificLocalizationDelegate =
        new SpecificLocalizationDelegate(locale);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        _specificLocalizationDelegate
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: _specificLocalizationDelegate.overriddenLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllFriendsScreenView(),
    );
  }
}

