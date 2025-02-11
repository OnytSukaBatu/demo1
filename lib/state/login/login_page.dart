import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:get/get.dart';
import 'package:kovalskia/state/login/login_getx.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginGetx get = Get.put(LoginGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Column(
            mainAxisAlignment: Ma.center,
            children: [
              Text(
                'Kovalskia',
                style: GoogleFonts.dancingScript(
                  color: Colors.black,
                  fontSize: 64,
                ),
              ),
              W.text(
                text: 'Login dengan akun terdaftar!',
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              W.gap(height: 32),
              W.input(
                controller: get.main,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Username atau Email',
                textColor: Colors.black,
                hintColor: Colors.grey,
              ),
              W.gap(height: 5),
              W.input(
                controller: get.password,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Password',
                textColor: Colors.black,
                hintColor: Colors.grey,
                obscureText: true,
              ),
              W.gap(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: W.text(
                  onTap: get.lupaPassword,
                  text: 'Lupa Password?',
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
              W.gap(height: 16),
              W.button(
                onPressed: get.login,
                width: double.infinity,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.circular(5),
                child: W.text(
                  text: 'Login',
                  color: Colors.white,
                ),
              ),
              W.gap(height: 16),
              Row(
                mainAxisAlignment: Ma.center,
                children: [
                  W.text(
                    text: 'Belum Memiliki Akun? ',
                    color: Colors.black,
                  ),
                  W.text(
                    onTap: get.buatAkun,
                    text: 'Buat Akun',
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
