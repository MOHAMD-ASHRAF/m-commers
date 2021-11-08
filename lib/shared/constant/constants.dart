import 'package:untitled/network/local/cache_helper.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/login/shop_login_screen.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullTex(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String token ='';