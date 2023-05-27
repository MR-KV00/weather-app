
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class BottomNav extends StatelessWidget {
   PageController pageController;
     BottomNav({Key? key,required this.pageController}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return  BottomAppBar(
        notchMargin: 5,
        shape:const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child:  SizedBox(
          height: 63,
          child: Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: (){pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);},

                  icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: (){pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);},

                  icon: const Icon(Icons.bookmark)),
            ],
          ),
        ),
      );

    }
  }
