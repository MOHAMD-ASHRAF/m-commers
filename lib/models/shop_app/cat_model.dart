class CateogriesModel{
  late bool status;
  late CateogriesDataModel data;
  CateogriesModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data =CateogriesDataModel.fromJson(json['data']);
  }
}
class CateogriesDataModel{
  late int currentPage;
  late List<DataModel> data =[];
  CateogriesDataModel.fromJson(Map<String ,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }

}

class DataModel{
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String ,dynamic> json){
    id= json['id'];
    name = json['name'];
    image = json['image'];
  }
}