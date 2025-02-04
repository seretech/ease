import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ease/auth/otp_verify.dart';
import 'package:ease/classes/app_color.dart';
import 'package:ease/classes/main_class.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/edt.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _State();
}

class _State extends State<ForgotPassword> {

  TextEditingController emController = TextEditingController();

  FocusNode emFocus = FocusNode();

  bool validEmail = false, sending = false, tm = false;

  Dio dio = Dio();

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
              Center(
                child: Container(
                    padding: MainClass.padA(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.colorApp
                    ),
                    child: Image.asset('assets/lock.png', width: MainClass.devW(context, 6))),
              ),
              MainClass.txtB6('Forgot Password', 24),
              MainClass.bH(24),
              MainClass.txtB4('Be rest assured! it happens. Please enter your email linked to your account.', 14),
              MainClass.bH(24),
              MainClass.txtD4('E-mail', 14),
              MainClass.bH(8),
              Edt(
                onChanged: (v){
                  setState(() {
                    if(GetUtils.isEmail(v)){
                      validEmail = true;
                    } else {
                      validEmail = false;
                    }
                  });
                },
                focusNode: emFocus,
                textController: emController,
                textInputType: TextInputType.emailAddress,
              ),
             MainClass.bH(MainClass.devH(context, 4)),
              if(!sending)
              ElevatedButton(
                  onPressed: ()=> validateInputs(),
                  style: validEmail ? MainClass.btnSty() : MainClass.btnStyG(),
                  child: MainClass.txtCus7('Send Code', 12, validEmail ? Colors.white : Colors.black)
              ),
              if(sending)
                MainClass.loadingBtn(),
              MainClass.bH(16),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(text: 'Remember your details? '),
                      TextSpan(text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                          style: GoogleFonts.openSans(color: AppColor.colorApp, fontSize: 16, fontWeight: FontWeight.w700, decoration: TextDecoration.underline, decorationThickness: 4)),
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

  validateInputs(){
    if(emController.text.isEmpty){
      MainClass.err(context, 'Email is required');
      return;
    }

    if(!GetUtils.isEmail(emController.text.trim())){
      MainClass.err(context, 'Email is invalid');
      return;
    }

    setState(() {
      sending = true;
    });

    resetUser();
  }

  resetUser() async{
    final response = await dio
        .post(
      MainClass.getBaseUrl() + 'forgot-password',
      data: jsonEncode(<String, dynamic>{
        'email' : emController.text.trim(),
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
    MainClass.open(context, OtpVerify(em: emController.text.trim()));
    setState(() {
      sending = false;
      emController.text = '';
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
