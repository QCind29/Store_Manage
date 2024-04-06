import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'Page/Home/Home.dart';
import 'Page/Product/Product_Page.dart';
import 'Provider/Note/NoteProvider.dart';
import 'Provider/Note/ProductProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
    ],
    child: MaterialApp(
        title: "Kim Bao",
        home: AnimatedSplashScreen(
        duration: 3000,
        splash: Icon(Icons.store_mall_directory_rounded, color: Colors.white,),
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.lightBlueAccent))
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final List<Widget> listBody = [
    const Product_Page(),
    // const Home_Activity()
    const Home()
  ];

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => NoteProvider(),
    //     builder: (context, child){
    return Scaffold(
      body: listBody[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_sharp), label: 'Danh sách'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Ghi chú')
          // BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Danh mục')
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );

    // const MaterialApp(
    // home: Home_Activity(),
  }
}
