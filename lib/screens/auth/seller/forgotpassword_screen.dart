import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/controllers/seller_forgotPassword.dart';
import 'package:seller_shop/utils/app_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final SellerForgotPassController sellerForgotPassController =
  Get.put(SellerForgotPassController());

  TextEditingController sellerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConstant.appSecondPrimaryColor,
              title: Text(
                "ForgotPassword",
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
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Material(
                        child: Container(
                          width: Get.width / 2,
                          height: Get.height / 18,
                          decoration: BoxDecoration(
                            color: AppConstant.appSecondPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextButton(
                            child: const Text(
                              "Forgot",
                              style: TextStyle(
                                  color: AppConstant.appTextColor, fontSize: 17),
                            ),
                            onPressed: () async {
                              String email = sellerEmail.text.trim();

                              if (email.isEmpty) {
                                log("Please Fill all the Details");
                                Get.snackbar("Error", "Please Enter all Details ",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                    AppConstant.appSecondPrimaryColor,
                                    colorText: AppConstant.appTextColor);
                              } else {
                        String email = sellerEmail.text.trim();
                        sellerForgotPassController.forgotPassMethod(email);
                              }
                            },
                          ),
                        )),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
