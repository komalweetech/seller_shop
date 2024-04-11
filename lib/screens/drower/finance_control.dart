import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app_constant.dart';

class FinanceControl extends StatefulWidget {
  const FinanceControl({super.key});

  @override
  State<FinanceControl> createState() => _FinanceControlState();
}

class _FinanceControlState extends State<FinanceControl> {
  int totalProduct = 0;
  double totalProfit = 0.0;
  int currentOrderCount = 0;
  int previousOrderCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalProduct();
    calculateTotalProfit();
    getTotalCurrentOrders();
    getTotalPreviousOrders();
  }
 // get total Products
  Future<void> getTotalProduct() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('items')
        .get();
    setState(() {
      totalProduct = querySnapshot.size;
      print("all Previous orders =  $previousOrderCount" );
    });
  }
  // get all product price.
  Future<void> calculateTotalProfit() async {
    double tempTotalProfit = 0.0;
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('orders').get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    for (var doc in documents) {
      double orderTotalPrice = doc['productTotalPrice'];

      // Add the orderTotalPrice to the tempTotalProfit
      tempTotalProfit += orderTotalPrice;
    }
    setState(() {
      totalProfit = tempTotalProfit;
    });
    print("total profit = $totalProfit");
  }
  // get all current order.
  Future<void> getTotalCurrentOrders() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: false)
        .get();
    setState(() {
      currentOrderCount = querySnapshot.size;
      print("all current order =  $currentOrderCount" );
    });
  }
  // get all previous product.
  Future<void> getTotalPreviousOrders() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: true)
        .get();
    setState(() {
      previousOrderCount = querySnapshot.size;
      print("all Previous orders =  $previousOrderCount" );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(
            color: AppConstant.appTextColor
        ) ,
        backgroundColor: AppConstant.appPrimaryColor,
        title: const Text('Finance Status ',style: TextStyle(color: AppConstant.appTextColor),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height / 5,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Card(
                    color: AppConstant.appPrimaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            'Total Products',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appTextColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '$totalProduct',
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.appTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height / 5,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Card(
                    color: AppConstant.appPrimaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            'Total Profit',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appTextColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '\$ $totalProfit',
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.appTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height / 5,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child:  Card(
                    color: AppConstant.appPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            'Total Pending Orders',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appTextColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            currentOrderCount.toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.appTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height / 5,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child:  Card(
                    color: AppConstant.appPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 08,
                          ),
                          const Text(
                            'Total Delivered Orders',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appTextColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            previousOrderCount.toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.appTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
