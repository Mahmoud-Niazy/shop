class ChangePasswordDataModel {
  late bool status ;
  late String message ;

  ChangePasswordDataModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }
}