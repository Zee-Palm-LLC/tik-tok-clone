import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/colors.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/views/screens/add_video_screen.dart';
import 'package:tik_tok/app/modules/home/views/screens/profile_screen.dart';
import 'package:tik_tok/app/modules/home/views/screens/search_screen.dart';
import 'package:tik_tok/app/modules/home/views/screens/video_screen.dart';

import '../../widgets/home/custom_icon.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIdx = 0;
  List pages = [
    VideoScreen(),
    SearchScreen(),
    AddVideoScreen(),
    const Center(
      child: Text('Message'),
    ),
    ProfileScreen(uid: ac.user!.uid),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColors.mobileBackgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[pageIdx],
    );
  }
}

AuthController ac = Get.find<AuthController>();
