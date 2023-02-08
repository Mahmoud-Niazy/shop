import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/screens/edit_profile.dart';
import 'package:shop_final/screens/login_screen.dart';
import 'package:shop_final/shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../functions/fucnctions.dart';
import '../shop_cubit/shop_cubit.dart';
import '../shop_cubit/shop_states.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null && ShopCubit.get(context).cloudUserData != null,
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: ProfileImage(context),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ShopCubit.get(context).userData!.data!.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ShopCubit.get(context).userData!.data!.email,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ShopCubit.get(context).userData!.data!.phone,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  BuildButton(
                      labelEn: 'Edit your profile',
                      labelAr: 'تعديل الحساب',
                      onPressed: () {
                        Navigate(EditProfile(), context);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  BuildButton(
                      labelEn: 'Sign out',
                      labelAr: 'تسجيل الخروج',
                      onPressed: () {
                        CasheHelper.RemoveData(key: 'token')
                            .then((value) async {
                          if (value) {
                            await CasheHelper.RemoveData(key: 'uId');
                            ShopCubit.get(context).userData = null;
                            ShopCubit.get(context).favorites = null;
                            ShopCubit.get(context).cloudUserData = null;
                            ShopCubit.get(context).homeData = null;
                            ShopCubit.get(context).cartsData = null;
                            ShopCubit.get(context).image = null ;
                            NavigateAndFinish(LoginScreen(), context);
                          }
                        });
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SwitchListTile(
                      title: TextWith2Lan(
                        enLan: enLan,
                        ar: 'عربي',
                        en: 'English',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: enLan,
                      onChanged: (value) {
                        setState(() {
                          enLan = value;
                          CasheHelper.SaveData(key: 'enLan', value: value);
                          ShopCubit.get(context).homeData = null ;
                          ShopCubit.get(context).cartsData = null ;
                          ShopCubit.get(context).favorites = null ;
                          ShopCubit.get(context).categories = null ;
                          ShopCubit.get(context).userData= null ;

                          ShopCubit.get(context).GetHomeData();
                          ShopCubit.get(context).GetAllCarts();
                          ShopCubit.get(context).GetAllFavorites();
                          ShopCubit.get(context).GetAllCategories();
                          print(enLan);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

ProfileImage(context) {
  if (ShopCubit.get(context).image != null) {
    return FileImage(ShopCubit.get(context).image!);
  } else {
    return NetworkImage(
      ShopCubit.get(context).cloudUserData!.image,
    );
    // if (ShopCubit.get(context).cloudUserData != null)
    //
    // return NetworkImage(
    //   'https://img.freepik.com/premium-photo/tiny-cute-adorable-animal_727939-188.jpg?size=338&ext=jpg&ga=GA1.2.190088039.1657057581',
    // );
  }
}
