import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:seller_shop/utils/app_constant.dart';

class SellerSignInController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //for password visibilty
  static var  isPasswordVisibile = true.obs;

  Future<UserCredential?> singInMethod(
      String sellerEmail,
      String sellerPassword,
      ) async {
    try {
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: sellerEmail, password: sellerPassword);

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      log("$e");
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}