import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/edit_profile/edit_profile_page.dart';
import 'package:kovalskia/state/image/image_page.dart';
import 'package:kovalskia/state/login/login_page.dart';
import 'package:kovalskia/state/post/post_page.dart';
import 'package:kovalskia/state/content/content_getx.dart';

class ProfileGetx extends GetxController {
  GetStorage box = GetStorage();
  RxInt length = 0.obs;
  RxList<Post> postList = <Post>[].obs;

  late Rx<User> user = User.fromJson(box.read(Config.user)).obs;

  @override
  void onInit() {
    init();
    initUser();
    getLength();
    super.onInit();
  }

  void editProfile() async {
    Get.to(EditProfilePage())?.then((T) async {
      if (T) updateFirebase();
    });
  }

  void updateFirebase() async {
    var snapshot = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: user.value.email).get();
    box.write(Config.user, snapshot.docs.first.data());
    user.value = User.fromJson(box.read(Config.user));
  }

  Future<void> init() async {
    await Future.delayed(const Duration(microseconds: 1));
    postList.value = await getData();
    postList.refresh();
    return;
  }

  void initUser() async {
    await Future.delayed(const Duration(microseconds: 1));
    Map<String, dynamic> userData = box.read(Config.user);
    user.value = User.fromJson(userData);
    user.refresh();
  }

  void post() {
    if (length.value >= 9) {
      C.bottomSheetEla(subtitle: 'Telah Mencapai Batas Posting');
      return;
    }
    Get.to(() => PostPage())?.then((T) {
      if (T ?? false) return;
      init();
      Get.find<ContentGetx>().init();
      getLength();
    });
  }

  void viewImage() => Get.to(() => ImagePage(), arguments: user.value.profile);

  void getLength() async {
    await Future.delayed(const Duration(microseconds: 1));
    C.loading();
    var querySnapshot = await FirebaseFirestore.instance.collection('post').where('email', isEqualTo: user.value.email).get();
    length.value = querySnapshot.size;
    Get.back();
  }

  void logoutValidation() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: Ms.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  W.text(
                    text: 'Yakin Ingin Logout?',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  W.text(
                    text: 'Anda Harus Login Lagi Jika Ingin Menggunakan Aplikasi',
                    fontSize: 12,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: W.button(
                      onPressed: Get.back,
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.transparent),
                      child: W.text(
                        text: 'Tidak',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 3,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: W.button(
                      onPressed: () {
                        GetStorage().remove(Config.user);
                        Get.offAll(() => LoginPage());
                      },
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.transparent),
                      child: W.text(
                        text: 'Iya',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Post>> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('post').where('email', isEqualTo: user.value.email).get();
    List<Post> posts = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      data['id'] = id;
      Post post = Post.fromJson(data);
      return post;
    }).toList();
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  }
}
