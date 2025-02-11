import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/home/home_page.dart';

class OtpGetx extends GetxController {
  GetStorage box = GetStorage();

  TextEditingController controller = TextEditingController();

  User user = Get.arguments;
  RxString time = '5:00'.obs;
  int timer = 300;

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

  void clear() async {
    C.loading();
    Map<String, dynamic> data = user.toJson();

    final firestore = FirebaseFirestore.instance;
    await firestore.collection('user').add(data);

    box.write(Config.user, data);
    Get.back();
    Get.offAll(() => HomePage());
  }

  void onCompleted(String? value) {
    bool verify = EmailOTP.verifyOTP(otp: controller.text);

    if (verify) {
      clear();
      return;
    } else {
      controller.clear();
      C.bottomSheetEla(subtitle: 'Kode OTP salah!');
    }
  }
}
