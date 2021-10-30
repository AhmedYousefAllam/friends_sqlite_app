import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqlite_app/AppScreens/FriendInfoDialog.dart';
import 'package:sqlite_app/Bloc/LocationBloc.dart';
import 'package:sqlite_app/Model/userModel.dart';
import 'package:sqlite_app/Utilitis/SizeConfig.dart';
import 'package:sqlite_app/localization/localizations.dart';
import 'package:custom_info_window/custom_info_window.dart';


class MapScreenView extends StatefulWidget {
  List<UserModel>? allUsers;
  late bool isMapView = false;
  MapScreenView({this.allUsers,required this.isMapView});

  @override
  _MapScreenViewState createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView>{
 late LocationBloc locationBloc ;


  @override
  void initState() {
    super.initState();
    locationBloc = LocationBloc();
    locationBloc.getCurrentLocation();
    if(widget.isMapView){
      for(int i = 0 ; i < widget.allUsers!.length; i++) {
        widget.allUsers![i].id == 1 ? null :
        locationBloc.userLocationMarker.add(Marker(
            markerId: MarkerId(LatLng(widget.allUsers![i].userMapLat,widget.allUsers![i].userMapLong).toString()),
            position: LatLng(widget.allUsers![i].userMapLat,widget.allUsers![i].userMapLong),
          onTap: (){
            locationBloc.customInfoWindowController.addInfoWindow!(
              FriendInfo(widget.allUsers![i],locationBloc),
              LatLng(widget.allUsers![i].userMapLat,widget.allUsers![i].userMapLong),
            );

          }
        ));
        print(LatLng(widget.allUsers![i].userMapLat,widget.allUsers![i].userMapLong));
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title:widget.isMapView?Text("All Friends Locations"):Text(AppLocalizations.of(context)!.selectYourLocation),
        backgroundColor: Colors.black12,
      ),
      body:StreamBuilder(
        stream: locationBloc.userLocationMarkerSubject.stream,
        builder: (context, snapshot) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(	30.033333,31.233334),
                  zoom: 10,
                ),
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                markers:Set.from(locationBloc.userLocationMarker),
                onCameraMove: (position) {
                  locationBloc.customInfoWindowController.onCameraMove!();
                },
                onTap: widget.isMapView?  (position){
                  locationBloc.customInfoWindowController.hideInfoWindow!();
                } : locationBloc.handleTap,
                onMapCreated: (GoogleMapController controller) {
                  locationBloc.customInfoWindowController.googleMapController = controller;
                },


              ),
              CustomInfoWindow(
                controller: locationBloc.customInfoWindowController,
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.safeBlockHorizontal *40,
                offset: 50,
              ),
              !widget.isMapView
                  ? Positioned(
                   top: 13,
                   child: StreamBuilder(
                    stream: LocationBloc.userMapAddressSubject.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return Container(
                          width: SizeConfig.safeBlockHorizontal * 65,
                          height: SizeConfig.safeBlockVertical * 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.teal,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text('Selected Location :',
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('${snapshot.data.toString()}',
                                    style: TextStyle(
                                        color: Colors.white),
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      else
                        return SizedBox();
                    }),
              )
                  : SizedBox(),

            ],
          );
        }
      ),
    );
  }

  // showUserInfo(UserModel userModel){
  //   showDialog(
  //       context: context ,
  //       builder: (BuildContext context){
  //         return FriendInfo(userModel,locationBloc) ;
  //       }
  //   );
  // }

}

