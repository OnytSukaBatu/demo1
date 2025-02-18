import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'dart:developer' as developer;

MainFunction get C => MainFunction._();

class MainFunction {
  factory MainFunction() => MainFunction._();
  MainFunction._();

  GetStorage box = GetStorage();

  String stringMD5({required String value}) {
    var bytes = utf8.encode(value);
    var string = md5.convert(bytes);
    return string.toString();
  }

  String format({
    required String format,
    required DateTime time,
  }) {
    return DateFormat(format).format(time);
  }

  void log(dynamic value) => developer.log(value.toString());

  void bottomSheetEla({
    double height = 175,
    String title = 'Terjadi Kesalahan',
    String subtitle = 'Silahkan Coba Lagi!',
    bool showEla = false,
  }) {
    Get.bottomSheet(
      isDismissible: false,
      Container(
        height: height + 100,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Visibility(
              visible: showEla,
              child: SizedBox(
                height: 200,
                child: Image.asset(Img.ela),
              ),
            ),
            Container(
              height: double.infinity,
              width: Get.width,
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: Ma.center,
                  children: [
                    W.text(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    W.text(
                      text: subtitle,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                    ),
                    W.gap(height: 12),
                    W.button(
                      onPressed: Get.back,
                      backgroundColor: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: W.text(
                        text: 'Mengerti!',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loading() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: Ms.min,
            mainAxisAlignment: Ma.center,
            children: [
              Image.asset(
                Img.okayu,
                scale: 2,
              ),
              W.gap(height: 5),
              W.text(
                text: 'Tunggu Sebentar',
                fontWeight: FontWeight.bold,
              ),
              W.gap(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
