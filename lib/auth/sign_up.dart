import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ease/auth/sign_in.dart';
import 'package:ease/classes/main_class.dart';
import 'package:ease/widgets/edt.dart';
import 'package:ease/widgets/edt_clear.dart';
import 'package:ease/widgets/edt_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_to_background/move_to_background.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _State();
}

class _State extends State<SignUp> {

  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emController = TextEditingController();
  TextEditingController phController = TextEditingController();
  TextEditingController paController = TextEditingController();
  TextEditingController ppController = TextEditingController();

  FocusNode fnFocus = FocusNode();
  FocusNode lnFocus = FocusNode();
  FocusNode emFocus = FocusNode();
  FocusNode phFocus = FocusNode();
  FocusNode paFocus = FocusNode();
  FocusNode ppFocus = FocusNode();

  bool isVis = true, isVis2 = true, sending = false, tm = false;

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: sending,
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
            appBar: MainClass.customAppBar(),
            body: Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset('assets/bg.png', height: MainClass.devH(context, 1), width: MainClass.devW(context, 1))),
                  Padding(
                    padding: MainClass.padS(16, 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Sign Up', style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MainClass.txtD4('First name', 14),
                                    MainClass.bH(8),
                                    Edt(focusNode: fnFocus, textController: fnController)
                                  ],
                                ),
                              ),
                              MainClass.bW(12),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MainClass.txtD4('Last name', 14),
                                    MainClass.bH(8),
                                    Edt(focusNode: lnFocus, textController: lnController)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          MainClass.bH(24),
                          MainClass.txtD4('E-mail', 14),
                          MainClass.bH(8),
                          Edt(
                              focusNode: emFocus,
                              textController: emController,
                              textInputType: TextInputType.emailAddress,
                          ),
                          MainClass.bH(24),
                          MainClass.txtD4('Phone number', 14),
                          MainClass.bH(8),
                          Material(
                            elevation: 4,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                            shadowColor: Colors.black,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MainClass.bW(8),
                                Image.asset('assets/ng.png', width: 16, height: 16),
                                MainClass.bW(4),
                                Text('+234', style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 12)),
                                MainClass.bW(4),
                                Container(
                                  height: 32,
                                  color: Colors.black,
                                  width: 1,
                                ),
                                MainClass.bW(4),
                                Expanded(
                                  child: EdtClear(
                                    focusNode: phFocus,
                                    textController: phController,
                                    max: 11,
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
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
                          MainClass.bH(24),
                          MainClass.txtD4('Confirm password', 14),
                          MainClass.bH(8),
                          EdtPass(
                            focusNode: ppFocus,
                            textController: ppController,
                            onPress: () {
                              setState(() {
                                if (isVis2) {
                                  isVis2 = false;
                                } else {
                                  isVis2 = true;
                                }
                              });
                            },
                            chk: isVis2,
                          ),
                          MainClass.bH(36),
                          if(!sending)
                          ElevatedButton(
                              onPressed: () => validateInputs(),
                              style: MainClass.btnSty(),
                              child: MainClass.txtW6('SIGN UP', 14)),
                          if(sending)
                            MainClass.loadingBtn(),
                          MainClass.authOptions(true, context),
                        ],
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

  validateInputs(){
    if(fnController.text.isEmpty){
      MainClass.err(context, 'First name is required');
      return;
    }

    if(fnController.text.length < 2){
      MainClass.err(context, 'First name is invalid');
      return;
    }

    if(lnController.text.isEmpty){
      MainClass.err(context, 'Last name is required');
      return;
    }

    if(lnController.text.length < 2){
      MainClass.err(context, 'Last name is invalid');
      return;
    }

    if(phController.text.isEmpty){
      MainClass.err(context, 'Phone is required');
      return;
    }

    if(phController.text.length < 10){
      MainClass.err(context, 'Phone number is invalid');
      return;
    }

    if(emController.text.isEmpty){
      MainClass.err(context, 'Email is required');
      return;
    }

    if(!GetUtils.isEmail(emController.text.trim())){
      MainClass.err(context, 'Email is invalid');
      return;
    }

    if(paController.text.isEmpty){
      MainClass.err(context, 'Password is required');
      return;
    }

    if(ppController.text.isEmpty){
      MainClass.err(context, 'Confirm Password is required');
      return;
    }

    if(paController.text.trim() != ppController.text.trim()){
      MainClass.err(context, 'Password and confirm password mix-match');
      return;
    }

    if(paController.text.length < 8){
      MainClass.err(context, 'Password must be minimum of 8 characters long');
      return;
    }

    if(!paController.text.trim().contains(RegExp(r'[!@#$%^&*().,/}{]'))){
      MainClass.err(context, 'Password must contain symbol e.g @ \$ # % & !');
      return;
    }

    if(!paController.text.trim().contains(RegExp(r'[0-9]')) || !paController.text.trim().contains(RegExp(r'[a-z]'))){
      MainClass.err(context, 'Password must contain alphanumeric characters e.g abc123');
      return;
    }

    setState(() {
      sending = true;
    });

   registerUser();
  }

  registerUser() async{
    final response = await dio
        .post(
      MainClass.getBaseUrl() + 'signup',
      data: jsonEncode(<String, dynamic>{
        'email' : emController.text.trim(),
        'password': paController.text.trim(),
        'phoneNumber': phController.text.trim(),
        'fullname': '${fnController.text.trim()} ${lnController.text.trim()}',
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
    MainClass.open(context, const SignIn());
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
