import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:seller_shop/models/sellerModel.dart';
import 'package:seller_shop/utils/app_constant.dart';

class SellerSingUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //for password visibilty
  static var  isPasswordVisibile = true.obs;

  Future<UserCredential?> singUpMethod(
    String sellerName,
    String sellerPhone,
    String sellerCity,
    String sellerEmail,
    String sellerPassword,
    String sellerDeviceToken,
  ) async {
    try {
    EasyLoading.show(status: 'Please wait');
    UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: sellerEmail, password: sellerPassword);
      //send email verification
      await userCredential.user!.sendEmailVerification();

      SellerModel sellerModel = SellerModel(
        sellerDeviceToken: sellerDeviceToken,
        sId: userCredential.user!.uid,
        name: sellerName,
        phone: sellerPhone,
        city: sellerCity,
        email: sellerEmail,
        password: sellerPassword,
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      // add this data to firebase store
      _firebaseFirestore.collection('seller')
          .doc(userCredential.user?.uid)
          .set(sellerModel.toMap());
EasyLoading.dismiss();
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
