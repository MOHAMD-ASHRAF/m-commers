import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController =TextEditingController();
  var dateController =TextEditingController();
  var timeController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
       child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context , AppStates state){
          if(state is AppInsertDataBaseState){
            Navigator.pop(context);
          }
        },
         builder: (BuildContext context ,AppStates state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text( cubit.title[ cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetLoadingDataBaseState,
              builder: (context)=> cubit.screens[ cubit.currentIndex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if(cubit.isBottomShown) {
                  if (formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text);
                  }
                }
                else{
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                         child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultField(
                              controller: titleController,
                              label: 'task title',
                              preFix: Icons.title,
                              type: TextInputType.text,
                              validate: ( valve){
                                if(valve!.isEmpty)
                                {
                                  return 'is empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10,),
                            DefaultField(
                              redOnly: true,
                              onTap: (){
                                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                                    print(timeController.text=value!.format(context));
                                });
                              },
                              controller: timeController,
                              label: 'time date',
                              preFix: Icons.watch_later_outlined,
                              type: TextInputType.datetime,
                              validate: ( valve){
                                if(valve!.isEmpty)
                                {
                                  return 'is empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            DefaultField(
                              redOnly: true,
                              onTap: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year +5)).then((value) {
                                   dateController.text =DateFormat.yMMMd().format(value!);
                                });
                              },
                              controller: dateController,
                              label: 'date',
                              preFix: Icons.date_range,
                              type: TextInputType.datetime,
                              validate: ( valve){
                                if(valve!.isEmpty)
                                {
                                  return 'is empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).closed.then((value) {
                   cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                  cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.green,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_open_outlined), label: 'tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'archived'),
              ],
            ),
          );
         },
      ),
    );
  }


}


