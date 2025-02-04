import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ease/auth/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/app_color.dart';
import '../classes/main_class.dart';

class OtpVerify extends StatefulWidget {
  final String em;
  const OtpVerify({super.key, required this.em});

  @override
  State<OtpVerify> createState() => _State();
}

class _State extends State<OtpVerify> {

  bool validOtp = false, isVerified = false, sending = false, tm = false, retry = false;

  GifController gifController = GifController();

  Dio dio = Dio();

  int c = 40;
  late Timer timer;

  String v1 = '', v2 = '', v3 = '', v4 = '', v5 = '', v6 = '';

  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();
  FocusNode node5 = FocusNode();
  FocusNode node6 = FocusNode();

  Color c1 = AppColor.colorAppGray3;
  Color c2 = AppColor.colorAppGray3;
  Color c3 = AppColor.colorAppGray3;
  Color c4 = AppColor.colorAppGray3;
  Color c5 = AppColor.colorAppGray3;
  Color c6 = AppColor.colorAppGray3;

  @override
  void initState() {
    startCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: AbsorbPointer(
        absorbing: sending,
        child: Padding(
          padding: MainClass.padA(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(!isVerified)
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        padding: MainClass.padA(12),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.colorApp
                        ),
                        child: Image.asset('assets/email.png', width: MainClass.devW(context, 6))),
                  ),
                  MainClass.txtB6('Check your inbox!!', 24),
                  MainClass.bH(12),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(text: 'We have just sent an E-mail that contains the instructions and a reset link to '),
                        TextSpan(text: widget.em, style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: 14, fontWeight: FontWeight.w400)),
                        TextSpan(text: '. It might a few minutes.'),
                      ],
                    ),
                  ),
                  MainClass.bH(48),
                  MainClass.txtD4('Enter Verification Code', 14),
                  MainClass.bH(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c1, 0, c1),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node1,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    FocusScope.of(context).requestFocus(node2);
                                    v1 = text;
                                    c1 = Colors.white;
                                  } else {
                                    c2 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c2, 0, c2),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node2,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    FocusScope.of(context).requestFocus(node3);
                                    v2 = text;
                                    c2 = Colors.white;
                                  } else {
                                    FocusScope.of(context).requestFocus(node1);
                                    c2 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c3, 1, c3),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node3,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    FocusScope.of(context).requestFocus(node4);
                                    v3 = text;
                                    c3 = Colors.white;
                                  }
                                  else {
                                    FocusScope.of(context).requestFocus(node2);
                                    c3 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c4, 0, c4),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node4,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    v4 = text;
                                    c4 = Colors.white;
                                    FocusScope.of(context).requestFocus(node5);
                                  } else {
                                    FocusScope.of(context).requestFocus(node3);
                                    c4 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c5, 0, c5),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node5,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    v5 = text;
                                    c5 = Colors.white;
                                    FocusScope.of(context).requestFocus(node6);
                                  } else {
                                    FocusScope.of(context).requestFocus(node6);
                                    c5 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        shadowColor: Colors.white,
                        child: Container(
                            decoration: MainClass.conDecor(8, c6, 0, c6),
                            width: MainClass.devW(context, 8),
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                              ],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              focusNode: node6,
                              onChanged: (text) {
                                setState(() {
                                  if (text.length == 1) {
                                    v6 = text;
                                    c6 = Colors.white;
                                    node6.unfocus();
                                  } else {
                                    c6 = AppColor.colorAppGray3;
                                  }
                                  chkOtp();
                                });
                              },
                            )
                        ),
                      ),
                    ],
                  ),
                  MainClass.bH(MainClass.devH(context, 4)),
                  if(!sending)
                    ElevatedButton(
                      onPressed: (){
                        if(validOtp){
                          setState(() {
                            isVerified = true;
                            gifController.play();
                          });
                        }
                      },
                      style: validOtp ? MainClass.btnSty() : MainClass.btnStyG(),
                      child: MainClass.txtCus7('Continue', 12, validOtp ? Colors.white : Colors.black)
                  ),
                  if(sending)
                    MainClass.loadingBtn(),
                  MainClass.bH(16),
                  Center(
                    child: MainClass.txtB4('Didn’t receive OTP code?', 14),
                  ),
                  MainClass.bH(4),
                  if(retry)
                  InkWell(
                    onTap: () => resendOtp(),
                    child: Center(
                      child: Padding(padding: MainClass.padS(4, 8), child: MainClass.txtN6('Resend Verification Code', 14)),
                    ),
                  ),
                  if(!retry)
                    Center(
                      child: Padding(padding: MainClass.padS(4, 8), child: MainClass.txtN6('Resend in $c', 14)),
                    )
                ],
              ),
              if(isVerified)
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GifView.asset(
                          'assets/pin.gif',
                          width: MainClass.devW(context, 1.2),
                          frameRate: 30,
                        ),
                        MainClass.bH(MainClass.devH(context, 12)),
                        ElevatedButton(
                            onPressed: () {
                              String otpValue = '$v1$v2$v3$v4$v5$v6';
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => NewPassword(otp: otpValue)),
                              ).then((value) {
                                setState((){
                                  if(value != null){
                                    String reload = (value)['res'];
                                    if(reload == '00'){
                                      isVerified = false;
                                    }
                                  }
                                });
                              });
                              setState(() {
                                resetOtps();
                              });
                            },
                            style: MainClass.btnSty(),
                            child: MainClass.txtCus7('Create new Password', 12, Colors.white)
                        ),
                        MainClass.bH(16),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  resetOtps(){
    validOtp = false;
    v1 = '';
    v2 = '';
    v3 = '';
    v4 = '';
    v5 = '';
    v6 = '';
    c1 = AppColor.colorAppGray3;
    c2 = AppColor.colorAppGray3;
    c3 = AppColor.colorAppGray3;
    c4 = AppColor.colorAppGray3;
    c5 = AppColor.colorAppGray3;
    c6 = AppColor.colorAppGray3;
  }

  chkOtp(){
    setState(() {
      if(v1.length == 1
          && v2.length == 1
          && v3.length == 1
          && v4.length == 1
          && v5.length == 1
          && v6.length == 1){
        validOtp = true;
      } else {
        validOtp = false;
      }
    });
  }

  startCount() {
    if(!retry) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (c > 0) {
            setState(() {
              c--;
            });
          } else {
            setState(() {
              retry = true;
            });
            timer.cancel();
          }
        });
      });
    }
  }

  resendOtp() async{
    setState(() {
      sending = true;
    });
    final response = await dio
        .post(
      MainClass.getBaseUrl() + 'forgot-password',
      data: jsonEncode(<String, dynamic>{
        'email' : widget.em,
      }),
      options: MainClass.options(),
    )
        .timeout(MainClass.tm(), onTimeout: () {
      setState(() {
        tm = true;
      });
      return showSnackT('Process incomplete, Please try again');
    }).onError((error, stackTrace) {
      RequestOptions req = RequestOptions();
      return Response(requestOptions: req);
    });

    var js = response.data;

    if (response.statusCode == 200 || response.statusCode == 201) {
      allOk(js);
    } else {
      if(js != null){
        try {
          jsonDecode(js);
          showSnack(js['message']);
          return true;
        } catch (e) {
          showSnack('$js ${response.statusCode.toString()}');
          return false;
        }
      } else {
        showSnack(response.statusCode.toString());
      }
    }
  }

  allOk(js){
    setState(() {
      sending = false;
      retry = false;
      c = 40;
      resetOtps();
      startCount();
    });
    MainClass.sus(context, js['message']);
  }

  showSnackT(s) {
    if(tm){
      MainClass.err(context, s);
      setState(() {
        sending = false;
        tm = false;
      });
    }
  }

  showSnack(s) {
    if(!tm){
      MainClass.err(context, s);
      setState(() {
        sending = false;
        tm = false;
      });
    }
  }

}
