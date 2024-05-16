import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/product_model.dart';
import '../../utils/app_constant.dart';
import '../../widgets/card_widget.dart';
import '../products_details/detail_screen.dart';

class TotalProduct extends StatefulWidget {
  const TotalProduct({super.key});

  @override
  State<TotalProduct> createState() => _TotalProductState();
}

class _TotalProductState extends State<TotalProduct> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Firestore stream: Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Firestore stream error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          print('Firestore stream: Data received...');
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              print("document data = ${snapshot.data!.docs[index]}");
              final productData = snapshot.data!.docs[index];
              ProductModel productModel = ProductModel(
                productId: productData['productId'],
                productName: productData['productName'],
                fullPrice: productData['fullPrice'],
                productImages: productData['productImages'],
                deliveryTime: productData['deliveryTime'],
                productDescription: productData['productDescription'],
                createdAt: productData['createdAt'],
                updatedAt: productData['updatedAt'],
              );
              // DocumentSnapshot document = snapshot.data!.docs[index];
              // Map<String, dynamic> data =
              // document.data() as Map<String, dynamic>;
              // String imageUrl = data['imageUrl'][0] ?? '';
              // String name = data['productName'] ?? '';
              // String subName = data['createdAt'] ?? '';
              // String amount = data['fullPrice'] ?? '';
              // String description = data['productDescription'] ?? '';
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  // child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(14.0),
                  //     child: GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         height: Get.height / 6,
                  //         width: Get.width,
                  //         child: Image.network(
                  //           imageUrl,
                  //           fit: BoxFit.cover,
                  //           height: 100, // Adjust the height as needed
                  //         ),
                  //       ),
                  //     )),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          Get.to(DetailScreen(
                           productModel: productModel,
                          ));
                        },
                        onLongPress: () {
                          _showDeleteConfirmationDialog(
                              context, productData.reference);
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: SizedBox(
                                height: Get.height / 3,
                                width: Get.width,
                                child: Image.network(
                                  productModel.productImages.first, fit: BoxFit.cover,),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: CardWidget(
                                name: productModel.productName,
                                subName: productModel.createdAt,
                                amount: productModel.fullPrice,),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
            separatorBuilder: (context, index) {
              print('Building separator $index');
              return const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 1,
              );
            },
          );
        },
      ),
    );
  }
  // Function to show delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context,
      DocumentReference documentReference) {
    print('Showing delete confirmation dialog...');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item",style: TextStyle(fontWeight: FontWeight.w700),),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            ElevatedButton (
              style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
              onPressed: () {
                Navigator.of(context).pop(); // Close AlertDialog
              },
              child: const Text("Cancel",style: TextStyle(color: AppConstant.appTextColor),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _deleteItem(documentReference);
                Navigator.of(context).pop(); // Close AlertDialog
              },
              child: const Text("Delete",style: TextStyle(color: AppConstant.appTextColor),),
            ),
          ],
        );
      },
    );
  }

// Function to delete item from Firebase Firestore
  void _deleteItem(DocumentReference documentReference) {
    print('Deleting item from Firestore...');
    documentReference.delete();
  }
}
