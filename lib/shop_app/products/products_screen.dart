import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/shop_app/cubit/cubit.dart';
import 'package:untitled/shop_app/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
       listener:(context, state){} ,
      builder: (context ,state) {
         return ConditionalBuilder(
             condition: ShopCubit.get(context).homeModel != null,
             builder:(context) => productsBuilder(ShopCubit.get(context).homeModel!),
             fallback:(context) => Center(child: CircularProgressIndicator()) ,
         );
        },
      );
  }
  Widget productsBuilder(HomeModel model) =>Column(
    children: [
       CarouselSlider(
           items: model.data.banners.map((e) => Image(
               image: NetworkImage('${e.image}'),
             width: double.infinity,
             fit: BoxFit.cover,)
           ).toList(),
           options: CarouselOptions(
             height: 250,
             initialPage: 0,
             viewportFraction: 1,
             enableInfiniteScroll: true,
             reverse: false,
             autoPlay: true,
             autoPlayInterval: Duration(seconds:  3),
             autoPlayAnimationDuration: Duration(seconds: 3),
             scrollDirection: Axis.horizontal,
           )),
    ],
  );
}
