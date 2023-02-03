import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_final/register_cubit/register_cubit.dart';
import 'package:shop_final/reusable_components/reusable_components.dart';
import 'package:shop_final/screens/login_screen.dart';

import '../register_cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is UserRegisterSuccessfullyState) {
            if (state.userRegister!.status) {
              Fluttertoast.showToast(
                  msg: state.userRegister!.message!,
                  backgroundColor: Colors.green);
              NavigateAndFinish(LoginScreen(), context);
            } else {
              Fluttertoast.showToast(
                  msg: state.userRegister!.message!,
                  backgroundColor: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register now ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                            }),
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
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        BuildTextFormField(
                          pIcon: Icons.lock_outline,
                          labelEn: 'Password',
                          labelAr: 'كلمة المرور',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be empty ';
                            }
                          },
                          controller: passwordController,
                          onPressedOnSIcon: () {
                            RegisterCubit.get(context)
                                .ChangePasswordVisiblity();
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          sIcon: RegisterCubit.get(context).isPassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BuildTextFormField(
                            pIcon: Icons.phone,
                            labelEn: 'Phone',
                            labelAr: 'الهاتف',
                            controller: phoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone can\'t be empty ';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        BuildButton(
                          labelEn: 'Register',
                          labelAr: 'انشاء حساب',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).UserRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );

                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
