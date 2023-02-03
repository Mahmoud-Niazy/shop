import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_final/constants/end_points.dart';
import 'package:shop_final/data_models/user_login_data.dart';
import 'package:shop_final/dio_helper/dio.dart';
import 'package:shop_final/register_cubit/register_states.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  UserLoginData? userRegister ;
  UserRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(UserRegisterLoadingState());
    DioHelper.PostData(
        url: REGISTER,
        data: {
          'name' : name ,
          'phone' : phone ,
          'email' : email ,
          'password' : password,
        },
    ).then((value) {
      userRegister = UserLoginData.fromJson(value.data);
      // UploadUserData(
      //   uId: userRegister!.data!.id,
      //   name: name,
      //   email: email,
      //   phone: phone,
      //   image: userRegister!.data!.image,
      //   longitude: '',
      //   latitude: '',
      // );
      emit(UserRegisterSuccessfullyState(userRegister));
    })
    .catchError((error){
      emit(UserRegisterErrorState());
    });
  }

  bool isPassword = true ;
  ChangePasswordVisiblity(){
    isPassword = !isPassword ;
    emit(ChangePasswordVisibilityState());
  }





}