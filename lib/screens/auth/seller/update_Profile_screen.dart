import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:seller_shop/screens/home/dashboard_screen.dart';

import '../../../utils/app_constant.dart';



class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController sellerName;
  late TextEditingController sellerPhone;
  late TextEditingController sellerCity;
  late TextEditingController sellerEmail;
  late TextEditingController sellerPassword;

  @override
  void initState() {
    super.initState();

    sellerName = TextEditingController();
    sellerPhone = TextEditingController();
    sellerCity = TextEditingController();
    sellerEmail = TextEditingController();
    sellerPassword = TextEditingController();

    fetchData();
  }

  @override
  void dispose() {
    sellerName.dispose();
    sellerPhone.dispose();
    sellerCity.dispose();
    sellerEmail.dispose();
    sellerPassword.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('seller').doc(FirebaseAuth.instance.currentUser!.uid).get();
     print("seller profile data == ${snapshot.data().toString()}");

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          sellerName.text = data['name'] ?? '';
          sellerPhone.text = data['phoneNumber'] ?? '';
          sellerCity.text = data['city'] ?? '';
          sellerEmail.text = data['email'] ?? '';
          sellerPassword.text = data['password'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondPrimaryColor,
        title: const Text(
          "Update Profile data",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: sellerName,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: sellerPhone,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextFormField(
                    controller: sellerCity,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    controller: sellerEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: sellerPassword,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('seller').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'name': sellerName.text,
                        'phoneNumber': sellerPhone.text,
                        'city': sellerCity.text,
                        'email': sellerEmail.text,
                        'password': sellerPassword.text,
                        // Update any other fields here
                      });
                      Get.snackbar("Update", "Update your profile ",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondPrimaryColor,
                          colorText: AppConstant.appTextColor);
                      Get.to(DashBoardScreen());
                    },
                    child: const Text('Update',style: TextStyle(color: AppConstant.appTextColor),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
