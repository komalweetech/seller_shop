import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:seller_shop/screens/auth/seller/seller_logIn_screen.dart';
import 'package:seller_shop/utils/app_constant.dart';

class SellerForgotPassController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  Future<void> forgotPassMethod(
      String sellerEmail,
      ) async {
    try {
      EasyLoading.show(status: 'Please wait');

    await _auth.sendPasswordResetEmail(email: sellerEmail);
      Get.snackbar("Request Sent Sucessfully",
          "Password reset link sent to $sellerEmail",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);

     Get.offAll(() => SellerLoginScreen());
      EasyLoading.dismiss();
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