import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ease/auth/forgot_password.dart';
import 'package:ease/classes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_to_background/move_to_background.dart';

import '../classes/main_class.dart';
import '../nav/home_main.dart';
import '../widgets/edt.dart';
import '../widgets/edt_pass.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _State();
}

class _State extends State<SignIn> {
  TextEditingController emController = TextEditingController();
  TextEditingController paController = TextEditingController();

  FocusNode emFocus = FocusNode();
  FocusNode paFocus = FocusNode();

  bool isVis = true, sending = false, tm = false, remember = false;

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: MainClass.customAppBar(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (b, v) {
          if (!b) {
            MoveToBackground.moveTaskToBack();
            return;
          }
        },
        child: AbsorbPointer(
          absorbing: sending,
          child: Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset('assets/bg.png',
                        fit: BoxFit.cover, height: MainClass.devH(context, 1), width: MainClass.devW(context, 1))),
                Padding(
                  padding: MainClass.padS(16, 24),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                              child: Text('Welcome back!',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600))),
                          MainClass.bH(16),
                          Center(
                              child: Text('Book services and stays effortlessly.',
                                  style: GoogleFonts.hind(
                                      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400))),
                          MainClass.bH(24),
                          MainClass.txtD4('E-mail', 14),
                          MainClass.bH(8),
                          Edt(
                            focusNode: emFocus,
                            textController: emController,
                            textInputType: TextInputType.emailAddress,
                          ),
                          MainClass.bH(24),
                          MainClass.txtD4('Password', 14),
                          MainClass.bH(8),
                          EdtPass(
                            focusNode: paFocus,
                            textController: paController,
                            onPress: () {
                              setState(() {
                                if (isVis) {
                                  isVis = false;
                                } else {
                                  isVis = true;
                                }
                              });
                            },
                            chk: isVis,
                          ),
                          MainClass.bH(12),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (remember) {
                                      remember = false;
                                    } else {
                                      remember = true;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: MainClass.padA(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: remember ? AppColor.colorApp : Colors.white,
                                    border: Border.all(
                                      color: AppColor.colorApp,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              MainClass.bW(4),
                              Expanded(
                                child: Text('Remember Me',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.colorAppGray2)),
                              ),
                              MainClass.bW(16),
                              InkWell(
                                onTap: () => MainClass.open(context, ForgotPassword()),
                                child: Text('Forgot Password?',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.colorAppGray2)),
                              ),
                            ],
                          ),
                          MainClass.bH(36),
                          if (!sending)
                            ElevatedButton(
                                onPressed: () => validateInputs(),
                                style: MainClass.btnSty(),
                                child: MainClass.txtW6('Log in', 14)),
                          if (sending) MainClass.loadingBtn(),
                          MainClass.authOptions(false, context),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateInputs() {
    if (emController.text.isEmpty) {
      MainClass.err(context, 'Email is required');
      return;
    }

    if (paController.text.isEmpty) {
      MainClass.err(context, 'Password is required');
      return;
    }

    if (!GetUtils.isEmail(emController.text.trim())) {
      MainClass.err(context, 'Email is invalid');
      return;
    }

    setState(() {
      sending = true;
    });

    loginUser();
  }

  loginUser() async {
    final response = await dio
        .post(
      MainClass.getBaseUrl() + 'login',
      data: jsonEncode(<String, dynamic>{
        'email': emController.text.trim(),
        'password': paController.text.trim(),
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
      if (js['success'].toString() == 'true') {
        GetStorage box = GetStorage();
        if(remember){
          box.write('token', js['token']);
          box.write('user', js['userInfo']);
        }
        allOk();
      } else {
        if (js['message'] != null) {
          showSnack(js['message']);
        } else {
          showSnack('Login failed');
        }
      }
    } else {
      if (js['message'] != null) {
        showSnack(js['message']);
      } else {
        showSnack(response.statusCode.toString());
      }
    }
  }

  allOk() {
    setState(() {
      sending = false;
      tm = false;
    });
    MainClass.sus(context, 'Welcome back ${emController.text.trim()}');
    MainClass.open(context, const HomeMain(pg: 0));
  }

  showSnackT(s) {
    if (tm) {
      MainClass.err(context, s);
      setState(() {
        sending = false;
        tm = false;
      });
    }
  }

  showSnack(s) {
    if (!tm) {
      MainClass.err(context, s);
      setState(() {
        sending = false;
        tm = false;
      });
    }
  }
}
