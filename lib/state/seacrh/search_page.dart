import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/seacrh/search_getx.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchGetx get = Get.put(SearchGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: W.input(
                      controller: get.input,
                      hintText: 'Cari User',
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  InkWell(
                    onTap: get.search,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: get.listUser.length,
                  itemBuilder: (context, index) {
                    final User user = get.listUser[index];
                    return ListTile(
                      onTap: () => get.seeUser(user.email),
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: user.profile.isNotEmpty
                              ? Image.memory(
                                  base64Decode(user.profile),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      title: W.text(
                        text: user.username,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      subtitle: W.text(
                        text: user.email,
                        fontSize: 10,
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
