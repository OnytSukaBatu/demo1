import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/state/home/home_page.dart';
import 'package:kovalskia/state/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  EmailOTP.config(
    appName: 'Kovalskia',
    otpType: OTPType.numeric,
    expiry: 300 * 1000,
    emailTheme: EmailTheme.v6,
    appEmail: 'valentynoelsan@gmail.com',
    otpLength: 6,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(Img.okayu), context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainGetx get = Get.put(MainGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}

class MainGetx extends GetxController {
  GetStorage box = GetStorage();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    Map? init;
    init = box.read(Config.user) ?? {};
    if (init.isNotEmpty) {
      Get.off(() => HomePage());
    } else {
      Get.off(() => LoginPage());
    }
  }
}
