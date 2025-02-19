import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileGetx extends GetxController {
  User user = User.fromJson(C.box.read(Config.user));
  late TextEditingController username = TextEditingController(text: user.username), desc = TextEditingController(text: user.desc);
  late RxString profile = user.profile.obs;

  void pickImage(ImageSource imageSource) async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isDenied) if (await Permission.storage.request().isDenied) return C.bottomSheetEla(subtitle: 'Izin Penyimpanan Ditolak');
    if (status.isPermanentlyDenied) return C.bottomSheetEla(subtitle: 'Izin Penyimpanan Ditolak Permanen!');

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);

    if (image != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Setting Image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
        ],
      );

      if (croppedFile != null) {
        List<int> imageBytes = await File(croppedFile.path).readAsBytes();
        profile.value = base64Encode(imageBytes);
      }
    }
  }

  void menuPickImage() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            mainAxisSize: Ms.min,
            children: [
              W.text(
                text: 'Pilih Sumber Gambar',
              ),
              W.gap(height: 8),
              W.button(
                onPressed: () {
                  Get.back();
                  pickImage(ImageSource.gallery);
                },
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: Ma.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                    W.gap(width: 5),
                    W.text(
                      text: 'Gallery',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              W.gap(height: 5),
              W.button(
                onPressed: () {
                  Get.back();
                  pickImage(ImageSource.camera);
                },
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: Ma.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    W.gap(width: 5),
                    W.text(
                      text: 'Camera',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              W.gap(height: 5),
              W.button(
                onPressed: Get.back,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: W.text(
                  text: 'Batal',
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() async {
    C.loading();

    String userID = '';

    final snapshot = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: user.email).get();
    if (snapshot.docs.isEmpty) {
      Get.back();
      C.bottomSheetEla(subtitle: '${user.email} tidak terdaftar!');
      return;
    }

    userID = snapshot.docs.first.id;
    await FirebaseFirestore.instance.collection('user').doc(userID).update({
      'desc': desc.text,
      'profile': profile.value,
    });

    Get.close(1);
    Get.back(result: true);
  }
}
