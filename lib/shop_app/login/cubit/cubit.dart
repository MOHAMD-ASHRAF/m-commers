 import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/network/end_point.dart';
import 'package:untitled/network/remote/dio_helper.dart';
import 'package:untitled/shop_app/login/cubit/state.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  late ShopLoginModel loginModel;
  ShopLoginCubit() : super(ShopLoginInitialState());
 static ShopLoginCubit get(context) => BlocProvider.of(context);
 void userLogin({
  required String email,
   required String password,
}){
   emit(ShopLoginLoadingState());
   DioHelper.postData(
       url: LOGIN,
       data:{
         'email' : email,
         'password' :password,
       }).then((value) {
         print(value.data);
         print(value.data['message']);
         loginModel= ShopLoginModel.fromJson(value.data);
         print(loginModel.status);
         print(loginModel.message);
         print(loginModel.data.token);
         emit(ShopLoginSuccessState(loginModel));
         print(value);
   }).catchError((error){
     emit(ShopLoginErrorState(error.toString()));
     print(error.toString());
   });
 }
}