import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_shop/screens/auth/seller/seller_logIn_screen.dart';
import 'package:seller_shop/screens/auth/seller/update_Profile_screen.dart';
import 'package:seller_shop/screens/drower/company_screen.dart';
import 'package:seller_shop/screens/drower/current_order_screen.dart';
import 'package:seller_shop/screens/drower/finance_control.dart';
import 'package:seller_shop/screens/drower/previous_order_screen.dart';
import 'package:seller_shop/screens/drower/status_update_screen.dart';
import 'package:seller_shop/utils/app_constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
 List<QuerySnapshot> seller = [];
 late Map<String, dynamic> sellerData;

 User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getSellerData();
    print("user id == ${user!.uid}");
  }

 Future<void> getSellerData() async {
   final user = FirebaseAuth.instance.currentUser;
   if (user != null) {
     final sellerDoc = await FirebaseFirestore.instance.collection('seller').doc().get();
     if (sellerDoc.exists) {
       setState(() {
         sellerData = sellerDoc.data() as Map<String, dynamic>;
       });
       print(" seller data = ${sellerData}");

     }
   }
 }

  // log out dialog box
  void _showSignOutDialog(BuildContext context) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel',style: TextStyle(color: AppConstant.appTextColor),),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(); // Close the dialog
                  Get.to(SellerLoginScreen());
                } catch (e) {
                  print("Error signing out: $e");
                  // Handle sign-out errors
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child:  Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        backgroundColor: AppConstant.appTextColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "qkdn",
                  style: TextStyle(color: AppConstant.appPrimaryColor,fontWeight: FontWeight.w700),
                ),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appPrimaryColor,
                  child: Text(
                    "c",
                      // sellerName.isNotEmpty ? sellerName[0] : '',
                      style: TextStyle(color: AppConstant.appTextColor)),
                ),
              ),
            ),
            const Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Profile",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: const Icon(
                  Icons.person,
                  color: AppConstant.appPrimaryColor,
                ),
                trailing:
                const Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(const UpdateProfileScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Current Orders",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: const Icon(Icons.production_quantity_limits,
                    color: AppConstant.appPrimaryColor),
                trailing:
                const Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(const CurrentOrderScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Previous Orders",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading:
                const Icon(Icons.add_shopping_cart, color: AppConstant.appPrimaryColor),
                trailing:
                const Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(const PreviousOrderScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Status Update",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: const Icon(Icons.help, color: AppConstant.appPrimaryColor),
                trailing: const Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(const StatusUpdateScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Finance Order",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: Icon(Icons.help, color: AppConstant.appPrimaryColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(FinanceControl());
                } ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Company",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: Icon(Icons.branding_watermark, color: AppConstant.appPrimaryColor),
                trailing: Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
                onTap: () {
                  Get.to(CompanyScreen());
                } ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                onTap: (){
                  _showSignOutDialog(context);
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text("Log Out",
                    style: TextStyle(color: AppConstant.appPrimaryColor)),
                leading: Icon(Icons.logout, color: AppConstant.appPrimaryColor),
                trailing:
                Icon(Icons.arrow_forward, color: AppConstant.appPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
