import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:seller_shop/screens/auth/seller/seller_logIn_screen.dart';

import '../../../utils/app_constant.dart';

class SellerSingUpScreen extends StatefulWidget {
  const SellerSingUpScreen({super.key});

  @override
  State<SellerSingUpScreen> createState() => _SellerSingUpScreenState();
}

class _SellerSingUpScreenState extends State<SellerSingUpScreen> {
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
                child: Text("Welcome to my app",style: TextStyle(
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
                      onPressed: () {},
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
