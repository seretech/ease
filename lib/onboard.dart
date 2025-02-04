import 'dart:async';

import 'package:ease/auth/sign_in.dart';
import 'package:ease/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_to_background/move_to_background.dart';

import 'classes/main_class.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _State();
}

class _State extends State<Onboard> {

  int currentPage = 0;

  late Timer timer;
  late Timer timer2;

  PageController pageController = PageController(
    initialPage: 0,
  );

  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark);

  String title = 'Lorem ipsum dolor sit amet consectetur.';
  String sub = 'Lorem ipsum dolor sit amet consectetur.';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    });
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 3) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (b, v) {
          if (!b) {
            MoveToBackground.moveTaskToBack();
            return;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: pageController,
                      onPageChanged: (v){
                        setState(() {
                          if(v == 0){
                            title = 'Lorem ipsum dolor sit amet consectetur.';
                            sub = 'Lorem ipsum dolor sit amet consectetur.';
                          } else if(v == 1){
                            title = 'Lorem ipsum dolor sit';
                            sub = 'Lorem ipsum dolor sit amet consectetur. Nibh feugiat consequat ut sit in. Lacus sit neque urna vitae elit id eget.';
                          } else if(v == 2){
                            title = 'Lorem ipsum dolor sit amet consectetur.';
                            sub = 'Lorem ipsum dolor sit amet consectetur. Nulla nec diam tincidunt enim mi at morbi in quis.';
                          }else if(v == 3){
                            title = 'Lorem ipsum dolor sit.';
                            sub = 'Lorem ipsum dolor sit amet consectetur. Mollis arcu sit phasellus tristique.';
                          }
                        });
                      },
                      children: [
                        Image.asset('assets/onboarding1.png', width: MainClass.devW(context, 1), fit: BoxFit.cover),
                        Image.asset('assets/onboarding2.png', width: MainClass.devW(context, 1), fit: BoxFit.cover),
                        Image.asset('assets/onboarding3.png', width: MainClass.devW(context, 1), fit: BoxFit.cover),
                        Image.asset('assets/onboarding4.png', width: MainClass.devW(context, 1), fit: BoxFit.cover),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: MainClass.padS(12, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MainClass.txtCus7(title, 24, Colors.white),
                            MainClass.bH(12),
                            MainClass.txtCus7(sub, 16, Colors.white),
                            MainClass.bH(16),
                            ElevatedButton(
                              onPressed: () => MainClass.open(context, const SignUp()),
                              clipBehavior: Clip.none,
                              style: MainClass.btnSty(),
                              child: MainClass.txtW5('SIGN UP', 14),
                            ),
                            MainClass.bH(20),
                            ElevatedButton(
                              onPressed: () => MainClass.open(context, const SignIn()),
                              clipBehavior: Clip.none,
                              style: MainClass.btnStyW(),
                              child: MainClass.txtN5('SIGN IN', 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: MainClass.padS(4, 24),
              //   child: ElevatedButton(
              //     onPressed: () => MainClass.open(context, const Login()),
              //     clipBehavior: Clip.none,
              //     style: MainClass.btnSty(),
              //     child: MainClass.txtWN('Sign In', 14),
              //   ),
              // ),
              // MainClass.bH(12),
              // Padding(
              //   padding: MainClass.padS(4, 24),
              //   child: Center(
              //     child: RichText(
              //       text: TextSpan(
              //         style: TextStyle(color: AppColor.colorAppGray, fontSize: 12, fontFamily: 'Satoshi'),
              //         children: <TextSpan>[
              //           const TextSpan(text: 'Need an account? '),
              //           TextSpan(text: 'Request Now',
              //               recognizer: TapGestureRecognizer()
              //                 ..onTap = () {
              //                   MainClass.events('request_now_onboarding');
              //                   MainClass.open(context, const EnterEmail());
              //                 },
              //               style: TextStyle(color: AppColor.colorApp, fontSize: 12, fontFamily: 'Satoshi')),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // MainClass.bH(Platform.isIOS ? 32 : 16)
            ],
          ),
        ),
      ),
    );
  }
}
