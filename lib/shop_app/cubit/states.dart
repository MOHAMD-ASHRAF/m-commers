import 'package:untitled/models/shop_app/change_favourites_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCateogriesDataState extends ShopStates{}

class ShopErrorCateogriesDataState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);

}

class ShopErrorUserDataState extends ShopStates{}


