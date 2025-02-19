import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/post_detail/post_detail_getx.dart';

class PostdetailPage extends StatelessWidget {
  PostdetailPage({super.key});

  final PostDetailGetx get = Get.put(PostDetailGetx());

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
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            W.gap(height: 8),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.memory(
                            base64Decode(get.post.profile),
                          ),
                        ),
                      ),
                    ),
                  ),
                  W.gap(width: 8),
                  Column(
                    crossAxisAlignment: Ca.start,
                    children: [
                      W.text(
                        text: get.post.username,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      W.text(
                        text: get.post.email,
                        fontSize: 10,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => get.menuPost(
                      get.post.email,
                      get.post.id!,
                    ),
                    child: Icon(Icons.more_vert),
                  ),
                  W.gap(width: 8),
                ],
              ),
            ),
            Container(
              height: Get.width,
              width: Get.width,
              color: Colors.grey,
              child: PageView(
                children: List.generate(
                  get.post.image.length,
                  (index) => InkWell(
                    onTap: () => get.checkImage(get.post.image[index]),
                    child: Image.memory(
                      base64Decode(get.post.image[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => get.doLike(get.post.id!, get.like),
                    child: Obx(
                      () => Icon(
                        get.like.contains(get.user.email) ? Icons.favorite : Icons.favorite_outline,
                        color: get.like.contains(get.user.email) ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                  W.gap(width: 8),
                  InkWell(
                    onTap: () => get.openComment(id: get.post.id!),
                    child: Icon(
                      Icons.comment,
                    ),
                  ),
                  const Spacer(),
                  W.text(
                    text: C.format(
                      format: 'dd MMM yyyy',
                      time: get.post.date.toDate(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: W.text(
                  text: get.post.desc,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            W.gap(height: 16),
          ],
        ),
      ),
    );
  }
}
