import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/controllers/get_user_data_controller.dart';
import 'package:seller_shop/screens/home/dashboard_screen.dart';
import 'package:seller_shop/screens/splash/welcome_screen.dart';

import '../../utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
// save user or admin for  this variable.
User? user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3) ,() {
      alreadyLoginUser(context);
      // Get.offAll(WelcomeScreen());
    });
  }

  // check user already loged in or new?
  Future<void> alreadyLoginUser (BuildContext context) async {
    if(user != null) {
      final GetUserDataController getUserDataController = Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      Get.to(const DashBoardScreen());

      // if(userData[0]['isAdmin'] == true) {
      //   Get.offAll(AdminMainScreen());
      // }else {
      //   Get.offAll(DashBoardScreen());
      // }
    }else{
      Get.to(WelcomeScreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondPrimaryColor,
      appBar: AppBar(
       backgroundColor: AppConstant.appSecondPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                child: Lottie.asset("assets/images/splash.json",),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: const Text("Shop for You",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppConstant.appTextColor),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
