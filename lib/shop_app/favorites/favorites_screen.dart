import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/favourites_Model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';
import 'package:untitled/style/color.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context ,state) {},
      builder: (context ,state) {
        return ConditionalBuilder(
          condition:  state is! ShopLoadingGetFavoritesState,
         builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data.data[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:ShopCubit.get(context).favoritesModel!.data.data.length,
          ),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model , context)=>  Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      width: double.infinity,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(

                image:NetworkImage(model.product.image),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
              if( model.product.discount != 0)
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5 ,vertical: 2.5),
                    color: Colors.red,
                    child: Text(
                      model.product.discount ,style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),)
                )
            ],
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis ,
                  style: TextStyle(fontSize:  14, height: 1.3),),
                SizedBox(height: 5,),
                Spacer(),
                Row(
                  children: [
                    Text(model.product.price.toString(),
                      style: TextStyle(
                          fontSize:  12,
                          height: 1.3,
                          color: defaultColor),),
                    SizedBox(width: 30,),
                    if(model.product.oldPrice != 0)
                      Text(model.product.oldPrice.toString(),
                        style: TextStyle(
                          fontSize:  10,
                          height: 1.3,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavourites(model.product.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.product.id] == true ?
                        defaultColor : Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),


        ],

      ),
    ),
  );
}
