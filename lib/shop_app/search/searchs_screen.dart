import 'package:flutter/material.dart';

class ShopSearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
          child: Text('SearchScreen',
            style: Theme.of(context).textTheme.bodyText1
            ,)
      ),
    );
  }
}
