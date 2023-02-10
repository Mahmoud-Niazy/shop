import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_final/go_to_our_location_screen/go_to_our_location_screen.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/shop_cubit/shop_cubit.dart';

import '../shop_cubit/shop_states.dart';

class YourLocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is GetUserLocationSuccessfullyState) {
          Fluttertoast.showToast(msg: 'Done', backgroundColor: Colors.green);
        }
        print(state);
      },
      builder: (context, state) {
        return Stack(
          children: [
            Image.asset(
              'assets/Teacher or worker next to globe with location pin.jpg',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConditionalBuilder(
                    condition: state is ! GetUserLocationLoadingState,
                    builder: (context)=> BuildButton(
                      labelEn: 'Enable us to get your location',
                      labelAr: 'اعطاء الاذن بالحصول علي موقعك',
                      onPressed: () {
                        ShopCubit.get(context).GetUserLocation();
                      },
                    ),
                    fallback: (context)=> CircularProgressIndicator(),
                  ),
                  if (state is GetUserDataLoadingState)
                    Center(child: CircularProgressIndicator()),
                  SizedBox(
                    height: 30,
                  ),
                  BuildButton(
                      labelEn: 'Our location',
                      labelAr: 'موقعنا علي الخريطه',
                      onPressed: () {
                        if (ShopCubit.get(context).latitude != 0 &&
                            ShopCubit.get(context).longitude != 0) {
                          Navigate(OurLocationScreen(), context);
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'You must enable us to get tour location',
                            desc: 'Please press on the upper button',
                            // btnCancelOnPress: () {
                            //   Navigator.pop(context);
                            // },
                          )..show();
                          // }
                          // GoToMaps();
                        }
                      }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// GoToMaps({double latitude = 31.2526279, double longitude = 30.9552814}) async {
//   String mapLocationUrl =
//       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//   final String encodedUrl = Uri.encodeFull(mapLocationUrl);
//   await launch(encodedUrl);
//   // if(await canLaunch(encodedUrl)){
//   //   await launch(encodedUrl);
//   // }
//   // else{
//   //   print('error');
//   // }
// }
