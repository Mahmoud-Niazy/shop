
class FavoritesModel {
  late bool status ;
   late FavoritesData data ;

  FavoritesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data=  FavoritesData.fromJson(json['data'])  ;

  }
}

class FavoritesData {
   List<FavoritesDataData> data =[] ;

  FavoritesData.fromJson(Map<String,dynamic>json){
    json['data'].forEach((element){
      data.add(FavoritesDataData.fromJson(element));
    });
  }
}

class FavoritesDataData {
  late int id ;
  late FavoritesDataDataProduct product ;

  FavoritesDataData.fromJson(Map<String,dynamic>json){
    id =json['id'];
    product = FavoritesDataDataProduct.fromJson(json['product']);
  }
}

class FavoritesDataDataProduct {
  late int id ;
  late dynamic price ;
  late dynamic oldPrice ;
  late dynamic discount ;
  late String image ;
  late String name ;

  FavoritesDataDataProduct.fromJson(Map<String,dynamic>json){
    id = json['id'] ;
    price = json['price'] ;
    oldPrice = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    name = json['name'] ;
  }
}