import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

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
    );
  }
}
