import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/state/content/content_getx.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final ContentGetx get = Get.put(ContentGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kovalskia',
          style: GoogleFonts.dancingScript(
            fontSize: 32,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            get.init();
          },
          backgroundColor: Colors.white,
          color: Colors.black,
          child: Obx(
            () => ListView.builder(
              itemCount: get.postList.length,
              itemBuilder: (context, index) {
                final Post post = get.postList[index];
                RxList like = get.postList[index].like.obs;
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      W.gap(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                get.seeProfile(email: post.email);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: post.profile.isEmpty
                                      ? Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.memory(
                                            base64Decode(post.profile),
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
                                  text: post.username,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                W.text(
                                  text: post.email,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                get.menuPost(
                                  id: post.id!,
                                  email: post.email,
                                );
                              },
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
                            post.image.length,
                            (index) => InkWell(
                              onTap: () {
                                get.checkImage(image: post.image[index]);
                              },
                              child: Image.memory(
                                base64Decode(post.image[index]),
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
                              onTap: () {
                                get.doLike(
                                  id: post.id!,
                                  listLike: like,
                                );
                              },
                              child: Obx(
                                () => Icon(
                                  like.contains(get.user.email) ? Icons.favorite : Icons.favorite_outline,
                                  color: like.contains(get.user.email) ? Colors.red : Colors.black,
                                ),
                              ),
                            ),
                            W.gap(width: 8),
                            InkWell(
                              onTap: () => get.openComment(id: post.id!),
                              child: Icon(
                                Icons.comment,
                              ),
                            ),
                            const Spacer(),
                            W.text(
                              text: C.format(
                                format: 'dd MMM yyyy',
                                time: post.date.toDate(),
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
                            text: post.desc,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      W.gap(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
