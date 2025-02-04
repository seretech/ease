import 'dart:async';

import 'package:ease/auth/sign_in.dart';
import 'package:ease/classes/app_color.dart';
import 'package:ease/nav/home_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

import '../classes/main_class.dart';
import 'onboard.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _State();
}

class _State extends State<Splash> {

  final dio = Dio();
  final box = GetStorage();

  int c = 2;
  late Timer timer;

  bool tm = false;

  @override
  void initState() {
    super.initState();
    startCount();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/logo.png', color: AppColor.colorApp, width: MainClass.devW(context, 2)),
          ],
        ),
      ),
    );
  }

  startCount() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (c > 0) {
          setState(() {
            c--;
          });
        } else {
          var js = box.read('token');
          var js1 = box.read('user');
          if(js != null){
            if(js == ''){
              MainClass.open(context, const SignIn());
            } else {
              if(js1 == null){
                MainClass.open(context, const SignIn());
              } else {
                if(js1 == ''){
                  MainClass.open(context, const SignIn());
                } else {
                  MainClass.open(context, const HomeMain(pg: 0));
                }
              }
            }
          } else {
            MainClass.open(context, const Onboard());
          }
          timer.cancel();
        }
      });
    });
  }

}
