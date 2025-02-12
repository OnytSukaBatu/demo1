import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/edit_profile/edit_profile_page.dart';
import 'package:kovalskia/state/image/image_page.dart';
import 'package:kovalskia/state/post/post_page.dart';

class ProfileGetx extends GetxController {
  GetStorage box = GetStorage();

  late Rx<User> user = User.fromJson(box.read(Config.user)).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void editProfile() async {
    Get.to(EditProfilePage())?.then((T) async {
      if (T) {
        var snapshot = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: user.value.email).get();
        box.write(Config.user, snapshot.docs.first.data());
        user.value = User.fromJson(box.read(Config.user));
      }
    });
  }

  Future<void> init() async {
    await Future.delayed(const Duration(microseconds: 1));
    Map<String, dynamic> userData = box.read(Config.user);
    user.value = User.fromJson(userData);
    user.refresh();
    return;
  }

  void post() => Get.to(() => PostPage());

  void viewImage() => Get.to(() => ImagePage(), arguments: user.value.profile);
}
