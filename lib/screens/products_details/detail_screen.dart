import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seller_shop/models/product_model.dart';
import 'package:seller_shop/screens/products_details/update_product_details.dart';
import '../../utils/app_constant.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // delete dialog
    Future<void> _showDeleteDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Product'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to delete this product?'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  // Delete the product from Firestore
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.productModel.productId)
                      .delete()
                      .then((_) {
                    Get.back(); // Navigate back to previous screen
                  }).catchError((error) {
                    // Error while deleting
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  });
                },
              ),
            ],
          );
        },
      );
    }


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appPrimaryColor,
        title: const Text(
          "Product Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
_showDeleteDialog();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(
                        widget.productModel.productImages[selectedIndex]),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: widget.productModel.productImages.map((image) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        radius: 8,
                        onTap: () {
                          setState(() {
                            selectedIndex = widget.productModel.productImages
                                .indexOf(image);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: AppConstant.appTextColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.productModel.productImages
                                          .indexOf(image) ==
                                      selectedIndex
                                  ? Colors.red
                                  : Colors.transparent,
                            ),
                          ),
                          child: Image(
                              image: NetworkImage(image),
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover),
                        ),
                      ); //.paddingRight(8);
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.productName,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.productModel.createdAt,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text("\$ ${widget.productModel.fullPrice}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("Available Sizes",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text(
                          "US 7",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text("US 8",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text(
                          "US 9",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text(
                          "US 10",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16, width: 16),
                  Text("Description",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(
                    widget.productModel.productDescription,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstant.appPrimaryColor),
                      onPressed: ()  async {
                     await Get.to(UpdateProductDetails(productModel: widget.productModel,));
                      },
                      child: const Text(
                        'Update this Product',
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
