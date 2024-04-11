import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seller_shop/utils/app_constant.dart';

class TotalOrders extends StatefulWidget {
  const TotalOrders({super.key});

  @override
  State<TotalOrders> createState() => _TotalOrdersState();
}

class _TotalOrdersState extends State<TotalOrders> {

  Future<int> getTotalOrders() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .get();
    print(querySnapshot);

    List<DocumentSnapshot> documents = querySnapshot.docs;
    int totalOrders = documents.length;
    print("total order = $totalOrders");
    return documents.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalOrders();
    print(getTotalOrders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          FutureBuilder(
           future: getTotalOrders(),
            builder: (context,snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator while waiting for data
              }
              else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }else {
                int? totalOrders = snapshot.data;
                print("total orders == $totalOrders");
                return Container(
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
                            'Total Orders',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppConstant.appTextColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            totalOrders.toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                color: AppConstant.appTextColor),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }



              return Container();
            },
          ),
        ],
      ),
    ));
  }
}
