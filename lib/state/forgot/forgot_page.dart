import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/forgot/forgot_getx.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});

  final ForgotGetx get = Get.put(ForgotGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Center(
              child: Column(
                children: [
                  Visibility(
                    visible: get.phase.value == 0,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: W.text(
                            text: 'Masukan Email Anda!',
                            color: Colors.black,
                          ),
                        ),
                        W.gap(height: 12),
                        W.input(
                          controller: get.email,
                          hintText: 'Email',
                          textColor: Colors.black,
                          hintColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: get.phase.value == 1,
                    child: Column(
                      children: [
                        W.text(
                          text: 'Masukan Kode OTP yang dikirim ke\n${get.email.text}',
                          textAlign: TextAlign.center,
                        ),
                        W.gap(height: 12),
                        W.pinput(
                          controller: get.otp,
                          length: 6,
                          height: 40,
                          width: 40,
                          borderColor: Colors.grey,
                          focusedBorderColor: Colors.black,
                          onCompleted: (_) {},
                        ),
                        W.gap(height: 12),
                        W.text(
                          text: 'OTP Kadaluarsa dalam ${get.time.value}',
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: get.phase.value == 2,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: W.text(
                            text: 'Buat Password Baru!',
                            color: Colors.black,
                          ),
                        ),
                        W.gap(height: 12),
                        W.input(
                          controller: get.password,
                          hintText: 'Password Baru',
                          textColor: Colors.black,
                          hintColor: Colors.grey,
                          obscureText: true,
                        ),
                        W.gap(height: 12),
                        W.input(
                          controller: get.confirm,
                          hintText: 'Konfirmasi Password',
                          textColor: Colors.black,
                          hintColor: Colors.grey,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  W.gap(height: 16),
                  W.button(
                    onPressed: get.lanjut,
                    backgroundColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: W.text(
                      text: 'Lanjut',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
