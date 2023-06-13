import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_final/dio_helper/dio.dart';
import 'package:shop_final/constants/end_points.dart';
import 'package:shop_final/data_models/user_login_data.dart';
import '../data_models/user_data_in_firestore.dart';
import '../shared_preferences/shared_preferences.dart';
import '../shop_cubit/shop_cubit.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  ChangePasswordVisibility() {
    isPassword = !isPassword;
    emit(ChangePasswordVisibilityState());
  }

  UserLoginData? userData;

  UserLogin({
    required String email,
    required String password,
  }) {
    emit(UserLoginLoadingState());
    DioHelper.PostData(
      url: LOGIN,

      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      userData = UserLoginData.fromJson(value.data);
      emit(UserLoginSuccessfullyState(userData));
    }).catchError((error) {
      emit(UserLoginErrorState());
    });
  }

//   CloudUserData? cloudUserData;
//
//   UploadUserData(
//     context, {
//     required int uId,
//     required String name,
//     required String email,
//     required String phone,
//     required String image,
//     // required double longitude,
//     // required double latitude ,
//   }) {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc('${uId}')
//         .get()
//         .then((value) {
//       if (value.exists) {
//         ShopCubit.get(context)
//             .GetUserDataFromFirestore(uId: CasheHelper.GetData(key: 'uId'));
//       }
//
//       if (!value.exists) {
//         cloudUserData = CloudUserData(
//           name: name,
//           image: image,
//           email: email,
//           phone: phone,
//           // longitude: longitude,
//           // latitude: latitude,
//           uId: uId,
//         );
//         FirebaseFirestore.instance
//             .collection('users')
//             .doc("$uId")
//             .set(cloudUserData!.toMap())
//             .then((value) {
//           ShopCubit.get(context).GetUserData();
//           // ShopCubit.get(context).GetUserDataFromFirestore(
//           //   uId: CasheHelper.GetData(key: 'uId'),
//           // );
//
//         }).catchError((error) {
//           emit(UploadUserDataToFirestoreErrorState());
//         });
//
//         ShopCubit.get(context).GetUserDataFromFirestore(
//           uId: CasheHelper.GetData(key: 'uId'),
//         );
//         // ShopCubit.get(context).GetUserDataFromFirestore(
//         //     uId: CasheHelper.GetData(key: 'uId')
//         // );
//       }
//     });
//   }
}
