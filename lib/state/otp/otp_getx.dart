import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/home/home_page.dart';

class OtpGetx extends GetxController {
  TextEditingController controller = TextEditingController();
  User user = Get.arguments;

  RxString timeString = '5:00'.obs;
  RxInt timer = 300.obs;

  late Timer otpKadaluarsa;

  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  String format(int value) {
    int menit = value ~/ 60;
    int detik = value % 60;
    String formattedSeconds = detik.toString().padLeft(2, '0');
    return '$menit:$formattedSeconds';
  }

  void back() {
    otpKadaluarsa.cancel();
    Get.back();
  }

  void startTime() async {
    otpKadaluarsa = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        switch (timer.value) {
          case == 0:
            otpKadaluarsa.cancel();
            timeString.value = format(timer.value);
          default:
            timer.value--;
            timeString.value = format(timer.value);
        }
      },
    );
  }

  void onSubmit(String? value) {
    bool verify = EmailOTP.verifyOTP(otp: controller.text);

    if (verify) return clear();

    controller.clear();
    C.bottomSheetEla(subtitle: 'Kode OTP salah!');
  }

  void clear() async {
    C.loading();
    Map<String, dynamic> data = user.toJson();

    await FirebaseFirestore.instance.collection('user').add(data);
    C.box.write(Config.user, data);

    Get.close(1);
    Get.offAll(() => HomePage());
  }
}
