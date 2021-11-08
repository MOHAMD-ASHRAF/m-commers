 import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:untitled/modules/todo_app/done_taskes/done_taskes_screen.dart';
import 'package:untitled/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:untitled/network/local/cache_helper.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());
 static AppCubit get(context) => BlocProvider.of(context);
  var currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> title = [
    'tasks home',
    'done home',
    'archived home',
  ];
  void changIndex(int index){
    currentIndex =index;
    emit(AppChangeNavBar());
  }
  Future<String> getData() async {
    return 'mohamed ashraf elhegawey';
  }
  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('database is created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT, data TEXT,time TEXT,status TEXT )')
              .then((value) {
            print('table created');
          }).catchError((e) {
            print('something error ${e.toString()}');
          });
        }, onOpen: (database) {
          print('database is opened');
          gitFromDataform(database);
        }).then((value){
          database =value;
          emit(AppCreateDataBaseState());
    });
  }

 insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
   await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, data ,time ,status) VALUES("$title","$date","$time","new")')
          .then((value){
        print('$value inserted successful');
        emit(AppInsertDataBaseState());
        gitFromDataform(database);
      }).catchError((e) {
        print('error when insert new ${e.toString()}');
      });
    });
  }
  void updateData({
  required String status,
    required int id,
}) {
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value)
      {
          gitFromDataform(database);
          emit(AppUpdateDataBaseState());
      });
  }
  void deleteData({
    required int id,
}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
    {
      gitFromDataform(database);
      emit(AppDeleteDataBaseState());
    });
  }

  void gitFromDataform(database){
    newTasks =[];
    doneTasks =[];
    archivedTasks = [];
    emit(AppGetLoadingDataBaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      tasks =value;
      print(value);
      tasks.forEach((element) {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] == 'done')
          doneTasks.add(element);
        else archivedTasks.add(element);
      });
    });
  }
  bool isBottomShown=false;
  IconData fabIcon=Icons.edit;

  void changeBottomSheet({
  required bool isShow,
    required  IconData icon,
}){
    isBottomShown=isShow;
    fabIcon= icon;
    emit(AppChangeBottomSheet());
  }

  bool isDark = false;
  void changAppMode({bool? fromShared}){
  if(fromShared !=null) {
    isDark = fromShared;
    emit(AppChangeModeState());
  } else {
    isDark =!isDark;
    CacheHelper.putBoolean(key:'isDark', value: isDark).then((value)
    {
      emit(AppChangeModeState());
    });
          }
      }
  }
