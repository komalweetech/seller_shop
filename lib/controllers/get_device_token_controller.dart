import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:seller_shop/utils/app_constant.dart';


class GetDeviceTokenController extends GetxController {
    String? deviceToken;

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceToken();
  }
  Future<void> getDeviceToken () async {
    try{
    String? token = FirebaseMessaging.instance.getToken().toString();

    if(token != null) {
      deviceToken = token;
      update();
    }
    }catch (e){
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}