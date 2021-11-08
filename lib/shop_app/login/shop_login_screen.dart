import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_%20layout/shop_layout.dart';
import 'package:untitled/network/local/cache_helper.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/login/cubit/cubit.dart';
import 'package:untitled/shop_app/login/cubit/state.dart';
import 'package:untitled/shop_app/register/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit ,ShopLoginStates>(
          listener: (context,state){
            if(state is ShopLoginSuccessState){
              if(state.loginModel.status){
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value) {
                  navigateAndFinish(context, ShopLayout());
                });
                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCCESS,
                );
 
              }else{
                print(state.loginModel.message);
                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context ,state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN' ,
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),),
                        SizedBox(
                          height: 20,),
                        Text('Login now to browse our hot offers' ,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey,
                          ),),
                        SizedBox(
                          height: 40,),
                        DefaultField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            label: 'Email Address',
                            preFix: Icons.email_outlined,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'email is empty';
                              }
                            }
                        ),
                        SizedBox(
                          height: 30,),
                        DefaultField(
                            type: TextInputType.number,
                            controller: passwordController,
                            label: 'password',
                            preFix: Icons.lock,
                            sufFix: Icons.remove_red_eye_outlined,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'password is empty';
                              }
                            },
                          onSubmitted: (value){
                            ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        ),
                        SizedBox(
                          height:30,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder: (context) =>defaultButton(
                            function: (){
                             if(formKey.currentState!.validate()){
                               ShopLoginCubit.get(context).userLogin(
                                 email: emailController.text,
                                 password: passwordController.text,
                               );
                             }
                            },
                            text: 'login ',
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account?'),
                            defaultTextButton(
                                function: (){
                                  //navigateTo(context, RegisterScreen());
                                },
                                text: 'register'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
