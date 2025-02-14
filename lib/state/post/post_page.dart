import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/post/post_getx.dart';

class PostPage extends StatelessWidget {
  PostPage({super.key});

  final PostGetx get = Get.put(PostGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: W.text(
          text: 'Posting',
          fontSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Obx(
                  () => Container(
                    height: Get.width,
                    width: Get.width,
                    color: Colors.grey[200],
                    child: Center(
                      child: get.imageList.isNotEmpty
                          ? PageView(
                              onPageChanged: get.onPageChanged,
                              children: List.generate(
                                get.imageList.length,
                                (index) => Image.memory(
                                  base64Decode(get.imageList[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: get.pickImage,
                              child: Column(
                                mainAxisAlignment: Ma.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                  W.text(
                                    text: 'Upload Gambar',
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: get.imageList.isNotEmpty,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      margin: EdgeInsets.only(top: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: W.text(
                        text: '${get.indexImage.value}/${get.imageList.length}',
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  W.input(
                    controller: get.desc,
                    hintText: 'Deskripsi',
                    fontSize: 12,
                    focusedBorder: InputBorder.none,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: W.button(
            onPressed: get.post,
            width: double.infinity,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(5),
            child: W.text(
              text: 'Posting',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
