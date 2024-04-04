import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_shop/utils/app_constant.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // log out dialog box
    void _showSignOutDialog(BuildContext context) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Out'),
            content: Text('Are you sure you want to sign out?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',style: TextStyle(color: AppConstant.appTextColor),),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop(); // Close the dialog
                    // Navigate to the login screen or any other screen after sign-out
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


    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child:  Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        backgroundColor: AppConstant.appSecondPrimaryColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Setting",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                subtitle: Text('Version 1.0.1',
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppConstant.appPrimaryColor,
                  child: Text("W",
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
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Total Product",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(Icons.production_quantity_limits,
                    color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Total Orders",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading:
                    Icon(Icons.shopping_bag, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Contact",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(Icons.help, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
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
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(Icons.logout, color: AppConstant.appTextColor),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
