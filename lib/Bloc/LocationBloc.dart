import 'dart:math';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqlite_app/Database/dbhelper.dart';
import 'package:sqlite_app/Model/userModel.dart';
class LocationBloc {
  BehaviorSubject<Marker> userLocationMarkerSubject = BehaviorSubject();
  BehaviorSubject<double> currentLatSubject = BehaviorSubject();
  BehaviorSubject<double> currentLongSubject = BehaviorSubject();
 static BehaviorSubject<String> userMapAddressSubject = BehaviorSubject.seeded("");
  static BehaviorSubject<double> userMapLatSubject = BehaviorSubject();
  static BehaviorSubject<double> userMapLongSubject = BehaviorSubject();
  List<Marker> userLocationMarker =[];
  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();



  handleTap(LatLng tappedPoint){
      print('${tappedPoint}الابعاااااااااااااااااااااااااااااااااااااد');
      userLocationMarker = [];
      userLocationMarkerSubject.sink.add(
          Marker(
          markerId: MarkerId(
              tappedPoint.toString()
          ),
          position: tappedPoint
      ));
      userLocationMarker.add(userLocationMarkerSubject.value);
      userMapLatSubject.sink.add(tappedPoint.latitude);
      userMapLongSubject.sink.add(tappedPoint.longitude);
      getAddressFromLatLong(tappedPoint);
    }


  Future<void> getAddressFromLatLong(LatLng  position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    userMapAddressSubject.sink.add('${place.street},${place.administrativeArea},${place.country}');
    print('${userMapAddressSubject.value}العنواااااااااااااااااااان');
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      currentLatSubject.sink.add(position.latitude);
      currentLongSubject.sink.add(position.longitude);
    } catch (e) {
      print(e);
    }
  }


  // getUserLatLng() async {
  //   Position currentPosition = await _getGeoLocationPosition();
  //   currentLat = currentPosition.latitude;
  //   currentLong = currentPosition.longitude;
  // }
  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  void dispose(){
    userLocationMarkerSubject.close();
    userMapAddressSubject.close();
    userMapLatSubject.close();
    userMapLongSubject.close();
    currentLatSubject.close();
    currentLongSubject.close();
    customInfoWindowController.dispose();
  }
}
