import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seller_shop/screens/home/dashboard_screen.dart';
import 'package:seller_shop/utils/app_constant.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});


  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController _image0Controller = TextEditingController();
  final TextEditingController _image1Controller = TextEditingController();
  final TextEditingController _image2Controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _createAtController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addItem() {
    String image0Url = _image0Controller.text.trim();
    String image1Url = _image1Controller.text.trim();
    String image2Url = _image2Controller.text.trim();
    String name = _nameController.text.trim();
    String createAt = _createAtController.text.trim();
    String amount = _amountController.text.trim();
    String productId = _productIdController.text.trim();
    String deliveryTime = _productIdController.text.trim();
    String updatedAt = _productIdController.text.trim();
    String description = _descriptionController.text.trim();

    List<String> imageUrls = [image0Url, image1Url,image2Url];
    if (name.isNotEmpty ||
        description.isNotEmpty ||
        image0Url.isNotEmpty ||
        image1Url.isNotEmpty  ||
        image2Url.isNotEmpty ||
        createAt.isNotEmpty ||
        productId.isNotEmpty ||
        deliveryTime.isNotEmpty ||
        updatedAt.isNotEmpty ||
        amount.isNotEmpty
    ) {
      // Add item to Firestore
      FirebaseFirestore.instance.collection('items').add({
        'productId' : productId,
        'productName': name,
        'fullPrice' : amount,
        'productImages' : imageUrls,
        'deliveryTime' : deliveryTime,
        'productDescription': description,
        'createdAt' : createAt,
        'updatedAt' : updatedAt,
      }).then((_) {
        // Clear text fields after successful addition
        _image0Controller.clear();
        _image1Controller.clear();
        _image2Controller.clear();
        _nameController.clear();
        _createAtController.clear();
        _amountController.clear();
        _productIdController.clear();
        _updatedAtController.clear();
        _deliveryTimeController.clear();
        _descriptionController.clear();

        Get.snackbar("Item", "Item added successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appSecondPrimaryColor,
            colorText: AppConstant.appTextColor,
            duration: Duration(seconds: 2),
            );
        Future.delayed(Duration(seconds: 2), () {
          Get.offAll(DashBoardScreen());
        });

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
              Align(
                alignment: Alignment.topLeft,
                  child: Text('Images')),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _image0Controller,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "image 0",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _image1Controller,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "image 1",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _image2Controller,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "image 2",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(06),
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
                  padding: const EdgeInsets.all(06),
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
                  padding: const EdgeInsets.all(06),
                  child: TextFormField(
                    controller: _productIdController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Product Id",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(06),
                  child: TextFormField(
                    controller: _createAtController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Create At",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(06),
                  child: TextFormField(
                    controller: _deliveryTimeController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "DeliveryTime",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(06),
                  child: TextFormField(
                    controller: _updatedAtController,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "UpdatedAt",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(06),
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
