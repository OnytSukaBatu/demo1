import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/class.dart';
import 'package:kovalskia/main/main_widget.dart';
import 'package:kovalskia/state/edit_profile/edit_profile_getx.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfileGetx get = Get.put(EditProfileGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: W.text(
          text: 'Edit Profile',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: Ma.start,
              children: [
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey[200],
                      child: get.profile.value.isNotEmpty
                          ? ClipOval(
                              child: Image.memory(
                                base64Decode(get.profile.value),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.black,
                            ),
                    ),
                  ),
                ),
                W.gap(height: 16),
                W.text(
                  onTap: get.menuPickImage,
                  text: 'Ubah Photo Profile',
                  fontSize: 12,
                  color: Colors.blue,
                ),
                W.gap(height: 24),
                W.input(
                  controller: get.username,
                  hintText: 'Username',
                  fontSize: 12,
                  focusedBorder: OutlineInputBorder(),
                  readOnly: true,
                ),
                W.gap(height: 8),
                W.input(
                  controller: get.desc,
                  hintText: 'Deskripsi',
                  fontSize: 12,
                  focusedBorder: OutlineInputBorder(),
                ),
                W.gap(height: 16),
                W.button(
                  onPressed: get.save,
                  width: double.infinity,
                  backgroundColor: Colors.grey[900],
                  padding: EdgeInsets.symmetric(vertical: 10),
                  borderRadius: BorderRadius.circular(5),
                  child: W.text(
                    text: 'Simpan Perubahan',
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
