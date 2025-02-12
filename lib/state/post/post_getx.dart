import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

class PostGetx extends GetxController {
  GetStorage box = GetStorage();

  TextEditingController desc = TextEditingController();

  RxList<String> imageList = <String>[].obs;
  RxInt indexImage = 0.obs;

  late Rx<User> user = User.fromJson(box.read(Config.user)).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await Future.delayed(const Duration(microseconds: 1));
    Map<String, dynamic> userData = box.read(Config.user);
    user.value = User.fromJson(userData);
    user.refresh();
    log(user.value.email);
  }

  void pickImage() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      if (await Permission.storage.request().isDenied) {
        C.bottomSheetEla(subtitle: 'Izin Penyimpanan Ditolak');
        return;
      }
    }

    if (status.isPermanentlyDenied) {
      C.bottomSheetEla(subtitle: 'Izin Penyimpanan Ditolak Permanen!');
      return;
    }

    final ImagePicker picker = ImagePicker();
    final List<XFile?> image = await picker.pickMultiImage(
      limit: 9,
      imageQuality: 10,
    );

    if (image.isNotEmpty) {
      imageList.clear();
      for (var value in image) {
        List<int> imageBytes = await File(value!.path).readAsBytes();
        String base64 = base64Encode(imageBytes);
        imageList.add(base64);
      }
      imageList.refresh();
    }
  }

  void onPageChanged(int index) => indexImage.value = index + 1;

  void post() async {
    if (imageList.isEmpty) {
      C.bottomSheetEla(subtitle: 'Tidak Ada Gambar!');
      return;
    }

    User u = user.value;

    Post post = Post(
      username: u.username,
      email: u.email,
      profile: u.profile,
      image: imageList,
      desc: desc.text,
      date: Timestamp.fromDate(DateTime.now()),
      like: [],
    );

    Map<String, dynamic> postData = post.toJson();

    try {
      await FirebaseFirestore.instance.collection('post').add(postData);
      Get.back();
    } catch (e) {}
  }
}
