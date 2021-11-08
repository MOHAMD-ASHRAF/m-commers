import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
         children: [
           Text('register now', style: TextStyle(
             fontSize: 30,
             fontWeight: FontWeight.bold,
             color: Colors.black,
           ),)
         ],
        ),
      ),
    );
  }
}
