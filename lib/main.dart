import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_final/dio_helper/dio.dart';
import 'package:shop_final/on_boarding/on_boarding.dart';
import 'package:shop_final/screens/login_screen.dart';
import 'package:shop_final/screens/shop_layout.dart';
import 'package:shop_final/shared_preferences/shared_preferences.dart';
import 'package:shop_final/shop_cubit/shop_cubit.dart';
import 'constants/constants.dart';

import 'login_cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await CasheHelper.Init();
  DioHelper.Init();
  Widget widget;
  if (CasheHelper.GetData(key: 'onBoarding')==true) {
    if (CasheHelper.GetData(key: 'token') != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoarding();
  }



  runApp(MyApp(widget));
  print(token);
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..GetHomeData()
            ..GetAllFavorites()
            ..GetAllCategories()
            ..GetUserData()
            ..GetAllCarts()
            // ..GetUserDataFromFirestore(uId:CasheHelper.GetData(key: 'uId') ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}



