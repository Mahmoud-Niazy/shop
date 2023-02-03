import 'package:shop_final/data_models/user_login_data.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates{}

class ChangePasswordVisibilityState extends LoginStates {}

class UserLoginLoadingState extends LoginStates{}
class UserLoginSuccessfullyState extends LoginStates{
  UserLoginData? userData ;
  UserLoginSuccessfullyState(this.userData);
}
class UserLoginErrorState extends LoginStates{}

class UploadUserDataToFirestoreLoadingState extends LoginStates{}
class UploadUserDataToFirestoreSuccessfullyState extends LoginStates{}
class UploadUserDataToFirestoreErrorState extends LoginStates{}

