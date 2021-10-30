import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/modules/news_app/business/business_screen.dart';
import 'package:untitled/modules/news_app/science/science_screen.dart';
import 'package:untitled/modules/news_app/sports/sports_screen.dart';
import 'package:untitled/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit () : super (NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
 List<BottomNavigationBarItem> bottomItems =[
   BottomNavigationBarItem(
       icon: Icon(Icons.business),
       label: 'business'),
   BottomNavigationBarItem(
       icon: Icon(Icons.sports),
       label: 'sports'),
   BottomNavigationBarItem(
       icon: Icon(Icons.science_outlined),
       label: 'science'),

 ];

 List<Widget> screens=[
   BusinessScreen(),
   SportsScreen(),
   ScienceScreen(),
 ];

 void changeBottomNavBar(index){
   currentIndex= index;
   if(index ==1)
     getSports();
   if(index ==2)
     getScience();
   emit(NewsBottomNavState());
 }

 List<dynamic> business=[];

 void getBusiness(){
   emit(NewsGetBusinessLodingState());
   DioHelper.getData(url:'v2/top-headlines',
       query:{
         'country':'eg',
         'category':'business',
         'apiKey':'565f1b45f3e24efd9a43edcc9a1e6222',
       }).then((value) {
         business=value.data['articles'];
         print(business[0]['title']);
     //print(value.data.toString());
     emit(NewsGetBusinessSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState());
   });
 }


  List<dynamic> sports=[];

  void getSports(){
    emit(NewsGetSportsLodingState());
    if(sports.length == 0){
      DioHelper.getData(url: 'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'sports',
            'apiKey':'565f1b45f3e24efd9a43edcc9a1e6222',
          }).then((value) {
        sports=value.data['articles'];
        print(sports[0]['title']);
        //print(value.data.toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState());
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science=[];

  void getScience(){
    emit(NewsGetScienceErrorState());
    if(science.length == 0){
      DioHelper.getData(url: 'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'science',
            'apiKey':'565f1b45f3e24efd9a43edcc9a1e6222',
          }).then((value) {
        science=value.data['articles'];
        print(science[0]['title']);
        //print(value.data.toString());
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState());
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search=[];

  void getSearch(String value){

    emit(NewsGetSearchLodingState());
    DioHelper.getData(url: 'v2/everything',
        query:{
          'q':'$value',
          'apiKey':'565f1b45f3e24efd9a43edcc9a1e6222',
        }).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      //print(value.data.toString());
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState());
    });

  }

}


