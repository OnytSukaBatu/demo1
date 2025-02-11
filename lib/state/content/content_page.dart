import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kovalskia/state/content/content_getx.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});

  final ContentGetx get = Get.put(ContentGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kovalskia',
          style: GoogleFonts.dancingScript(
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.email),
          ),
        ],
      ),
      body: IconButton(
        onPressed: get.init,
        icon: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}
