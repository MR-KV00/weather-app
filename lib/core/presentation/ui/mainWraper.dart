import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whater/core/presentation/wigets/bottom_nav.dart';
import 'package:whater/core/presentation/wigets/image_backround.dart';
import 'package:whater/feature/feature_bookMark/presentation/screens/book_mark_screen.dart';
import 'package:whater/feature/feature_whater/presentation/block/cw_status.dart';
import 'package:whater/feature/feature_whater/presentation/block/home_bloc.dart';
import 'package:whater/feature/feature_whater/presentation/screens/home_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  final PageController _pageController= PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    List<Widget> pageList =[
      const HomeScreen(),
      const BookMarkScreen()
    ];

    return  Scaffold(

      bottomNavigationBar: BottomNav(pageController: _pageController,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:AppBackground.getBackGroundImage(),
              fit: BoxFit.cover
          ),
        ),
        child: PageView(
          controller: _pageController,
          children: pageList,
        ),
      ),

    );
  }
}



