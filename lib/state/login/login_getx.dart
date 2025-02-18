import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/forgot/forgot_page.dart';
import 'package:kovalskia/state/home/home_page.dart';
import 'package:kovalskia/state/register/register_page.dart';

class LoginGetx extends GetxController {
  TextEditingController main = TextEditingController(), password = TextEditingController();

  void buatAkun() => Get.off(() => RegisterPage());
  void lupaPassword() => Get.to(() => ForgotPage());

  void login() async {
    C.loading();

    QuerySnapshot<Map<String, dynamic>>? userQ;
    userQ = await FirebaseFirestore.instance.collection('user').where(main.text.contains('@gmail.com') ? 'email' : 'username', isEqualTo: main.text).get();

    if (userQ.docs.isEmpty) {
      Get.close(1);
      return C.bottomSheetEla(subtitle: '${main.text} tidak ditemukan!');
    }

    User user = User.fromJson(userQ.docs.first.data());
    String md5password = C.stringMD5(value: password.text);

    if (user.password != md5password) {
      Get.back();
      return C.bottomSheetEla(subtitle: 'Password salah!');
    }

    C.box.write(Config.user, user.toJson());
    Get.offAll(() => HomePage());
  }
}
