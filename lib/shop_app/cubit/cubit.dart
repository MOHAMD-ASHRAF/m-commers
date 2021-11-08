import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/network/end_point.dart';
import 'package:untitled/network/remote/dio_helper.dart';
import 'package:untitled/shared/constant/constants.dart';
import 'package:untitled/shop_app/cateogries/cateogries_screen.dart';
import 'package:untitled/shop_app/cubit/states.dart';
import 'package:untitled/shop_app/favorites/favorites_screen.dart';
import 'package:untitled/shop_app/products/products_screen.dart';
import 'package:untitled/shop_app/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

static ShopCubit get(context)=> BlocProvider.of(context);
 int currentIndex =0;
 List<Widget> bottomScreen= [
   ProductsScreen(),
   CateogriesScreen(),
   FavoritesScreen(),
   SettingScreen()
 ];

 void changeBottom(int index){
   currentIndex = index;
   emit(ShopChangeBottomState());
 }


 HomeModel ?homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value)
    {
    homeModel = HomeModel.fromJson(value.data);
      printFullTex(homeModel.toString());
      print(homeModel!.status);
      emit(ShopSuccessHomeDataState());
    }
    ).catchError((error){
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }
}