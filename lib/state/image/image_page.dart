import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/state/image/image_getx.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  ImagePage({super.key});

  final ImageGetx get = Get.put(ImageGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1,
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: MemoryImage(
            base64Decode(get.imagePath),
          ),
        ),
      ),
    );
  }
}
