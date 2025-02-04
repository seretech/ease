import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/sign_in.dart';
import '../classes/main_class.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _State();
}

class _State extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: MainClass.padA(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainClass.bH(24),
            Text('Profile', style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
            MainClass.bH(24),
            MainClass.txtN5(MainClass.getData('email'), 16),
            MainClass.bH(24),
            MainClass.txtN5(MainClass.getData('phone'), 16),
            Expanded(child: Container()),
            ElevatedButton(
                style: MainClass.btnSty(),
                onPressed: (){
                  GetStorage box = GetStorage();
                  box.write('token', '');
                  box.write('user', '');
                  MainClass.sus(context, 'Signed out successfully');
                  MainClass.open(context, SignIn());
                },
                child: MainClass.txtW5('Sign Out', 14)),
            MainClass.bH(48),
          ],
        ),
      ),
    );
  }
}
