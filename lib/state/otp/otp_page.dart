import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/otp/otp_getx.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final OtpGetx get = Get.put(OtpGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Column(
            mainAxisAlignment: Ma.center,
            children: [
              W.text(
                text: 'Masukan kode OTP yang dikirim pada Gmail\n${get.user.email}\nCek juga pada folder spam!',
                color: Colors.black,
                textAlign: TextAlign.center,
                fontSize: 12,
              ),
              W.gap(height: 32),
              W.pinput(
                controller: get.controller,
                length: 6,
                height: 40,
                width: 40,
                borderColor: Colors.grey,
                focusedBorderColor: Colors.black,
                onCompleted: get.onSubmit,
              ),
              W.gap(height: 32),
              Row(
                mainAxisAlignment: Ma.center,
                children: [
                  W.text(
                    text: 'Kode OTP akan kadaluarsa dalam',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  W.gap(width: 5),
                  Obx(
                    () => W.text(
                      text: get.timeString.value,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              W.gap(height: 128),
            ],
          ),
        ),
      ),
    );
  }
}
