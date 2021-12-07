import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/cat_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';

class CateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context ,state) {},
      builder: (context ,state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).cateogriesModel!.data.data[index])  ,
            separatorBuilder: (context, index) => myDivider(),
            itemCount:ShopCubit.get(context).cateogriesModel!.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Image(image:
        NetworkImage(
            model.image
        ),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10,),
        Text(model.name,
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        Spacer(),
        IconButton(onPressed: (){},
          icon:Icon(Icons.arrow_forward_ios),
        )
      ],
    ),
  );
}
