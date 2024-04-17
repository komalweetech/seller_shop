
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
  Future<bool> checkAdminStatus(String userId) async {
    try {
      // Get user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await _firebaseFirestore.collection('seller').doc(userId).get();

      // Check if user document exists and isAdmin field is true
      if (userDoc.exists && userDoc.data()?['isAdmin'] == true) {
        return true; // User is admin
      } else {
        return false; // User is not admin
      }
    } catch (e) {
      // Handle any errors
      print("Error checking admin status: $e");
      return false; // Assume user is not admin in case of error
    }
  }

}
