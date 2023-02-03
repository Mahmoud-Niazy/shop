import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_final/constants/constants.dart';
import 'package:shop_final/shop_cubit/shop_cubit.dart';

import '../functions/fucnctions.dart';
import '../shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: TextWith2Lan(
              en: 'Shop',
              ar: 'المتجر',
              enLan: enLan,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: enLan ? 'Home' : 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: enLan ? 'location' : 'الموقع',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: enLan? 'Carts' : 'المشتريات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label:enLan? 'Favorites' : 'المفضلة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: enLan ?'Settings' : 'الاعدادات',
              ),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index) {
              ShopCubit.get(context).Navigate(index);
            },
          ),
          body: ShopCubit.get(context)
              .screens[ShopCubit.get(context).currentIndex],
        );
      },
    );
  }
}
