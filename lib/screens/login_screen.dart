import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_final/constants/constants.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/screens/register_screen.dart';
import 'package:shop_final/screens/shop_layout.dart';
import 'package:shop_final/shared_preferences/shared_preferences.dart';
import 'package:shop_final/shop_cubit/shop_cubit.dart';

import '../functions/fucnctions.dart';
import '../login_cubit/login_cubit.dart';
import '../login_cubit/login_states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessfullyState) {
          if (state.userData!.status) {
            CasheHelper.SaveData(key: 'uId', value: state.userData!.data!.id);
            uId = CasheHelper.GetData(key: 'uId');
            // LoginCubit.get(context).UploadUserData(
            //   context,
            //   uId: state.userData!.data!.id,
            //   name: state.userData!.data!.name,
            //   email: state.userData!.data!.email,
            //   phone: state.userData!.data!.phone,
            //   image: state.userData!.data!.image,
            //   // longitude: 0,
            //   // latitude: 0,
            // );

            CasheHelper.SaveData(
                key: 'token', value: state.userData!.data!.token);
            token = CasheHelper.GetData(key: 'token');
            ShopCubit.get(context).GetUserData();
            ShopCubit.get(context).GetHomeData();
            ShopCubit.get(context).GetAllCarts();
            ShopCubit.get(context).GetAllFavorites();
            Fluttertoast.showToast(
              msg: state.userData!.message!,
              backgroundColor: Colors.green,
            ).then((value) {
              NavigateAndFinish(ShopLayout(), context);
            });
          } else {
            Fluttertoast.showToast(
              msg: state.userData!.message!,
              backgroundColor: Colors.red,
            );
          }
        }
        print(state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // title: Row(
            //   children: [
            //     TextWith2Lan(
            //       enLan: enLan,
            //       ar: 'عربي',
            //       en: 'English',
            //       style: TextStyle(
            //         fontSize: 15,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Switch(
            //       value: enLan,
            //       onChanged: (value) {
            //         setState(() {
            //           enLan = value;
            //           print(enLan);
            //         });
            //       },
            //     ),
            //   ],
            // ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWith2Lan(
                        enLan: enLan,
                        ar: 'تسجيل الدخول',
                        en: 'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextWith2Lan(
                        enLan: enLan,
                        ar: 'سجل الان لتحصل علي العروض الجديدة',
                        en: 'Login now to browse new offers',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BuildTextFormField(
                        pIcon: Icons.email_outlined,
                        labelEn: 'Email',
                        labelAr: 'الايميل',
                        controller: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return enLan
                                ? 'Email can\'t be empty '
                                : 'الايميل فارغ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BuildTextFormField(
                        pIcon: Icons.lock_outline,
                        labelEn: 'Password',
                        labelAr: 'كلمة المرور',
                        controller: passwordController,
                        isPassword: LoginCubit.get(context).isPassword,
                        onPressedOnSIcon: () {
                          LoginCubit.get(context).ChangePasswordVisibility();
                        },
                        sIcon: LoginCubit.get(context).isPassword == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return enLan
                                ? 'Password can\'t be empty '
                                : 'كلمة المرور فارغة';
                          }
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      BuildButton(
                        labelEn: 'LOGIN',
                        labelAr: 'تسجيل الدخول',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (state is UserLoginLoadingState)
                        Center(child: CircularProgressIndicator()),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          TextWith2Lan(
                            enLan: enLan,
                            ar: 'ليس لديك حساب ؟',
                            en: 'Don\'t have an account ? ',
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          BuildTextButton(
                            labelEn: 'Register now',
                            labelAr: 'انشاء حساب جديد',
                            onPressed: () {
                              Navigate(RegisterScreen(), context);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// Solution(context){
//   if(  ShopCubit.get(context).cloudUserData == null ){
//     ShopCubit.get(context).GetUserDataFromFirestore(uId: CasheHelper.GetData(key: 'uId'));
//   }
// }

//
// Solution(value ,state ,context){
//   if (value.data() == null) {
//     LoginCubit.get(context).UploadUserData(
//       uId: state.userData!.data!.id,
//       name: state.userData!.data!.name,
//       email: state.userData!.data!.email,
//       phone: state.userData!.data!.phone,
//       image: ShopCubit.get(context).cloudUserData == null
//           ? state.userData!.data!.image
//           : ShopCubit.get(context).cloudUserData!.image,
//       // longitude: 0,
//       // latitude: 0,
//     );
//     ShopCubit.get(context).GetUserDataFromFirestore(
//         uId: CasheHelper.GetData(key: 'uId'));
//   }
//   else {
//     ShopCubit.get(context).GetUserDataFromFirestore(
//         uId: CasheHelper.GetData(key: 'uId'));
//   }
// }
// ImageS(context){
//   if(ShopCubit.get(context).cloudUserData == null){
//     return LoginCubit.get(context).userData!.data!.image;
//   }
//   else{
//     return ShopCubit.get(context).cloudUserData!.image;
//   }
//

// }

//
// Check(uId,Function f,context){
//   FirebaseFirestore.instance.collection('users')
//       .doc(uId)
//       .get()
//       .then((value){
//         if(value == null){
//           f;
//           NavigateAndFinish(ShopLayout(), context);
//
//         }
//   });
// }
