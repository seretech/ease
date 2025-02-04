import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ease/classes/main_class.dart';
import 'package:ease/nav/home_main.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/edt_pass.dart';

class NewPassword extends StatefulWidget {
  final String otp;
  const NewPassword({super.key, required this.otp});

  @override
  State<NewPassword> createState() => _State();
}

class _State extends State<NewPassword> {

  TextEditingController paController = TextEditingController();
  TextEditingController ppController = TextEditingController();

  FocusNode paFocus = FocusNode();
  FocusNode ppFocus = FocusNode();

  bool isVis = true, isVis2 = true, sending = false, tm = false, validPass = false;

  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (b, v) {
          if (!b) {
            Navigator.pop(context, {
              'res': '00',
            });
            return;
          }
        },
        child: Padding(
          padding: MainClass.padS(24, 16),
          child: AbsorbPointer(
            absorbing: sending,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MainClass.txtCus7('Create a New Password', 24, Colors.black),
                    MainClass.bH(16),
                    MainClass.txtB6('Kindly ensure your password entails the following.', 12),
                    MainClass.bH(24),
                    MainClass.passChk('Minimum of 8 characters long'),
                    MainClass.bH(8),
                    MainClass.passChk('Must contain symbol e.g @ \$'),
                    MainClass.bH(8),
                    MainClass.passChk('Must contain alphanumeric characters e.g abc123'),
                    MainClass.bH(24),
                    MainClass.txtB6('Password', 14),
                    MainClass.bH(8),
                    EdtPass(
                      onChanged: (v){
                        chkPass(v);
                      },
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
                    MainClass.txtB6('Confirm password', 14),
                    MainClass.bH(8),
                    EdtPass(
                      onChanged: (v){
                        chkPass(v);
                      },
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
                    MainClass.bH(MainClass.devH(context, 12)),
                    if(!sending)
                      ElevatedButton(
                        onPressed: () => validateInputs(),
                        style: validPass ? MainClass.btnSty() : MainClass.btnStyG(),
                        child: MainClass.txtCus7('Reset password and sign in', 14, validPass ? Colors.white :Colors.black)),
                    if(sending)
                      MainClass.loadingBtn(),
                    MainClass.bH(48),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  chkPass(v){
    setState(() {
      if(paController.text.isEmpty){
        validPass = false;
        return;
      }

      if(ppController.text.isEmpty){
        validPass = false;
        return;
      }

      if(paController.text.trim() != ppController.text.trim()){
        validPass = false;
        return;
      }

      if(paController.text.length < 8){
        validPass = false;
        return;
      }

      if(!paController.text.trim().contains(RegExp(r'[!@#$%^&*().,/}{]'))){
        validPass = false;
        return;
      }

      if(!paController.text.trim().contains(RegExp(r'[0-9]')) || !paController.text.trim().contains(RegExp(r'[a-z]'))){
        validPass = false;
        return;
      }

      validPass = true;
    });


  }

  validateInputs(){
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
    resetUser();
  }

  resetUser() async{
    final response = await dio
        .put(
      MainClass.getBaseUrl() + 'reset-password',
      data: jsonEncode(<String, dynamic>{
        'otp' : widget.otp,
        'password' : paController.text.trim(),
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
    GetStorage box = GetStorage();
    box.write('token', '');
    box.write('user', '');
    MainClass.open(context, HomeMain(pg: 0));
    if(js != null){
      try {
        jsonDecode(js);
        MainClass.sus(context, js['message']);
        return true;
      } catch (e) {
        return false;
      }
    }

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
