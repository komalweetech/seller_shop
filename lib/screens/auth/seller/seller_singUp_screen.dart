import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:seller_shop/controllers/seller_singUp_controller.dart';
import 'package:seller_shop/screens/auth/seller/seller_logIn_screen.dart';

import '../../../utils/app_constant.dart';

class SellerSingUpScreen extends StatefulWidget {
  const SellerSingUpScreen({super.key});

  @override
  State<SellerSingUpScreen> createState() => _SellerSingUpScreenState();
}

class _SellerSingUpScreenState extends State<SellerSingUpScreen> {
  final SellerSingUpController sellerSingUpController = Get.put(SellerSingUpController());

  TextEditingController sellerName = TextEditingController();
  TextEditingController sellerPhone = TextEditingController();
  TextEditingController sellerCity = TextEditingController();
  TextEditingController sellerEmail = TextEditingController();
  TextEditingController sellerPassword = TextEditingController();

  void createAccount() async {
    String name = sellerName.text.trim();
    String phone = sellerPhone.text.trim();
    String city = sellerCity.text.trim();
    String email = sellerEmail.text.trim();
    String password = sellerPassword.text.trim();
    String sellerDeviceToken = " ";

    if (name.isEmpty || phone.isEmpty || city.isEmpty || phone.isEmpty ||
        password.isEmpty) {
      Get.snackbar("Error", "Please Enter all Details ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    } else {
      UserCredential? userCredential = await sellerSingUpController
          .singUpMethod(
        name,
        phone,
        city,
        email,
        password,
        // sellerDeviceToken
      );

      if (userCredential != null) {
        Get.snackbar("Verification Email sent.", "Please Check your Email.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondPrimaryColor,
            colorText: AppConstant.appTextColor);

        FirebaseAuth.instance.signOut();

        Get.offAll(() => const SellerLoginScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondPrimaryColor,
        title: Text(
          "SingUp",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Get.height /20,),
              Container(
                alignment: Alignment.center,
                child: const Text("Welcome to my app",style: TextStyle(
                    fontWeight: FontWeight.bold,
                fontSize: 16,color: AppConstant.appSecondPrimaryColor),),
              ),
              SizedBox(height: Get.height /20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: sellerName,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "UserName",
                        prefixIcon: Icon(Icons.person),
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
                    controller: sellerPhone,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
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
                    controller: sellerCity,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "city",
                        prefixIcon: Icon(Icons.location_on),
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
                        obscureText: SellerSingUpController.isPasswordVisibile.value,
                        cursorColor: AppConstant.appSecondPrimaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                SellerSingUpController.isPasswordVisibile.toggle();
                              },
                                child:SellerSingUpController.isPasswordVisibile.value ?
                                Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                  )
                ),
              ),
              SizedBox(height: Get.height / 40,),
              Material(
                  child: Container(
                    width: Get.width /2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: Text("SIGN Up",style: TextStyle(color: AppConstant.appTextColor,fontSize: 17),),
                      onPressed: () async {
                        String name = sellerName.text.trim();
                        String phone = sellerPhone.text.trim();
                        String city = sellerCity.text.trim();
                        String email = sellerEmail.text.trim();
                        String password = sellerPassword.text.trim();
                        String sellerDeviceToken = " ";

                        if(name.isEmpty || phone.isEmpty || city.isEmpty || phone.isEmpty || password.isEmpty) {
                          Get.snackbar("Error", "Please Enter all Details ",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondPrimaryColor,
                              colorText: AppConstant.appTextColor);
                        }else{
                           UserCredential? userCredential = await sellerSingUpController.singUpMethod(
                               name,
                               phone,
                               city,
                               email,
                               password,
                               // sellerDeviceToken
                           );

                           if(userCredential != null) {
                             Get.snackbar("Verification Email sent.", "Please Check your Email.",
                                 snackPosition: SnackPosition.BOTTOM,
                                 backgroundColor: AppConstant.appSecondPrimaryColor,
                                 colorText: AppConstant.appTextColor);

                             FirebaseAuth.instance.signOut();

                             Get.offAll(() =>const SellerLoginScreen());
                           }
                        }

                        },
                    ),
                  )
              ),
              SizedBox(height: Get.height / 40,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                  GestureDetector(
                    onTap: () => Get.offAll(SellerLoginScreen()),
                    child: Text("Sign in",
                      style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
