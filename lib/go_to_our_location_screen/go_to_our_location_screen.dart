import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_final/shop_cubit/shop_cubit.dart';

import '../shop_cubit/shop_states.dart';

class OurLocationScreen extends StatefulWidget {
  @override
  State<OurLocationScreen> createState() => _OurLocationScreenState();
}

class _OurLocationScreenState extends State<OurLocationScreen> {
  StreamSubscription<Position>? ps;

  @override
  void initState() {
    ShopCubit.get(context).addMarkerToShopLocation();
    ShopCubit.get(context).AddMarkerToUserLocation(
      lng: ShopCubit.get(context).longitude,
      lat: ShopCubit.get(context).latitude,
    );
    ps = Geolocator.getPositionStream().listen((Position? position) {
      ShopCubit.get(context).AddMarkerToUserLocation(
        lat: position!.latitude,
        lng: position.longitude,
      );
      print(position.longitude);
      print(position.latitude);

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                ShopCubit.get(context).latitude,
                ShopCubit.get(context).longitude,
              ),
              zoom: 7,
            ),
            // onTap: (LatLng position) {
            //   ShopCubit.get(context).AddMarkerToUserLocation(
            //     lat: position.latitude,
            //     lng: position.longitude,
            //   );
            // },
            markers: ShopCubit.get(context).markerAuto,
          ),
        );
      },
    );
  }
}
