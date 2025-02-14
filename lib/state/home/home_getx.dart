import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/content/content_getx.dart';
import 'package:kovalskia/state/content/content_page.dart';
import 'package:kovalskia/state/post/post_page.dart';
import 'package:kovalskia/state/profile/profile_getx.dart';
import 'package:kovalskia/state/profile/profile_page.dart';
import 'package:kovalskia/state/seacrh/search_page.dart';

class HomeGetx extends GetxController {
  GetStorage box = GetStorage();
  late User user = User.fromJson(box.read(Config.user));

  RxInt index = 0.obs;

  RxList page = [
    ContentPage(),
    SeacrhPage(),
    SizedBox(),
    ProfilePage(),
  ].obs;

  void navigate(int value) {
    switch (value) {
      case == 2:
        if (Get.find<ProfileGetx>().length.value >= 9) {
          C.bottomSheetEla(subtitle: 'Telah Mencapai Batas Posting');
          return;
        }
        Get.to(() => PostPage())?.then((T) {
          if (T ?? false) return;
          Get.find<ContentGetx>().init();
          Get.find<ProfileGetx>().init();
          Get.find<ProfileGetx>().getLength();
        });
        break;

      default:
        index.value = value;
        break;
    }
  }
}
