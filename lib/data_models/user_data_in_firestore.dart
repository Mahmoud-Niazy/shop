class CloudUserData{
  late int uId ;
  late String name ;
  late String phone ;
  late String email ;
  late String image ;
  // late double latitude ;
  // late double longitude ;

  CloudUserData({
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    // required this.longitude,
    // required this.latitude,
    required this.uId,
});

  CloudUserData.fromJson(Map<String,dynamic>json){
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    // longitude = json['longitude'];
    // latitude = json['latitude'];
    uId = json['uId'];

  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name ,
      'uId' : uId ,
      'phone' : phone ,
      'email' : email ,
      'image' : image ,
      // 'latitude' : latitude ,
      // 'longitude' : longitude ,
    };
  }
}