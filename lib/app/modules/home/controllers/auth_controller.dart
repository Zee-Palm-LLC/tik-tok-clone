import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/widgets/dialogs/loading_dialog.dart';
import 'package:tik_tok/app/services/database_services.dart';

import '../models/user_model.dart';

class AuthController extends GetxController {
  DatabaseServices db = DatabaseServices();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> _user;
  User? get user => _user.value;

  @override
  void onInit() {
    _user = Rx<User?>(null);
    _user.bindStream(firebaseAuth.authStateChanges());
    update();
    super.onInit();
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    showLoadingDialog(message: 'logging Please Wait!');
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      hideLoadingDialog();
      Get.close(1);
    } on Exception catch (e) {
      hideLoadingDialog();
      Get.snackbar('Login Failed', e.toString());
    }
  }

  Future<void> registerUser({
    required String profilePic,
    required String email,
    required String password,
    required String name,
  }) async {
    showLoadingDialog(message: 'Creating your account!');
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => createFirebaseUser(
                  user: UserModel(
                profilePic: profilePic,
                email: email,
                uid: firebaseAuth.currentUser!.uid,
                username: name,
              )));
      hideLoadingDialog();
      Get.close(1);
    } on Exception catch (e) {
      hideLoadingDialog();
      Get.snackbar('Error while creating your account!', e.toString());
    }
  }

  Future<void> createFirebaseUser({
    required UserModel user,
  }) async {
    try {
      await db.userCollection.doc(user.uid).set(user.toJson());
    } on FirebaseException catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<void> signout() async {
    try {
      await firebaseAuth.signOut();
    } on Exception catch (e) {
      Get.snackbar('Logout Failded', e.toString());
    }
  }
}
