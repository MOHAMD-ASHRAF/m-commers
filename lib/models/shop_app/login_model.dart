class ShopLoginModel{
  late bool status;
  late String message;
  late UserData data;
  ShopLoginModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}
class UserData{
  late int id;
  late String name;
  late String phone;
  late String email;
  late String image;
  late String token;
//   UserData({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.image,
//     required this.token,
//     required this.email,
// });
  UserData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    email = json['email'];
  }
}
