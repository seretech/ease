import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/main_class.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _State();
}

class _State extends State<Bookings> {
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
            Text('Bookings', style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
            MainClass.bH(24),
          ],
        ),
      ),
    );
  }
}
