import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:ease/auth/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/sign_in.dart';
import 'app_color.dart';

class MainClass {

  static bH(sz) {
    double a1 = sz.toDouble();
    return SizedBox(height: a1);
  }

  static bW(sz) {
    double a1 = sz.toDouble();
    return SizedBox(width: a1);
  }

  static txtW4(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: a1, fontWeight: FontWeight.w400));
  }

  static txtW4I(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(fontStyle: FontStyle.italic, color: Colors.white, fontSize: a1, fontWeight: FontWeight.w400));
  }

  static txtW5(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: a1, fontWeight: FontWeight.w500));
  }

  static txtW6(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: a1, fontWeight: FontWeight.w600));
  }

  static txtB4(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: Colors.black, fontSize: a1, fontWeight: FontWeight.w400));
  }

  static txtB6(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: Colors.black, fontSize: a1, fontWeight: FontWeight.w600));
  }

  static txtD4(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: AppColor.colorAppDark, fontSize: a1, fontWeight: FontWeight.w400));
  }

  static txtCus7(txt, sz, cl) {
    double a1 = sz.toDouble();
    return Text(txt,
        style: GoogleFonts.openSans(color: cl, fontSize: a1, fontWeight: FontWeight.w700));
  }

  static txtN4(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        softWrap: true,
        style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: a1, fontWeight: FontWeight.w400));
  }

  static txtN5(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        softWrap: true,
        style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: a1, fontWeight: FontWeight.w500));
  }

  static txtN6(txt, sz) {
    double a1 = sz.toDouble();
    return Text(txt,
        softWrap: true,
        style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: a1, fontWeight: FontWeight.w600));
  }

  static txtStyle() {
    return GoogleFonts.openSans(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);
  }

  static hintStyle() {
    return GoogleFonts.openSans(color: AppColor.colorAppGray, fontSize: 14);
  }

  static btnSty() {
    return ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: AppColor.colorApp,
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static btnStyW() {
    return ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static btnStyG() {
    return ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      backgroundColor: AppColor.colorAppGray3,
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static devH(ctx, sz) {
    double a1 = sz.toDouble();
    return MediaQuery.of(ctx).size.height / a1;
  }

  static devW(ctx, sz) {
    double a1 = sz.toDouble();
    return MediaQuery.of(ctx).size.width / a1;
  }

  static conDecor(r, c, b, col) {
    double r1 = r.toDouble();
    double b1 = b.toDouble();
    return BoxDecoration(
      color: col,
      borderRadius: BorderRadius.circular(r1),
      border: Border.all(
        color: c,
        width: b1,
      ),
    );
  }

  static padA(i) {
    double a = i.toDouble();
    return EdgeInsets.all(a);
  }

  static padS(t, l) {
    double ver = t.toDouble();
    double hor = l.toDouble();
    return EdgeInsets.only(top: ver, bottom: ver, left: hor, right: hor);
  }

  static loadingBtn() {
    return ElevatedButton(
      onPressed: () {},
      style: btnSty(),
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 1.5,
      ),
    );
  }

  static boardChk(ctx) {
    return MediaQuery.of(ctx).viewInsets.bottom != 0;
  }

  static getData(String s) {
    GetStorage box = GetStorage();
    var js = box.read('user');
    String res = '';
    if(js != null && js != ''){
      if(s == 'phone'){
        res = js['phoneNumber'].toString();
      } else if(s == 'email'){
        res = js['email'].toString();
      }
    }


    return res;
  }

  static getToken() {
    GetStorage box = GetStorage();
    return 'Bearer ${box.read('token')}';
  }

  static open(ctx, p) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) => p),
    );
  }

  static customAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        systemOverlayStyle: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
    );
  }

  static customAppBar1() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        systemOverlayStyle: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: AppColor.colorApp,
            statusBarIconBrightness: Brightness.light),
      ),
    );
  }

  static authOptions(chk, ctx) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MainClass.bH(24),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
              children: <TextSpan>[
                TextSpan(text: chk ? 'Already have an account? ' : 'Don’t have an account? '),
                TextSpan(text: chk? 'Login' : 'Sign up',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => MainClass.open(ctx, chk ? const SignIn() : const SignUp()),
                    style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: 16, fontWeight: FontWeight.w700, decoration: TextDecoration.underline, decorationThickness: 4)),
              ],
            ),
          ),
        ),
        MainClass.bH(16),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColor.colorAppGray1,
              ),
            ),
            MainClass.bW(12),
            MainClass.txtCus7('or', 16, Colors.black),
            MainClass.bW(12),
            Expanded(
              child: Container(
                height: 1,
                color: AppColor.colorAppGray1,
              ),
            ),
          ],
        ),
        MainClass.bH(16),
        txtB4(chk ? 'Sign up With' : 'Login With', 16),
        MainClass.bH(16),
        Image.asset('assets/socials.png', width: devW(ctx, 3)),
      ],
    );
  }

  static passChk(s) {
    return Row(
      children: [
        Container(
          padding: padA(8),
          decoration: BoxDecoration(
            color: AppColor.colorAppWine,
            shape: BoxShape.circle,
          ),
        ),
        bW(8),
        Expanded(child: Text(s, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black)))
      ],
    );
  }

  static err(ctx, sms) {
    AnimatedSnackBar(
      builder: ((context) {
        return Container(
          decoration: conDecor(4, Colors.red, 0, Colors.red),
          padding: padS(4, 8),
          child: Wrap(
            children: [
              Text(sms,
                  style: GoogleFonts.openSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }),
      duration: const Duration(seconds: 3),
    ).show(ctx);
  }

  static sus(ctx, sms) {
    AnimatedSnackBar(
      builder: ((context) {
        return Container(
          decoration: conDecor(4, Colors.green, 0, Colors.green),
          padding: padS(4, 8),
          child: Wrap(
            children: [
              Text(sms,
                  style: GoogleFonts.openSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }),
      duration: const Duration(seconds: 3),
    ).show(ctx);
  }

  static options() {
    return Options(
      sendTimeout: MainClass.tm(),
      contentType: "application/json",
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        if (statusCode == 400 || statusCode <= 500) {
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    );
  }

  static getBaseUrl() {
    return 'https://mobile-assessment.onrender.com/api/';
  }

  static tm() {
    return const Duration(seconds: 45);
  }

  static accessCard(ctx, ic, s) {
    return Container(
      padding: MainClass.padS(12, 16),
      decoration: conDecor(16, AppColor.colorAppGray4, 0, AppColor.colorAppGray4),
      width: MainClass.devW(ctx, 2.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainClass.bH(24),
          Container(
            padding: MainClass.padA(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Image.asset(ic, width: 24, height: 24),
          ),
          MainClass.bH(32),
          Text(s, style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: 16, color: AppColor.colorAppGray5)),
          MainClass.bH(32),
        ],
      ),
    );
  }

  static bookingCard(ctx) {
    return Container(
      width: double.infinity,
      decoration: conDecor(16, Colors.white, 0, Colors.white),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('assets/house.png', fit: BoxFit.cover, width: devW(ctx, 1)),
          Positioned(
            top: 12,
            right: 16,
            child: Container(
              padding: padS(4, 8),
              decoration: conDecor(16, AppColor.colorAppGreen, 0, AppColor.colorAppGreen),
              child: Text('Confirmed', style: GoogleFonts.hind(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              child: Container(
                padding: MainClass.padA(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Laxad Hotels', style: GoogleFonts.montserrat(color: AppColor.colorApp, fontSize: 14, fontWeight: FontWeight.w600)),
                        Container(
                          margin: padS(0, 4),
                          padding: padA(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.colorAppGray6
                          ),
                        ),
                        Text('14, Adetola str, Lagos.', style: GoogleFonts.montserrat(color: AppColor.colorAppGreen, fontSize: 10, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    bH(4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.montserrat(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(text: 'Sun 2nd - Mon 5th June - '),
                          TextSpan(text: '3nights',
                              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    bH(8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: GoogleFonts.montserrat(color: AppColor.colorAppGreen, fontWeight: FontWeight.w400, fontSize: 10),
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                      child: Padding(
                                        padding: MainClass.padS(0, 4),
                                        child: Icon(Icons.check, color: AppColor.colorAppGreen, size: 16),
                                      ),
                                    ),
                                    TextSpan(text: 'Free breakfast'),
                                  ],
                                ),
                              ),
                              bH(2),
                              Text.rich(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                TextSpan(
                                  style: GoogleFonts.montserrat(color: AppColor.colorAppGreen, fontWeight: FontWeight.w400, fontSize: 10),
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                      child: Padding(
                                        padding: MainClass.padS(0, 4),
                                        child: Icon(Icons.check, color: AppColor.colorAppGreen, size: 16),
                                      ),
                                    ),
                                    TextSpan(text: 'Free cancellation before 18:00 on 3rd June 2024'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        bW(12),
                        Text('Total: NGN35,000', style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w700, color: AppColor.colorApp))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
