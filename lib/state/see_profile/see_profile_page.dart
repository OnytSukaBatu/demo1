import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/state/see_profile/see_profile_getx.dart';

class SeeProfilePage extends StatelessWidget {
  SeeProfilePage({super.key});

  final SeeProfileGetx get = Get.put(SeeProfileGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: W.text(
          text: get.email,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Obx(
        () => get.loading.value
            ? SizedBox()
            : Column(
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
                                              text: get.follower.length.toString(),
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
                                          W.text(
                                            text: '0',
                                            fontSize: 12,
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
                          Obx(
                            () => W.button(
                              onPressed: get.doFollow,
                              width: double.infinity,
                              backgroundColor: get.follower.contains(get.myUser.email) ? Colors.grey[50] : Colors.grey[900],
                              borderRadius: BorderRadius.circular(5),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: W.text(
                                text: get.follower.contains(get.myUser.email) ? 'Mengikuti' : 'Ikuti',
                                fontSize: 12,
                                color: get.follower.contains(get.myUser.email) ? Colors.black : Colors.white,
                              ),
                            ),
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
                          return GestureDetector(
                            onTap: () => get.postDetail(data),
                            child: Image.memory(
                              base64Decode(data.image[index]),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
