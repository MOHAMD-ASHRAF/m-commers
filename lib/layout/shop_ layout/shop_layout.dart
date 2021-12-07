import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/network/local/cache_helper.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';
import 'package:untitled/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shop_app/search/searchs_screen.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener:(context , state) {},
      builder: (context ,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('hi'),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, ShopSearchScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home_outlined)
                  ,label: 'home'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.apps)
                  ,label: 'categories'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.favorite_border)
                  ,label: 'favorites'
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.settings_sharp)
                  ,label: 'Setting'
              ),
            ],
          ),
        );
      },
    );
  }
}
