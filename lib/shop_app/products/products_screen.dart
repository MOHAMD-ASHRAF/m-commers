import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/cat_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';
import 'package:untitled/style/color.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
       listener:(context, state)
       {
         if(state is ShopSuccessChangeFavoritesState)
         {
           if(!state.model.status){
             showToast(text: state.model.message, state: ToastStates.ERROR);
           }
         }
       } ,
      builder: (context ,state) {
         return ConditionalBuilder(
             condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).cateogriesModel != null,
             builder:(context) => productsBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).cateogriesModel! , context),
             fallback:(context) => Center(child: CircularProgressIndicator()) ,
         );
        },
      );
  }
  Widget productsBuilder(HomeModel model ,CateogriesModel cateogriesModel , context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CarouselSlider(
             items: model.data.banners.map((e) => Image(
                 image: NetworkImage('${e.image == null ? e.image ='https://img.archiexpo.com/images_ae/photo-g/125975-15350211.jpg' : e.image = e.image } '),
               width: double.infinity,
               fit: BoxFit.cover,)
             ).toList(),
             options: CarouselOptions(
               height: 200,
               initialPage: 0,
               viewportFraction: 1,
               enableInfiniteScroll: true,
               reverse: false,
               autoPlay: true,
               autoPlayInterval: Duration(seconds:  3),
               autoPlayAnimationDuration: Duration(seconds: 3),
               scrollDirection: Axis.horizontal,
             )),
        SizedBox(height:  10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cateogries' ,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
              SizedBox(height:  5,),
              Container(
                height: 100,
                child: ListView.separated
                  (
                  physics: BouncingScrollPhysics(),
                  scrollDirection:  Axis.horizontal,
                    itemBuilder: (context , index) => buildCategoryItem(cateogriesModel.data.data[index] , context),
                    separatorBuilder: (context , index)=> SizedBox(width: 5,),
                    itemCount: cateogriesModel.data.data.length),
              ),
              SizedBox(height:  10,),
              Text('New product',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 /1.7,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:2,
            children:
              List.generate(model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index] ,context)
              ),

          ),
        )
      ],
    ),
  );
}

Widget buildGridProduct(ProductsModel model , context) => Container(
  color: Colors.white,
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,


    children: [

      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(

          image:NetworkImage('${model.image}',),

          width: double.infinity,

          height: 200,


        ),
        if(model.discount != 0)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5 ,vertical: 2.5),
          color: Colors.red,
         child: Text('DISCOUNT' ,style: TextStyle(
           fontSize: 10,
           color: Colors.white
         ),)
        )
        ],
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(model.name,

            maxLines: 2,

            overflow: TextOverflow.ellipsis ,

            style: TextStyle(fontSize:  14, height: 1.3),),
            SizedBox(height: 5,),

            Row(

              children: [

                Text('${model.price}\$',

                  style: TextStyle(

                      fontSize:  12,

                      height: 1.3,

                      color: defaultColor),),
                SizedBox(width: 30,),
                if(model.discount != 0)
                Text('${model.oldPrice}\$',
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
                    ShopCubit.get(context).changeFavourites(model.id);
                    print(model.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favorites[model.id] ==true ? defaultColor : Colors.grey,
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
);


Widget buildCategoryItem(DataModel model , context) =>  Stack(
  alignment: Alignment.bottomCenter,

  children: [
    Image(
      image: NetworkImage('${model.image}'),
      width: 100,
      height: 100,
      fit:  BoxFit.cover,
    ),
    Container(
      width: 100,
      color: Colors.black.withOpacity(0.6),
      child: Text(model.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center
        ,style:  TextStyle(
          color: Colors.white,
        ),),
    )
  ],
);


