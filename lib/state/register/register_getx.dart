import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/login/login_page.dart';
import 'package:kovalskia/state/otp/otp_page.dart';

class RegisterGetx extends GetxController {
  GetStorage box = GetStorage();
  TextEditingController username = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      confirm = TextEditingController();

  void login() => Get.off(() => LoginPage());

  void register() async {
    final firestore = FirebaseFirestore.instance;

    if (username.text.length < 3) {
      C.bottomSheetEla(subtitle: 'Username Minimal 3 Karakter');
      return;
    }

    if (!email.text.contains('@gmail.com')) {
      C.bottomSheetEla(subtitle: 'Email Tidak Valid');
      return;
    }

    if (password.text.isEmpty) {
      C.bottomSheetEla(subtitle: 'Password Masih Kosong');
      return;
    }

    if (password.text != confirm.text) {
      C.bottomSheetEla(subtitle: 'Password Tidak Sama');
      return;
    }

    final emailQuerySnapshot = await firestore.collection('user').where('email', isEqualTo: email.text).get();

    if (emailQuerySnapshot.docs.isNotEmpty) {
      C.bottomSheetEla(subtitle: 'Email telah digunakan');
      return;
    }

    final usernameQuerySnapshot = await firestore.collection('user').where('username', isEqualTo: username.text).get();

    if (usernameQuerySnapshot.docs.isNotEmpty) {
      C.bottomSheetEla(subtitle: 'Username telah digunakan');
      return;
    }

    String passowrd = C.stringMD5(value: password.text);

    User arguments = User(
      username: username.text,
      email: email.text,
      password: passowrd,
      profile: '',
      desc: '',
      follow: [],
      follower: [],
    );

    EmailOTP.sendOTP(email: arguments.email);
    Get.to(() => OtpPage(), arguments: arguments);
  }
}
