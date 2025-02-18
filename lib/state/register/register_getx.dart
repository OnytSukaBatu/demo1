import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/login/login_page.dart';
import 'package:kovalskia/state/otp/otp_page.dart';

class RegisterGetx extends GetxController {
  TextEditingController username = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      confirm = TextEditingController();

  void login() => Get.off(() => LoginPage());

  void register() async {
    if (username.text.length < 3) return C.bottomSheetEla(subtitle: 'Username Minimal 3 Karakter');
    if (!email.text.contains('@gmail.com')) return C.bottomSheetEla(subtitle: 'Email Tidak Valid');
    if (password.text.isEmpty) return C.bottomSheetEla(subtitle: 'Password Masih Kosong');
    if (password.text != confirm.text) return C.bottomSheetEla(subtitle: 'Password Tidak Sama');

    C.loading();
    final firestore = FirebaseFirestore.instance;

    final emailQ = await firestore.collection('user').where('email', isEqualTo: email.text).get();
    if (emailQ.docs.isNotEmpty) {
      Get.close(1);
      return C.bottomSheetEla(subtitle: 'Email telah digunakan');
    }

    final usernameQ = await firestore.collection('user').where('username', isEqualTo: username.text).get();
    if (usernameQ.docs.isNotEmpty) {
      Get.close(1);
      return C.bottomSheetEla(subtitle: 'Username telah digunakan');
    }

    String passwordMd5 = C.stringMD5(value: password.text);
    User arguments = User(
      username: username.text,
      email: email.text,
      password: passwordMd5,
      profile: '',
      desc: '',
      follow: [],
      follower: [],
    );

    EmailOTP.sendOTP(email: email.text);
    Get.close(1);
    Get.to(() => OtpPage(), arguments: arguments);
  }
}
