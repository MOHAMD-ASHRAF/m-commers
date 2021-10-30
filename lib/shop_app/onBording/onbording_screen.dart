import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shop_app/login/shop_login_screen.dart';
import 'package:untitled/style/color.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});

}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'images/login.png',
        title: 'ON boarding 1 Title',
        body: 'ON boarding 1 Body'
    ),
    BoardingModel(
        image: 'images/login.png',
        title: 'ON boarding 2 Title',
        body: 'ON boarding 2 Body'
    ),
    BoardingModel(
        image: 'images/login.png',
        title: 'ON boarding 3 Title',
        body: 'ON boarding 3 Body'
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                navigateAndFinish(context, ShopLoginScreen());
              } ,
              child: Text('skip'),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    setState(() {
                      isLast =true;
                    });
                  }else{
                    setState(() {
                      isLast =false;
                    });
                  }
                },
                itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 50,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 3,
                      dotWidth: 10,
                      spacing: 7,
                    ),
                    count: boarding.length
                ),
                Spacer(),
                FloatingActionButton(
                 onPressed: (){
                   if(isLast){
                     navigateAndFinish(context, ShopLoginScreen());
                   }else{
                     boardController.nextPage(
                       duration: Duration(
                         milliseconds: 750,
                       ),
                       curve: Curves.fastLinearToSlowEaseIn,);
                   }
                 },
                 child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(height: 20,),
      Text(
        '${model.body}',style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      ),
    ],
  );
}