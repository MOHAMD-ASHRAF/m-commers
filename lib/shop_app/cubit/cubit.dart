import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/cat_model.dart';
import 'package:untitled/models/shop_app/change_favourites_model.dart';
import 'package:untitled/models/shop_app/favourites_Model.dart';

import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';
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
Map<int , bool> favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value)
    {
    homeModel = HomeModel.fromJson(value.data);
      printFullTex(homeModel.toString());
    //  print(homeModel!.data.banners[0].image);
      print(homeModel!.status);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });
      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }
    ).catchError((error){
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }


  CateogriesModel ?cateogriesModel;
  void getCateogries(){
    DioHelper.getData(
      url: GET_CATEGORISES,
      token: token,
    ).then((value)
    {
      cateogriesModel = CateogriesModel .fromJson(value.data);
      emit(ShopSuccessCateogriesDataState());
    }
    ).catchError((error){
      emit(ShopErrorCateogriesDataState());
      print(error.toString());
    });
  }

  ChangeFavouritesModel ?changeFavouritesModel;

  void changeFavourites(int productId){
    favorites[productId] = favorites[productId] == true ? favorites[productId] == false : true ;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId,
        },
         token: token,
        ).then((value)
    {
      changeFavouritesModel =ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
          if(!changeFavouritesModel!.status){
         favorites[productId] = favorites[productId] == true ? favorites[productId] == false :favorites[productId]== true ;
          } else{
            getFavorites();
          }

          emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error){
      emit(ShopErrorChangeFavoritesState());
    });

  }

FavoritesModel ?favoritesModel ;

  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: GET_CATEGORISES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel .fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }
    ).catchError((error){
      emit(ShopErrorGetFavoritesState());
      print(error.toString());
    });
  }

  ShopLoginModel ?userModel ;

  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel  =  ShopLoginModel.fromJson(value.data);
      print(userModel!.data.name);
      emit(ShopSuccessUserDataState(userModel!));
    }
    ).catchError((error){
      emit(ShopErrorUserDataState());
      print(error.toString());
    });
  }


}