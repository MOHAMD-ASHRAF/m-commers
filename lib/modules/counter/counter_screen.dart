import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class CounterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context ,state){
          if(state is CounterMinusState) print('state minus to ${state.counter}');
          if(state is CounterPlusState) print('state plus to ${state.counter}');
        },
        builder: (context ,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'count'
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: (){
                        CounterCubit.get(context).minus();
                      },
                      child: Text('mines',style: TextStyle(
                        color: Colors.white,
                      ),),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text('${CounterCubit.get(context).counter}',style: TextStyle(fontSize: 50),),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: (){
                        CounterCubit.get(context).plus();

                      },
                      child: Text('plus',style: TextStyle(
                        color: Colors.white,
                      ),),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

