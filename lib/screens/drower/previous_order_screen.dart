import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/app_constant.dart';

class PreviousOrderScreen extends StatefulWidget {
  const PreviousOrderScreen({super.key});

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreenState();
}

class _PreviousOrderScreenState extends State<PreviousOrderScreen> {
  int previousOrderCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalPreviousOrders();
  }
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
          title: const Text('Previous Orders',style: TextStyle(color: AppConstant.appTextColor),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
          child: Column(
            children: [
              const Text(
                "Total Orders from all users",
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
                child:  Card(
                  color: AppConstant.appPrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Total Previous Orders',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppConstant.appTextColor),
                        ),
                        const SizedBox(
                          height: 30,
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

            ],
          ),
        ));
  }
}
