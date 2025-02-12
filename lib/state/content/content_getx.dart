import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/state/image/image_page.dart';

class ContentGetx extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  Future<List<Post>> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('post').orderBy('date', descending: true).limit(10).get();

    List<Post> posts = querySnapshot.docs.map((doc) {
      return Post.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return posts;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    postList.value = await getData();
    postList.refresh();
    for (Post value in postList) {
      C.log(value.image.length);
    }
  }

  void checkImage({
    required String image,
  }) {
    Get.to(() => ImagePage(), arguments: image);
  }
}
