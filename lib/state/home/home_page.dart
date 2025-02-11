import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kovalskia/state/home/home_getx.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeGetx get = Get.put(HomeGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => get.page[get.index.value]),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: get.index.value,
          onTap: get.navigate,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
