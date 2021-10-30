import 'package:flutter/material.dart';
import 'package:untitled/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LOGIN' ,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.black,
                ),),
                SizedBox(
                  height: 20,),
                Text('login now to browse our hot offers' ,
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
                    preFix: Icons.lock_open_outlined,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'password is empty';
                      }
                    }
                ),
                SizedBox(
                  height:30,),
                defaultButton(
                  function: (){},
                  text: 'login ',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have account?'),
                    defaultTextButton(
                      function: (){},
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
  }
}
