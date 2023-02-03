import 'package:shop_final/data_models/change_password_data_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}

class GetHomeDataLoadingState extends ShopStates {}
class GetHomeDataSuccessfullyState extends ShopStates {}
class GetHomeDataErrorState extends ShopStates {}

class NavigateState extends ShopStates{}

class AddOrRemoveFavoritesLoadingState extends ShopStates {}
class AddOrRemoveFavoritesSuccessfullyState extends ShopStates {}
class AddOrRemoveFavoritesErrorState extends ShopStates {}

class AddOrRemoveCartsLoadingState extends ShopStates {}
class AddOrRemoveCartsSuccessfullyState extends ShopStates {}
class AddOrRemoveCartsErrorState extends ShopStates {}


class GetAllFavoritesLoadingState extends ShopStates {}
class GetAllFavoritesSuccessfullyState extends ShopStates {}
class GetAllFavoritesErrorState extends ShopStates {}

class GetAllCartsLoadingState extends ShopStates {}
class GetAllCartsSuccessfullyState extends ShopStates {}
class GetAllCartsErrorState extends ShopStates {}

class GetAllCategoriesLoadingState extends ShopStates {}
class GetAllCategoriesSuccessfullyState extends ShopStates {}
class GetAllCategoriesErrorState extends ShopStates {}


class UpdateUserDataLoadingState extends ShopStates {}
class UpdateUserDataSuccessfullyState extends ShopStates {}
class UpdateUserDataErrorState extends ShopStates {}

class GetUserDataLoadingState extends ShopStates {}
class GetUserDataSuccessfullyState extends ShopStates {}
class GetUserDataErrorState extends ShopStates {}

class ChangePasswordLoadingState extends ShopStates {}
class ChangePasswordSuccessfullyState extends ShopStates {
  ChangePasswordDataModel? changePasswordData ;
  ChangePasswordSuccessfullyState(this.changePasswordData);
}
class ChangePasswordErrorState extends ShopStates {}

class ChangePasswordVisibilityState extends ShopStates {}

class GetUserLocationLoadingState extends ShopStates{}
class GetUserLocationSuccessfullyState extends ShopStates{}
class GetUserLocationErrorState extends ShopStates{}

class GetProfileImageLoadingState extends ShopStates{}
class GetProfileImageSuccessfullyState extends ShopStates{}
class GetProfileImageErrorState extends ShopStates{}

class UploadProfileImageLoadingState extends ShopStates{}
class UploadProfileImageSuccessfullyState extends ShopStates{}
class UploadProfileImageErrorState extends ShopStates{}

class GetUserDataFromFirestoreLoadingState extends ShopStates {}
class GetUserDataFromFirestoreSuccessfullyState extends ShopStates {}
class GetUserDataFromFirestoreErrorState extends ShopStates {}

class UploadOrderLoadingState extends ShopStates{}
class UploadOrderSuccessfullyState extends ShopStates{}
class UploadOrderErrorState extends ShopStates{}

class DeleteDataLoadingState extends ShopStates{}
class DeleteDataSuccessfullyState extends ShopStates{}
class DeleteDataErrorState extends ShopStates{}



