import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:seller_shop/utils/app_constant.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});


  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addItem() {
    String imageUrl = _imageController.text.trim();
    String name = _nameController.text.trim();
    String subName = _subNameController.text.trim();
    String amount = _amountController.text.trim();
    String description = _descriptionController.text.trim();

    if (name.isNotEmpty && description.isNotEmpty) {
      // Add item to Firestore
      FirebaseFirestore.instance.collection('items').add({
        'imageUrl' : imageUrl,
        'name': name,
        'subName' : subName,
        'amount' : amount,
        'description': description,
      }).then((_) {
        // Clear text fields after successful addition
        _imageController.clear();
        _nameController.clear();
        _subNameController.clear();
        _amountController.clear();
        _descriptionController.clear();


        Get.snackbar("Item", "Item added successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondPrimaryColor,
            colorText: AppConstant.appTextColor);
      }).catchError((error) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });
    } else {
      // Show error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appPrimaryColor,
        title: const Text(
          "Add Products",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _imageController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "image Url",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Product Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _subNameController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Sub Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _amountController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Total Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _descriptionController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
                onPressed: _addItem,
                child: const Text('Add Item',style: TextStyle(color: AppConstant.appTextColor),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
