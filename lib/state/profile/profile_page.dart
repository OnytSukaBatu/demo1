import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/state/profile/profile_getx.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileGetx get = Get.put(ProfileGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(
          () => W.text(
            text: get.user.value.email,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          IconButton(
            onPressed: get.post,
            icon: Icon(
              Icons.add_box,
            ),
          ),
          IconButton(
            onPressed: get.logoutValidation,
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => Column(
                crossAxisAlignment: Ca.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.grey[200],
                          child: get.user.value.profile.isNotEmpty
                              ? GestureDetector(
                                  onTap: get.viewImage,
                                  child: ClipOval(
                                    child: Image.memory(
                                      base64Decode(get.user.value.profile),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      W.gap(width: 32),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: Ma.between,
                            children: [
                              Column(
                                children: [
                                  W.text(
                                    text: 'Postingan',
                                    fontSize: 12,
                                  ),
                                  Obx(
                                    () => W.text(
                                      text: get.length.value.toString(),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  W.text(
                                    text: 'Pengikut',
                                    fontSize: 12,
                                  ),
                                  Obx(
                                    () => W.text(
                                      text: get.user.value.follower.length.toString(),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  W.text(
                                    text: 'Mengikuti',
                                    fontSize: 12,
                                  ),
                                  Obx(
                                    () => W.text(
                                      text: get.user.value.follow.length.toString(),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  W.gap(height: 16),
                  W.text(
                    text: get.user.value.username,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  W.text(
                    text: get.user.value.desc.isEmpty ? 'Tidak ada deskripsi' : get.user.value.desc,
                    fontSize: 12,
                  ),
                  W.gap(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: W.button(
                          onPressed: get.editProfile,
                          backgroundColor: Colors.grey[900],
                          borderRadius: BorderRadius.circular(5),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: W.text(
                            text: 'Edit Profile',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      W.gap(width: 8),
                      W.button(
                        onPressed: () {},
                        backgroundColor: Colors.grey[900],
                        borderRadius: BorderRadius.circular(5),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: get.postList.length,
                itemBuilder: (context, index) {
                  Post data = get.postList[index];
                  return Image.memory(
                    base64Decode(data.image[0]),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
