import 'package:ease/classes/app_color.dart';
import 'package:ease/classes/main_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {

  bool vis = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorApp,
      appBar: MainClass.customAppBar1(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                  right: 8,
                  bottom: -16,
                  child: Image.asset('assets/lines.png', fit: BoxFit.cover, height: MainClass.devH(context, 3))),
              Padding(
                padding: MainClass.padS(16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/nav.png', width: 24, height: 24),
                        Expanded(child: Image.asset('assets/logo.png', width: MainClass.devW(context, 12), height: MainClass.devW(context, 12))),
                        Image.asset('assets/noti.png', width: 24, height: 24),
                      ],
                    ),
                    MainClass.bH(24),
                    Row(
                      children: [
                        Text('Total Earning', style: GoogleFonts.nunitoSans(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                        MainClass.bW(4),
                        InkWell(
                            onTap: (){
                              setState(() {
                                if(vis){
                                  vis = false;
                                } else {
                                  vis = true;
                                }
                              });
                            },
                            child: Padding(
                              padding: MainClass.padS(0, 8),
                              child: Icon(vis ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white, size: 14),
                            )),
                      ],
                    ),
                    MainClass.bH(12),
                    if(vis)
                      Text('\$30,050.56', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 36)),
                    if(!vis)
                      Text('\$******', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 36)),
                    MainClass.bH(16),
                    Container(
                      padding: MainClass.padS(8, 16),
                      decoration: MainClass.conDecor(30, Colors.white, 1, Colors.white),
                      child: Text('Withdraw', style: GoogleFonts.nunitoSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.colorAppDark1)),
                    ),
                    MainClass.bH(32),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: MainClass.padA(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainClass.bH(12),
                      Text('Quick Access', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black)),
                      MainClass.bH(12),
                      SizedBox(
                        height: MainClass.devH(context, 4.2),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            MainClass.accessCard(context, 'assets/bookings.png', 'Bookings'),
                            MainClass.bW(12),
                            MainClass.accessCard(context, 'assets/usd.png', 'Finance'),
                            MainClass.bW(12),
                            MainClass.accessCard(context, 'assets/chat.png', 'Message'),
                          ],
                        ),
                      ),
                      MainClass.bH(16),
                      Row(
                        children: [
                          Expanded(child: Text('Past bookings', style: GoogleFonts.nunitoSans(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black))),
                          MainClass.bW(12),
                          Text('Sell all', style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.colorApp)),
                        ],
                      ),
                      MainClass.bH(16),
                      MainClass.bookingCard(context),
                      MainClass.bH(12),
                      MainClass.bookingCard(context),
                      MainClass.bH(48),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
