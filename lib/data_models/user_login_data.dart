class UserLoginData {
  late bool status ;
  late String? message ;
   UserData? data ;
  UserLoginData.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'] ;
    data = json['data'] != null ?  UserData.fromJson(json['data']) : null ;

  }
}

class UserData {
  late int id ;
  late String name ;
  late String phone ;
  late String email ;
  late String token ;
  late String image ;

  UserData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
    image = 'https://img.freepik.com/premium-photo/tiny-cute-adorable-animal_727939-188.jpg?size=338&ext=jpg&ga=GA1.2.190088039.1657057581';
    // json['image'];
  }
}