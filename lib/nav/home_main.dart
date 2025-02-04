import 'package:ease/nav/bookings.dart';
import 'package:ease/nav/profile.dart';
import 'package:ease/nav/saved.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

import '../classes/app_color.dart';
import 'home.dart';

class HomeMain extends StatefulWidget {
  final int pg;
  const HomeMain({required this.pg, super.key});

  @override
  State<HomeMain> createState() => _State();
}

class _State extends State<HomeMain> {

  int hamIndex = 0;
  int tabIndex = 0;

  Color c1 = AppColor.colorApp;
  Color c2 = AppColor.colorAppGray;
  Color c3 = AppColor.colorAppGray;
  Color c4 = AppColor.colorAppGray;

  var screens = [
    const Home(),
    const Saved(),
    const Bookings(),
    const Profile(),
  ];

  @override
  void initState() {
    setState(() {
      hamIndex = widget.pg;
      if(hamIndex == 0){
        c1 = AppColor.colorApp;
        c2 = AppColor.colorAppGray;
        c3 = AppColor.colorAppGray;
        c4 = AppColor.colorAppGray;
      } else if(hamIndex == 1){
        c1 = AppColor.colorAppGray;
        c2 = AppColor.colorApp;
        c3 = AppColor.colorAppGray;
        c4 = AppColor.colorAppGray;
      } else if(hamIndex == 2){
        c1 = AppColor.colorAppGray;
        c2 = AppColor.colorAppGray;
        c3 = AppColor.colorApp;
        c4 = AppColor.colorAppGray;
      } else if(hamIndex == 3){
        c1 = AppColor.colorAppGray;
        c2 = AppColor.colorAppGray;
        c3 = AppColor.colorAppGray;
        c4 = AppColor.colorApp;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (b, v) {
        if (!b) {
          MoveToBackground.moveTaskToBack();
          return;
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: hamIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.colorApp,
          unselectedItemColor: AppColor.colorAppGray,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/home.png', color: c1, width: 24, height: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/saved.png', color: c2, width: 24, height: 24),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/booking.png', color: c3, width: 16, height: 24),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/profile.png', color: c4, width: 24, height: 24),
              label: 'Profile',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: hamIndex,
          onTap: (index) {
            setState((){
              hamIndex = index;
              if(hamIndex == 0){
                c1 = AppColor.colorApp;
                c2 = AppColor.colorAppGray;
                c3 = AppColor.colorAppGray;
                c4 = AppColor.colorAppGray;
              } else if(hamIndex == 1){
                c1 = AppColor.colorAppGray;
                c2 = AppColor.colorApp;
                c3 = AppColor.colorAppGray;
                c4 = AppColor.colorAppGray;
              } else if(hamIndex == 2){
                c1 = AppColor.colorAppGray;
                c2 = AppColor.colorAppGray;
                c3 = AppColor.colorApp;
                c4 = AppColor.colorAppGray;
              } else if(hamIndex == 3){
                c1 = AppColor.colorAppGray;
                c2 = AppColor.colorAppGray;
                c3 = AppColor.colorAppGray;
                c4 = AppColor.colorApp;
              }
            });
          },
        ),
      ),
    );
  }
}
