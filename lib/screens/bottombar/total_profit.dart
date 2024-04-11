import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seller_shop/utils/app_constant.dart';

class TotalProfit extends StatefulWidget {
  const TotalProfit({super.key});

  @override
  State<TotalProfit> createState() => _TotalProfitState();
}

class _TotalProfitState extends State<TotalProfit> {
  double totalProfit = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateTotalProfit();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      child: Column(
        children: [
          const Text(
            "Total Profit",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppConstant.appPrimaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: Get.height / 4,
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
                      height: 10,
                    ),
                    const Text(
                      'Total Profit',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppConstant.appTextColor),
                    ),
                    SizedBox(
                      height: 30,
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
          )
        ],
      ),
    ));
  }
}
