import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/layout/shop_%20layout/shop_layout.dart';
import 'package:untitled/layout/todo_layout/todo_layout.dart';
import 'package:untitled/modules/login/login_screen.dart';
import 'package:untitled/network/local/cache_helper.dart';
import 'package:untitled/network/remote/dio_helper.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shop_app/onBording/onbording_screen.dart';
import 'package:untitled/style/themes.dart';
import 'bloc_observer.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'modules/counter/counter_screen.dart';

import 'package:untitled/modules/second_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark =CacheHelper.getData(key:'isDark');
  Widget widget;

  bool? onBoarding =CacheHelper.getData(key: 'onBoarding');
  String? token =CacheHelper.getData(key: 'token') as String;

  if(onBoarding != null){
    if(token != null) widget= ShopLayout();
    else widget= ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
          isDark = false,widget
         // starWidget = widget,
      )
  );
}
class MyApp extends StatelessWidget {
  final  bool isDark;
  final Widget starWidget;
  MyApp(this.isDark , this.starWidget,);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (BuildContext context) =>NewsCubit()..getBusiness(),),
        BlocProvider( create: (BuildContext context) =>AppCubit()..changAppMode(
          fromShared: isDark,
        ),),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection: TextDirection.ltr,
                child: starWidget,
            ),
          );
        },
      ),
    );
  }
}