import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/screens/auth/seller/seller_logIn_screen.dart';

import '../../utils/app_constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondPrimaryColor,
        title: const Text(
          "Wellcome to my App",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              color: AppConstant.appSecondPrimaryColor,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                child: Lottie.asset(
                  "assets/images/splash.json",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Happy Shopping",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appSecondPrimaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                    onPressed: () {
                      Get.to(SellerLoginScreen());
                    },
                    icon: Image.asset(
                      "assets/icon/google.png",
                      width: Get.width / 12,
                      height: Get.height / 12,
                    ),
                    label: Padding(
                      padding:  EdgeInsets.only(left: 10),
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(
                            color: AppConstant.appTextColor, fontSize: 17),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appSecondPrimaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                    onPressed: () {
                      Get.to(SellerLoginScreen());
                    },
                    icon: Image.asset(
                      "assets/icon/mail.png",
                      width: Get.width / 12,
                      height: Get.height / 12,
                      color: AppConstant.appTextColor,
                    ),
                    label: Padding(
                      padding:  EdgeInsets.only(left: 12),
                      child: Text(
                        "Sign in with Email",
                        style: TextStyle(
                            color: AppConstant.appTextColor, fontSize: 17),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
