import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/image/image_page.dart';

class PostDetailGetx extends GetxController {
  GetStorage box = GetStorage();
  late User user = User.fromJson(box.read(Config.user));
  Post post = Get.arguments;

  void checkImage({
    required String image,
  }) {
    Get.to(() => ImagePage(), arguments: image);
  }

  RxList rxlike = [].obs;

  @override
  void onInit() {
    rxlike.value = post.like;
    super.onInit();
  }

  void menuPost() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: Ms.min,
            children: [
              W.button(
                width: double.infinity,
                borderRadius: BorderRadius.circular(5),
                onPressed: Get.back,
                side: BorderSide(color: Colors.transparent),
                child: W.text(
                  text: 'Laporkan Postingan',
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    W.gap(height: 5),
                    W.button(
                      onPressed: () {
                        // Get.back();
                        // if (id == null) return;
                        // delete(id: id);
                      },
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.transparent),
                      child: W.text(
                        text: 'Hapus Postingan',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              W.gap(height: 5),
              W.button(
                width: double.infinity,
                borderRadius: BorderRadius.circular(5),
                onPressed: Get.back,
                side: BorderSide(color: Colors.transparent),
                child: W.text(
                  text: 'Kembali',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doLike(
    String id,
    RxList listLike,
  ) async {
    DocumentReference post = FirebaseFirestore.instance.collection('post').doc(id);
    if (!listLike.contains(user.email)) {
      listLike.add(user.email);
      await post.update({
        'like': FieldValue.arrayUnion([user.email])
      });
    } else {
      listLike.remove(user.email);
      await post.update({
        'like': FieldValue.arrayRemove([user.email])
      });
    }
  }
}
