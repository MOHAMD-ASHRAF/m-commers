import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';

class SettingScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context , state)
      {
      if(state is ShopSuccessUserDataState)
      {
      nameController.text = state.loginModel.data.name;
      emailController.text =state.loginModel.data.email;
      phoneController.text =state.loginModel.data.phone;
      }

      },
      builder: (context , state) {
         var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data.name;
        emailController.text =model.data.email;
        phoneController.text =model.data.phone;
        return  ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DefaultField(
                    type: TextInputType.name,
                    controller: nameController ,
                    label: 'name',
                    preFix: Icons.person,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return('is empty');
                      }
                      return null;
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultField(
                    type: TextInputType.emailAddress,
                    controller: emailController ,
                    label: 'email',
                    preFix: Icons.email,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return('is empty');
                      }
                      return null;
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultField(
                    type: TextInputType.phone,
                    controller: phoneController ,
                    label: 'phone',
                    preFix: Icons.phone,
                    validate: (String? value){
                      if(value!.isEmpty){
                        return('is empty');
                      }
                      return null;
                    }
                )
              ],
            ),
          ),
          fallback: (context) =>  Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
}
