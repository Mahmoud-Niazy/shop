import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reusable_components/reusable_components.dart';
import '../shop_cubit/shop_cubit.dart';
import '../shop_cubit/shop_states.dart';

class EditProfile extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessfullyState) {
          if (state.changePasswordData!.status) {
            Fluttertoast.showToast(
                msg: state.changePasswordData!.message,
                backgroundColor: Colors.green);
          } else {
            Fluttertoast.showToast(
                msg: state.changePasswordData!.message,
                backgroundColor: Colors.red);
          }
        }
        print(state);
      },
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userData!.data!.name;
        emailController.text = ShopCubit.get(context).userData!.data!.email;
        phoneController.text = ShopCubit.get(context).userData!.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null ,
              // &&
              // ShopCubit.get(context).cloudUserData != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit your profile',
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Stack(
                              //   alignment: Alignment.bottomRight,
                              //   children: [
                              //     // CircleAvatar(
                              //     //   radius: 60,
                              //     //   backgroundImage: ProfileImage(context),
                              //     // ),
                              //     CircleAvatar(
                              //       child: IconButton(
                              //         icon: Icon(Icons.edit),
                              //         onPressed: () {
                              //           ShopCubit.get(context)
                              //               .GetProfileImage()
                              //               .then((value) {})
                              //               .catchError((error) {
                              //             print(error);
                              //           });
                              //         },
                              //       ),
                              //       backgroundColor: Colors.blueAccent,
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 50,
                              ),
                              BuildTextFormField(
                                pIcon: Icons.person,
                                labelEn: 'Name',
                                labelAr: 'الاسم',
                                controller: nameController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name can\'t be empty ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              BuildTextFormField(
                                pIcon: Icons.email,
                                labelEn: 'Email',
                                labelAr: 'الايميل',
                                controller: emailController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email can\'t be empty ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              BuildTextFormField(
                                pIcon: Icons.phone,
                                labelEn: 'Phone',
                                labelAr: 'الهاتف',
                                type: TextInputType.phone,
                                controller: phoneController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone can\'t be empty ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              state is UpdateUserDataLoadingState ?
                              Center(child: CircularProgressIndicator())
                              :
                              BuildButton(
                                  labelEn: 'UPDATE',
                                  labelAr: 'تحديث',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopCubit.get(context).UpdateUserData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                      );
                                      // if (ShopCubit.get(context).image ==
                                      //     null) {
                                      //   ShopCubit.get(context).UpdateUserData(
                                      //     name: nameController.text,
                                      //     email: emailController.text,
                                      //     phone: phoneController.text,
                                      //   );
                                        // ShopCubit.get(context)
                                        //     .UpdateDataInFirestore(
                                        //   uId: ShopCubit.get(context)
                                        //       .userData!
                                        //       .data!
                                        //       .id,
                                        //   name: nameController.text,
                                        //   email: emailController.text,
                                        //   phone: phoneController.text,
                                        //   image: ShopCubit.get(context)
                                        //       .cloudUserData!
                                        //       .image,
                                        // );
                                      }
                                      // if (ShopCubit.get(context).image !=
                                      //     null) {
                                      //   ShopCubit.get(context)
                                      //       .UploadProfileImage(
                                      //     uId: ShopCubit.get(context)
                                      //         .userData!
                                      //         .data!
                                      //         .id,
                                      //     name: nameController.text,
                                      //     email: emailController.text,
                                      //     phone: phoneController.text,
                                      //   );
                                      // }
                                    // }
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: formKey1,
                          child: Column(
                            children: [
                              BuildTextFormField(
                                pIcon: Icons.lock_outline,
                                labelEn: 'Current Password',
                                labelAr: 'كلمة المرور الحالية',
                                controller: currentPasswordController,
                                isPassword: ShopCubit.get(context).isPassword1,
                                sIcon: ShopCubit.get(context).isPassword1
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                onPressedOnSIcon: () {
                                  ShopCubit.get(context)
                                      .ChangePasswordVisiblity1();
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Current Password can\'t be empty ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              BuildTextFormField(
                                pIcon: Icons.lock_outline,
                                labelEn: 'New Password',
                                labelAr: 'كلمة المرور الجديدة',
                                controller: newPasswordController,
                                isPassword: ShopCubit.get(context).isPassword2,
                                sIcon: ShopCubit.get(context).isPassword2
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                onPressedOnSIcon: () {
                                  ShopCubit.get(context)
                                      .ChangePasswordVisiblity2();
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'New Password can\'t be empty ';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              state is ChangePasswordLoadingState ?
                              Center(child: CircularProgressIndicator())
                              :
                              BuildButton(
                                  labelEn: 'Update Password',
                                  labelAr: 'تحديث كلمة المرور',
                                  onPressed: () {
                                    if (formKey1.currentState!.validate()) {
                                      ShopCubit.get(context).ChangePassword(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text);
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// ProfileImage(context) {
//   if (ShopCubit.get(context).image != null) {
//     return FileImage(ShopCubit.get(context).image!);
//   } else {
//     return NetworkImage(
//       ShopCubit.get(context).userData!.,
//     );
//   }
// }
