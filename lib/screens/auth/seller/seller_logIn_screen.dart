import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/screens/auth/seller/seller_singUp_screen.dart';
import 'package:seller_shop/utils/app_constant.dart';

class SellerLoginScreen extends StatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondPrimaryColor,
            title: Text(
              "SingIn",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  isKeyboardVisible
                      ? SizedBox()
                      : Container(
                          width: Get.width,
                          color: AppConstant.appSecondPrimaryColor,
                          child: Lottie.asset(
                            "assets/images/login.json",
                          ),
                        ),
                  SizedBox(height: Get.height /20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondPrimaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondPrimaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: Icon(Icons.visibility_off),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Text("Forget Password",
                      style: TextStyle(color: AppConstant.appSecondPrimaryColor,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: Get.height / 40,),
                  Material(
                    child: Container(
                      width: Get.width /1.2,
                      height: Get.height / 15,
                      decoration: BoxDecoration(
                        color: AppConstant.appSecondPrimaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextButton(
                        child: Text("SIGN IN",style: TextStyle(color: AppConstant.appTextColor,fontSize: 17),),
                        onPressed: () {},
                      ),
                      )
                  ),
                  SizedBox(height: Get.height / 40,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                        style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                      GestureDetector(
                        onTap: () => Get.offAll(SellerSingUpScreen()),
                        child: Text("Sign Up",
                          style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
