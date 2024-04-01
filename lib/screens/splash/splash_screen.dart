import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/screens/splash/welcome_screen.dart';

import '../../utils/app_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3) ,() {
      Get.offAll(const WelcomeScreen());
    });
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
            Container(
              width: Get.width,
              alignment: Alignment.center,
              child: const Text("Shop for You",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppConstant.appTextColor),),
            )
          ],
        ),
      ),
    );
  }
}
