import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/comment_model.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/image/image_page.dart';
import 'package:kovalskia/state/profile/profile_getx.dart';
import 'package:kovalskia/state/see_profile/see_profile_page.dart';

class ContentGetx extends GetxController {
  GetStorage box = GetStorage();
  late User user = User.fromJson(box.read(Config.user));

  TextEditingController comment = TextEditingController();

  RxList<Post> postList = <Post>[].obs;

  Future<List<Post>> getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('post').orderBy('date', descending: true).limit(10).get();

    List<Post> posts = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      data['id'] = id;
      Post post = Post.fromJson(data);
      return post;
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
  }

  void checkImage({
    required String image,
  }) {
    Get.to(() => ImagePage(), arguments: image);
  }

  void delete({
    required String id,
  }) async {
    C.loading();
    await FirebaseFirestore.instance.collection('post').doc(id).delete();
    Get.back();
    init();
  }

  void menuPost(String? id, String email) {
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
                visible: user.email == email,
                child: Column(
                  children: [
                    W.gap(height: 5),
                    W.button(
                      onPressed: () {
                        Get.back();
                        if (id == null) return;
                        delete(id: id);
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

  void openComment({required String id}) async {
    RxList<Comment> data = <Comment>[].obs;
    RxBool loading = true.obs;
    comment.clear();

    Get.bottomSheet(
      Expanded(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 40,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                child: Obx(
                  () => loading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                        )
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Comment indexData = data[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: ClipOval(
                                  child: Image.memory(
                                    base64Decode(indexData.profile),
                                  ),
                                ),
                              ),
                              title: W.text(
                                text: indexData.email,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              subtitle: W.text(
                                text: indexData.text,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: W.input(
                        controller: comment,
                        hintText: 'Comment',
                      ),
                    ),
                    W.gap(width: 5),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () async {
                          doComment(id).then((_) async {
                            loading.value = true;
                            data.value = await getDataComment(id);
                            data.refresh();
                            loading.value = false;
                            comment.clear();
                          });
                        },
                        child: Icon(
                          Icons.send,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    data.value = await getDataComment(id);
    data.refresh();
    loading.value = false;
  }

  Future<List<Comment>> getDataComment(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('comment').where('idContent', isEqualTo: id).get();
    List<Comment> data = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      data['id'] = id;
      Comment post = Comment.formJson(data);
      return post;
    }).toList();
    data.sort((a, b) => b.date.compareTo(a.date));
    return data;
  }

  void seeProfile(String email) {
    Get.to(() => SeeProfilePage(), arguments: email)?.then((T) {
      if (T) Get.find<ProfileGetx>().updateFirebase();
    });
  }

  Future<void> doComment(String id) async {
    Comment data = Comment(
      idContent: id,
      profile: user.profile,
      email: user.email,
      text: comment.text,
      date: Timestamp.fromDate(DateTime.now()),
    );
    Map<String, dynamic> json = data.toJson();
    C.loading();
    await FirebaseFirestore.instance.collection('comment').add(json);
    Get.close(1);
  }
}
