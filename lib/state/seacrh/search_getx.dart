import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/see_profile/see_profile_page.dart';

class SearchGetx extends GetxController {
  TextEditingController input = TextEditingController();
  RxList listUser = [].obs;

  void search() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('username', isGreaterThanOrEqualTo: input.text)
        .where('username', isLessThan: '${input.text}\uf8ff')
        .get();

    List<User> list = snapshot.docs.map((doc) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    listUser.value = list;
    listUser.refresh();
  }

  void seeUser(String email) => Get.to(() => SeeProfilePage(), arguments: email);
}
