import 'package:flutter/material.dart';
import 'package:untitled/layout/todo_layout/todo_layout.dart';
import 'package:untitled/shared/components/components.dart';
class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var textCont =TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultField(
                controller: textCont,
                type: TextInputType.emailAddress,
                label: 'email',
                preFix: Icons.email,
                validate: ( value){
                  if(value!.isEmpty){
                    return 'is empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              color: Colors.blueAccent,
              width: 100,
              height: 40,
              child: MaterialButton(
                child: Text('go'),
                  onPressed: (){
                  if(formKey.currentState!.validate()){
                    print(textCont.text);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeLayout()));
                  }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
