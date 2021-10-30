import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:untitled/modules/news_app/web_view/web_view.dart';
import 'package:untitled/shared/cubit/cubit.dart';

Widget defaultButton({
  VoidCallback? function,
   required String text,

}) => Container(
  width: double.infinity,
  height: 40,
  decoration: BoxDecoration(
    color: Colors.teal,
    borderRadius: BorderRadius.circular(10),
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(text.toUpperCase(),style: TextStyle(color: Colors.white),
    ),
  ),
);
Widget defaultTextButton({
  required VoidCallback? function,
  required String text,

})=> TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
);
Widget DefaultField(
    {
      required TextInputType type,
      required TextEditingController controller,
      FormFieldValidator<String>? validate,
      required String label,
      required IconData preFix,
      bool redOnly =false,
      GestureTapCallback? onTap,
      ValueChanged<String>? onChange,
    })=>TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      fontSize: 20,
     ),
    prefix: Icon(preFix),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(15),
      ),
    ),
  ),
    readOnly:  redOnly ,
    validator: validate,
   onTap: onTap,
  onChanged: onChange,
);

Widget buildTaskItem(Map model ,context)  =>Dismissible(
  key: Key(model['id'].toString()),
 onDismissed: (dirction){
 AppCubit.get(context).deleteData(id : model['id'],);
 },
  child:  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text('${model['time']}'),

        ),

        SizedBox(

          width: 15,

        ),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',

                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

              Text('${model['data']}',

                style: TextStyle(color: Colors.grey),)

            ],

          ),

        ),

        SizedBox(

          width: 10,

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateData(status: 'done', id: model['id'],);

          },

            icon: Icon(

                Icons.check_circle_outline,color: Colors.green,

            ),),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updateData(status: 'archived', id: model['id'],);

          },

          icon: Icon(

              Icons.archive_outlined,color: Colors.black54,

          ),)

      ],

    ),

  ),
);

Widget tasksBuilder({
   required List<Map> tasks,
}) =>ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=>ListView.separated(
      itemBuilder: (context , index)=> buildTaskItem(tasks[index] , context),
      separatorBuilder: (context , index)=> myDivider(),
      itemCount: tasks.length),
  fallback: (context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.hourglass_empty,
          size: 100,
          color: Colors.grey,),
        Text('No Tasks Yet,Pleas Add Some Tasks',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),),
      ],
    ),
  ),
);
Widget myDivider()=> Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: Container(
width: double.infinity,
height: 2,
color: Colors.grey[350],
),
);
Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                  '${article['urlToImage']== null ? article['urlToImage'] = 'https://www.generationsforpeace.org/wp-content/uploads/2018/07/empty.jpg?fbclid=IwAR1JQjvMOzlpOzIyPzGJIwRXJO1Pjau-Q_jCV08yAVlOidOykfIYOyjPdJc ':article['urlToImage'] =article['urlToImage'] }'
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4, overflow: TextOverflow.ellipsis,),
                ),
                Text('${article['publishedAt']}',

                  style: TextStyle(color: Colors.grey),)

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);
Widget articleBuilder(list,context, {isSearch =false})=> ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=> myDivider(),
      itemCount: 15),
  fallback: (context)=>isSearch ? Container(
    child: Center(child: Text('Nothing To Search YET',style: TextStyle(fontSize: 20,color: Colors.grey),)),
  ) : Center(child: CircularProgressIndicator()),);

void navigateTo(context , widget) => Navigator.push(
    context,
      MaterialPageRoute(
          builder: (context) =>widget,
      ),
);

void navigateAndFinish(context ,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
  builder: (context) =>widget,
),
        (Route<dynamic>  route) => false
);