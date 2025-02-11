import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/content/content_page.dart';
import 'package:kovalskia/state/profile/profile_page.dart';

class HomeGetx extends GetxController {
  GetStorage box = GetStorage();
  late User user = User.fromJson(box.read(Config.user));

  RxInt index = 0.obs;

  RxList page = [
    ContentPage(),
    ProfilePage(),
  ].obs;

  void navigate(int value) {
    index.value = value;
    C.log(value);
  }
}
