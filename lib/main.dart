import 'package:ease/classes/app_color.dart';
import 'package:ease/splash.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

String? initScreen = '';

void main() async{

  await GetStorage.init();
  final box = GetStorage();

  WidgetsFlutterBinding.ensureInitialized();

  initScreen = box.read('appLaunch');
  box.write('appLaunch', '1');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ease',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.colorApp),
        useMaterial3: true,
        cardColor: Colors.white,
        canvasColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white
        ),
        popupMenuTheme: const PopupMenuThemeData(
            surfaceTintColor: Colors.white,
            color: Colors.white
        ),
        datePickerTheme: const DatePickerThemeData(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white
        ),
      ),
      initialRoute: initScreen == 'null' || initScreen == null ? '1' : '/',
      routes: {
        '/': (context) => const Splash(),
        '1': (context) => const Splash(),
      },
    );
  }
}
