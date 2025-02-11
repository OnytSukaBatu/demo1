import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/formatter.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/register/register_getx.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterGetx get = Get.put(RegisterGetx());

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
                text: 'Buat akun baru dan verifikasi!',
                color: Colors.black,
              ),
              W.gap(height: 32),
              W.input(
                fontSize: 14,
                controller: get.username,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Username',
                textColor: Colors.black,
                hintColor: Colors.grey,
                maxLength: 20,
                inputFormatters: [LetterNumber()],
              ),
              W.gap(height: 5),
              W.input(
                fontSize: 14,
                controller: get.email,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Email',
                textColor: Colors.black,
                hintColor: Colors.grey,
              ),
              W.gap(height: 5),
              W.input(
                fontSize: 14,
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
              W.input(
                fontSize: 14,
                controller: get.confirm,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Ulangi Password',
                textColor: Colors.black,
                hintColor: Colors.grey,
                obscureText: true,
              ),
              W.gap(height: 16),
              W.button(
                onPressed: get.register,
                width: double.infinity,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.circular(5),
                child: W.text(
                  text: 'Register',
                  color: Colors.white,
                ),
              ),
              W.gap(height: 16),
              Row(
                mainAxisAlignment: Ma.center,
                children: [
                  W.text(
                    text: 'Sudah Memiliki Akun? ',
                    color: Colors.black,
                  ),
                  W.text(
                    onTap: get.login,
                    text: 'Login',
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
