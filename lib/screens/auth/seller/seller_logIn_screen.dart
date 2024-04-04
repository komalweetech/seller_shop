import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/controllers/get_user_data_controller.dart';
import 'package:seller_shop/controllers/seller_signIn_controller.dart';
import 'package:seller_shop/screens/auth/seller/forgotpassword_screen.dart';
import 'package:seller_shop/screens/auth/seller/seller_singUp_screen.dart';
import 'package:seller_shop/screens/home/dashboard_screen.dart';
import 'package:seller_shop/utils/app_constant.dart';
import 'package:seller_shop/screens/admin/admin_main_screen.dart';

class SellerLoginScreen extends StatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final SellerSignInController sellerSignInController = Get.put(SellerSignInController());

    // final GetUserDataController getUserDataController = Get.put(GetUserDataController());

    TextEditingController sellerEmail = TextEditingController();
    TextEditingController sellerPassword = TextEditingController();
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondPrimaryColor,
            title: Text(
              "SignIn",
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
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: sellerEmail,
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
                        child: Obx(
                          () => TextFormField(
                            controller: sellerPassword,
                            obscureText:
                                SellerSignInController.isPasswordVisibile.value,
                            cursorColor: AppConstant.appSecondPrimaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    SellerSignInController.isPasswordVisibile
                                        .toggle();
                                  },
                                  child: SellerSignInController
                                          .isPasswordVisibile.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Get.offAll(const ForgotPasswordScreen()),
                      child: const Text(
                        "Forget Password",
                        style: TextStyle(
                            color: AppConstant.appSecondPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 40,
                  ),
                  Material(
                      child: Container(
                    width: Get.width / 1.2,
                    height: Get.height / 15,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(
                            color: AppConstant.appTextColor, fontSize: 17),
                      ),
                      onPressed: () async {
                        String email = sellerEmail.text.trim();
                        String password = sellerPassword.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          log("Please Fill all the Details");
                          Get.snackbar("Error", "Please Enter all Details ",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  AppConstant.appSecondPrimaryColor,
                              colorText: AppConstant.appTextColor);
                        } else {
                          log("userCredential");
                          UserCredential? userCredential =
                              await sellerSignInController.singInMethod(email, password);

                          // var userData = await getUserDataController.getUserData(userCredential!.user!.uid);
                          if (userCredential != null) {
                            // for check user id Admin or user
                            // if(userData[0]['isAdmin'] == true){
                            //   Get.snackbar("Success login for Admin side",
                            //       "login Successfully ",
                            //       snackPosition: SnackPosition.BOTTOM,
                            //       backgroundColor:
                            //       AppConstant.appSecondPrimaryColor,
                            //       colorText: AppConstant.appTextColor);
                            //
                            //   Get.offAll(() => AdminMainScreen());
                            // }else {
                            //   Get.offAll(DashBoardScreen());
                            // }
                            log("login successfuly");
                            Get.snackbar("Success", "login Successfully ",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          AppConstant.appSecondPrimaryColor,
                                      colorText: AppConstant.appTextColor);

                            Get.offAll(() => const DashBoardScreen());
                          } else {
                            Get.snackbar("Error", "Please try again",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:
                                    AppConstant.appSecondPrimaryColor,
                                colorText: AppConstant.appTextColor);
                          }
                        }
                      },
                    ),
                  )),
                  SizedBox(
                    height: Get.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style:
                            TextStyle(color: AppConstant.appSecondPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAll(SellerSingUpScreen()),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: AppConstant.appSecondPrimaryColor),
                        ),
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
