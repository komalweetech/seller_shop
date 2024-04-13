import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:seller_shop/models/product_model.dart';

import '../../utils/app_constant.dart';

class UpdateProductDetails extends StatefulWidget {
  const UpdateProductDetails({super.key,required this.productModel});
  final ProductModel productModel;

  @override
  State<UpdateProductDetails> createState() => _UpdateProductDetailsState();
}

class _UpdateProductDetailsState extends State<UpdateProductDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final TextEditingController _image0Controller = TextEditingController();
  // final TextEditingController _image1Controller = TextEditingController();
  // final TextEditingController _image2Controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _createAtController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _updatedAtController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.productModel.productName;
    _createAtController.text = widget.productModel.createdAt;
    _amountController.text = widget.productModel.fullPrice;
    _deliveryTimeController.text = widget.productModel.deliveryTime;
    _updatedAtController.text = widget.productModel.updatedAt;
    _descriptionController.text = widget.productModel.productDescription;
  }

  // fetch data function
  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('items').doc().get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['productName'] ?? '';
          _createAtController.text = data['createdAt'] ?? '';
          _amountController.text = data['fullPrice'] ?? '';
          _deliveryTimeController.text = data['deliveryTime'] ?? '';
          _updatedAtController.text = data['updatedAt'] ?? '' ;
          _descriptionController.text = data['productDescription'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    _createAtController.dispose();
    _amountController.dispose();
    _deliveryTimeController.dispose();
    _updatedAtController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 3.0),
              //   width: Get.width,
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: TextFormField(
              //       controller: _image0Controller,
              //       cursorColor: AppConstant.appSecondPrimaryColor,
              //       keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //           labelText: "image 0",
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10.0))),
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 3.0),
              //   width: Get.width,
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: TextFormField(
              //       controller: _image1Controller,
              //       cursorColor: AppConstant.appSecondPrimaryColor,
              //       keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //           labelText: "image 1",
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10.0))),
              //     ),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 3.0),
              //   width: Get.width,
              //   child: Padding(
              //     padding: const EdgeInsets.all(15),
              //     child: TextFormField(
              //       controller: _image2Controller,
              //       cursorColor: AppConstant.appSecondPrimaryColor,
              //       keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //           labelText: "image 2",
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10.0))),
              //     ),
              //   ),
              // ),
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
                onPressed: () async {
                  try {
                    Get.snackbar("Updating", "Please wait...",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appSecondPrimaryColor,
                        colorText: AppConstant.appTextColor
                    );
                    String productId = widget.productModel.productId;

                    await FirebaseFirestore.instance.collection('items').doc(productId).update({
                      'productName': _nameController.text,
                      'createdAt': _createAtController.text,
                      'fullPrice': _amountController.text,
                      'deliveryTime': _deliveryTimeController.text,
                      'updatedAt' : _updatedAtController.text,
                      'productDescription' : _descriptionController.text
                    });

                    Get.snackbar("Update", "Product updated successfully",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppConstant.appSecondPrimaryColor,
                        colorText: AppConstant.appTextColor);
                    print("Snackbar shown");

                    Get.back();
                  }catch (error){
                    Get.snackbar("Error", "Failed to update product: $error",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white
                    );
                  }




                  print("Product updated successfully");

                  Get.back();
                  print("Back navigated");
                },
                child: const Text('Update',style: TextStyle(color: AppConstant.appTextColor),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
