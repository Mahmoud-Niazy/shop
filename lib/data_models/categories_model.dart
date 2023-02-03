class CategoriesModel {
  late bool status ;
  late CategoriesData data ;

  CategoriesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData {
  late int currentPage ;
  List<CategoriesDataData> data = [];

  CategoriesData.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(CategoriesDataData.fromJson(element));
    });
  }
}

class CategoriesDataData {
  late int id ;
  late String name ;
  late String image ;

  CategoriesDataData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}