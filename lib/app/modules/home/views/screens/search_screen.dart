import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/controllers/search_controller.dart';
import 'package:tik_tok/app/modules/home/models/user_model.dart';
import 'package:tik_tok/app/modules/home/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  SearchController sc = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => sc.searchUser(value),
          ),
        ),
        body: sc.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: sc.searchedUsers.length,
                itemBuilder: (context, index) {
                  UserModel user = sc.searchedUsers[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => ProfileScreen(uid: user.uid));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePic,
                        ),
                      ),
                      title: Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
