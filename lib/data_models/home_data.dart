class HomeData {
  late bool status ;
  late HomeDataData data ;

  HomeData.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = HomeDataData.fromJson(json['data']);
  }
}

class HomeDataData {
List<BannersData> banners = [];
List<ProductsData> products = [];

HomeDataData.fromJson(Map<String,dynamic>json){
  json['banners'].forEach((element){
    banners.add(BannersData.fromJson(element));
  });
  json['products'].forEach((element){
    products.add(ProductsData.fromJson(element));
  });
}

}

class BannersData {
  late dynamic id ;
  late String image ;

  BannersData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductsData{
  late dynamic id ;
  late dynamic price ;
  late dynamic old_price ;
  late dynamic discount ;
  late String image ;
  late String name ;
  late bool in_favorites ;
  late bool in_cart ;
  // bool isFav = false;

  ProductsData.fromJson(Map<String,dynamic>json){
    id = json['id'] ;
    price = json['price'] ;
    old_price = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    name = json['name'] ;
    in_favorites = json['in_favorites'] ;
    in_cart = json['in_cart'] ;
    // isFav = json['isFav'] ;

  }
}