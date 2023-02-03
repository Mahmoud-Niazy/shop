import '../data_models/user_login_data.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class UserRegisterLoadingState extends RegisterStates{}
class UserRegisterSuccessfullyState extends RegisterStates{
  UserLoginData? userRegister ;
  UserRegisterSuccessfullyState(this.userRegister);
}
class UserRegisterErrorState extends RegisterStates{}

class ChangePasswordVisibilityState extends RegisterStates{}

