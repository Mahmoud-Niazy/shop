import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shop_final/constants/end_points.dart';
import 'package:shop_final/data_models/carts_data_model.dart';
import 'package:shop_final/data_models/categories_model.dart';
import 'package:shop_final/data_models/change_password_data_model.dart';
import 'package:shop_final/data_models/favorites_model.dart';
import 'package:shop_final/data_models/home_data.dart';
import 'package:shop_final/data_models/user_data_in_firestore.dart';
import 'package:shop_final/dio_helper/dio.dart';
import 'package:shop_final/screens/carts_screen.dart';
import 'package:shop_final/screens/your_location_screen.dart';
import 'package:shop_final/screens/favorites_screen.dart';
import 'package:shop_final/screens/home_screen.dart';
import 'package:shop_final/screens/settings_screen.dart';
import 'package:shop_final/shared_preferences/shared_preferences.dart';
import 'package:shop_final/shop_cubit/shop_states.dart';

import '../constants/constants.dart';
import '../data_models/user_login_data.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    YourLocationScreen(),
    CartsScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  Navigate(index) {
    currentIndex = index;
    emit(NavigateState());
  }

  HomeData? homeData;

  GetHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.GetData(
      url: HOME,
      token: token,
    ).then((value) {
      homeData = HomeData.fromJson(value.data);
      print(homeData!.data.banners[0].id);
      emit(GetHomeDataSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(GetHomeDataErrorState());
    });
  }

  AddRemoveFavorites({
    required int id,
  }) {
    homeData = null ;
    emit(AddOrRemoveFavoritesLoadingState());
    DioHelper.PostData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: token,
    ).then((value) {
      GetAllFavorites();
      GetHomeData();
      emit(AddOrRemoveFavoritesSuccessfullyState());
    }).catchError((error) {
      emit(AddOrRemoveFavoritesErrorState());
    });
  }

  FavoritesModel? favorites;

  GetAllFavorites() {
    emit(GetAllFavoritesLoadingState());
    DioHelper.GetData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favorites = FavoritesModel.fromJson(value.data);
      emit(GetAllFavoritesSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(GetAllFavoritesErrorState());
    });
  }

  CategoriesModel? categories;

  GetAllCategories() {
    emit(GetAllCategoriesLoadingState());
    DioHelper.GetData(
      url: CATEGORIES,
    ).then((value) {
      categories = CategoriesModel.fromJson(value.data);
      emit(GetAllCategoriesSuccessfullyState());
    }).catchError((error) {
      emit(GetAllCategoriesErrorState());
    });
  }

  AddOrRemoveInCart({
    required int pId ,
}) {
    homeData = null ;
    emit(AddOrRemoveCartsLoadingState());
    DioHelper.PostData(
      url: CART,
      token: token,
      data: {
        'product_id' : pId
      }
    ).then((value) {
      GetAllCarts();
      GetHomeData();
      emit(AddOrRemoveCartsSuccessfullyState());
    }).catchError((error) {
      emit(AddOrRemoveCartsErrorState());
    });
  }

  CartsDataModel? cartsData ;
  Map<String,dynamic> carts = {};
  GetAllCarts(){
    emit(GetAllCartsLoadingState());
    DioHelper.GetData
      (
      url: CART,
      token: token,
    )
    .then((value) {
      cartsData = CartsDataModel.fromJson(value.data);
      carts = value.data;
      emit(GetAllCartsSuccessfullyState());

    })
    .catchError((error){
      print(error);
      emit(GetAllCartsErrorState());
    });
  }

  DeleteCarts(){
    emit(DeleteDataLoadingState());
    DioHelper.DeleteData(url: DELETECARTS,token: token)
    .then((value) {
      emit(DeleteDataSuccessfullyState());
    })
    .catchError((error){
      emit(DeleteDataErrorState());
    });
  }
  UpdateUserData({
    required String name,
    required String email,
    required String phone,
    String? image,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.PutData(
      url: UPDATE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
      },
      token: token!,
    ).then((value) {
      GetUserData();
      emit(UpdateUserDataSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(UpdateUserDataErrorState());
    });
  }

  CloudUserData? cloudUserData;

  GetUserDataFromFirestore({
    required int uId,
  }) {
    emit(GetUserDataFromFirestoreLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc("$uId")
        .get()
        .then((value) {
      cloudUserData = CloudUserData.fromJson(value.data()!);
    }).then((value) {
      emit(GetUserDataFromFirestoreSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(GetUserDataFromFirestoreErrorState());
    });
  }

  UserLoginData? userData;

  GetUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.GetData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = UserLoginData.fromJson(value.data);
      emit(GetUserDataSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(GetUserDataErrorState());
    });
  }

  ChangePasswordDataModel? changePasswordData;

  ChangePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.PostData(
      url: CHANGEPASSWORD,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
      token: token,
    ).then((value) {
      changePasswordData = ChangePasswordDataModel.fromJson(value.data);
      emit(ChangePasswordSuccessfullyState(changePasswordData));
    }).catchError((error) {
      emit(ChangePasswordErrorState());
    });
  }

  bool isPassword1 = true;

  ChangePasswordVisiblity1() {
    isPassword1 = !isPassword1;
    emit(ChangePasswordVisibilityState());
  }

  bool isPassword2 = true;

  ChangePasswordVisiblity2() {
    isPassword2 = !isPassword2;
    emit(ChangePasswordVisibilityState());
  }

  UpdateDataInFirestore({
    required int uId,
    required String name,
    required String email,
    required String phone,
    required String image,
  }) {
    CloudUserData newUserData = CloudUserData(
      name: name,
      image: image,
      email: email,
      phone: phone,
      // longitude: longitude,
      // latitude: latitude,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc('$uId')
        .update(newUserData.toMap())
        .then((value) {
      print('Upload new Data');
    }).catchError((error) {
      print(error);
    });
  }

  File? image;

  var picker = ImagePicker();

  Future GetProfileImage() async {
    emit(GetProfileImageLoadingState());
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(GetProfileImageSuccessfullyState());
    } else {
      emit(GetProfileImageErrorState());
      print('No image selected');
    }
  }

  UploadProfileImage({
    required int uId,
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UploadProfileImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateDataInFirestore(
          uId: uId,
          name: name,
          email: email,
          phone: phone,
          image: value,
        );
        UpdateUserData(name: name, email: email, phone: phone, image: value);
      });

      emit(UploadProfileImageSuccessfullyState());
    }).catchError((error) {
      print(error);
      emit(UploadProfileImageErrorState());
    });
  }

  double latitude = 0;
  double longitude = 0;

  GetUserLocation(context) async {
    emit(GetUserLocationLoadingState());

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        emit(GetUserLocationErrorState());
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(GetUserLocationErrorState());
        return null;
      }
    }
    ;
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
    // CloudUserData userWithLocation = CloudUserData(
    //   name: userData!.data!.name,
    //   image: cloudUserData!.image,
    //   email: userData!.data!.email,
    //   phone: userData!.data!.phone,
    //   // longitude: _locationData.longitude!,
    //   // latitude: _locationData.latitude!,
    //   uId: ShopCubit.get(context).userData!.data!.id,
    // );
    FirebaseFirestore.instance
        .collection('users')
        .doc('${userData!.data!.id}')
        .collection('location')
        .add({
      'longitude': _locationData.longitude,
      'latitude': _locationData.latitude,
    }).then((value) {
      emit(GetUserLocationSuccessfullyState());
    }).catchError((error) {
      emit(GetUserLocationErrorState());
    });
    //     .doc("${ShopCubit
    //     .get(context)
    //     .userData!
    //     .data!
    //     .id}")
    //     .update(userWithLocation.toMap()).then((value){

    //
    // })
    // .catchError((error){

    //
    //   print(error);
    // });
    print(_locationData.latitude);
    print(_locationData.longitude);
  }


  Order(){
    emit(UploadOrderLoadingState());
    FirebaseFirestore
    .instance
        .collection('users')
        .doc('${CasheHelper.GetData(key: 'uId')}')
        .collection('orders')
        .add(carts)
    .then((value){
      emit(UploadOrderSuccessfullyState());
    })
    .catchError((error){
      emit(UploadOrderErrorState());
    });
  }
}
