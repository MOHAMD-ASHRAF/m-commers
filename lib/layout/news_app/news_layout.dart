
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/modules/news_app/search/search_screen.dart';

import 'package:untitled/network/remote/dio_helper.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';

import 'cubit/cubit.dart';
class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit =NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('news app'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen(),);
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   DioHelper.getData(url: 'v2/top-headlines',
          //       query:{
          //        'country':'eg',
          //        'category':'business',
          //        'apiKey':'565f1b45f3e24efd9a43edcc9a1e6222',
          //       }).then((value) {
          //         print(value.data.toString());
          //   }).catchError((error){
          //     print(error.toString());
          //   });
          // },
          // child: Icon(Icons.add),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:  cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
