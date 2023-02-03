class CartsDataModel{
  late bool status;
  CartsData? data ;

  CartsDataModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = json['data']!= null? CartsData.fromJson(json['data']) : null ;
  }
}

class CartsData{
  List <CartItemModel>cart_items = [];
  late dynamic total ;
  
  CartsData.fromJson(Map<String,dynamic>json){
    total= json['total'];
    json['cart_items'].forEach((element){
      cart_items.add(CartItemModel.fromJson(element));
    });

  }


}

class CartItemModel {
  late int id ;
  late int quantity;
  late CartsDataProduct product ;

  CartItemModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    quantity = json['quantity'];
    product = CartsDataProduct.fromJson(json['product']);
  }
}

class CartsDataProduct{
  late int id ;
  late dynamic price ;
  late dynamic oldPrice ;
  late dynamic discount ;
  late String name ;
  late String image ;
  late bool inFav ;
  late bool inCart ;

  CartsDataProduct.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
  }


}