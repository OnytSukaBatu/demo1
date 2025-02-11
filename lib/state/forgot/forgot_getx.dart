import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/main_function.dart';

class ForgotGetx extends GetxController {
  TextEditingController email = TextEditingController(), otp = TextEditingController(), password = TextEditingController(), confirm = TextEditingController();

  RxInt phase = 0.obs;

  RxString time = ''.obs;
  int timer = 300;

  String userID = '';

  late Timer otpKadaluarsa;

  String format(int value) {
    int menit = value ~/ 60;
    int detik = value % 60;
    String formattedSeconds = detik.toString().padLeft(2, '0');
    return '$menit:$formattedSeconds';
  }

  void lanjut() async {
    switch (phase.value) {
      case 0:
        if (!email.text.contains('@gmail.com')) {
          C.bottomSheetEla(subtitle: '${email.text} tidak ditemukan!');
          break;
        }

        final snapshot = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: email.text).get();
        if (snapshot.docs.isEmpty) {
          C.bottomSheetEla(subtitle: '${email.text} tidak terdaftar!');
          break;
        }

        userID = snapshot.docs.first.id;
        EmailOTP.sendOTP(email: email.text);
        startTime();
        email.clear();
        phase.value = 1;
      case 1:
        bool verify = EmailOTP.verifyOTP(otp: otp.text);

        if (!verify) {
          C.bottomSheetEla(subtitle: 'Kode OTP salah!');
          break;
        }

        otp.clear();
        otpKadaluarsa.cancel();
        phase.value = 2;
      case 2:
        if (password.text != confirm.text) {
          C.bottomSheetEla(subtitle: 'Password Tidak Sama!');
          break;
        }

        String newPassword = C.stringMD5(value: password.text);
        await FirebaseFirestore.instance.collection('user').doc(userID).update({
          'password': newPassword,
        });

        password.clear();
        confirm.clear();
        Get.back();
        C.bottomSheetEla(
          title: 'Password Berhasil Dirubah',
          subtitle: 'Silahkan Login Dengan Password Baru',
        );
    }
  }

  void startTime() async {
    otpKadaluarsa = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        switch (timer) {
          case == 0:
            otpKadaluarsa.cancel();
            time.value = format(timer);
          default:
            timer--;
            time.value = format(timer);
        }
      },
    );
  }
}
