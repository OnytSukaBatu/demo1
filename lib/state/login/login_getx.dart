import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/forgot/forgot_page.dart';
import 'package:kovalskia/state/home/home_page.dart';
import 'package:kovalskia/state/register/register_page.dart';

class LoginGetx extends GetxController {
  GetStorage box = GetStorage();
  TextEditingController main = TextEditingController(), password = TextEditingController();

  void buatAkun() => Get.off(() => RegisterPage());

  void lupaPassword() => Get.to(() => ForgotPage(), arguments: false);

  void login() async {
    C.loading();

    final firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>>? usernameQuerySnapshot;

    if (main.text.contains('@gmail.com')) {
      usernameQuerySnapshot = await firestore.collection('user').where('email', isEqualTo: main.text).get();
    } else {
      usernameQuerySnapshot = await firestore.collection('user').where('username', isEqualTo: main.text).get();
    }

    if (usernameQuerySnapshot.docs.isEmpty) {
      Get.back();
      C.bottomSheetEla(subtitle: '${main.text} tidak ditemukan!');
      return;
    }

    User user = User.fromJson(usernameQuerySnapshot.docs.first.data());
    String md5password = C.stringMD5(value: password.text);

    if (user.password != md5password) {
      Get.back();
      C.bottomSheetEla(subtitle: 'Password salah!');
      return;
    }

    box.write(Config.user, user.toJson());
    Get.offAll(() => HomePage());
  }
}
