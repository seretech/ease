import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/main_class.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _State();
}

class _State extends State<Saved> {
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
            Text('Saved', style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
            MainClass.bH(24),
          ],
        ),
      ),
    );
  }
}
