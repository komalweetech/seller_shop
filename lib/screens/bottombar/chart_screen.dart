import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_shop/utils/app_constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  int totalProduct = 0;
  double totalProfit = 0.0;

  final List<SalesData> chartData = [
    // SalesData(profit: 2000, product: 1, color: AppConstant.appPrimaryColor),
    // SalesData(profit: 5000, product: 2, color: Colors.green),
    // SalesData(profit: 20000, product: 3, color: Colors.pink),
    // SalesData(profit: 7000, product: 4, color: Colors.black),
    // SalesData(profit: 3258, product: 5, color: Colors.deepOrange),
    // SalesData(profit: 12478, product: 6, color: Colors.deepPurple)
  ];

  Future<void> fetchProductData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'items').get();

      // Clear the existing chartData list
      chartData.clear();
      int index = 0;
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String productId = doc.id;
        print("product id = $productId");
        // Get total order count for the current product
        int totalOrders = await getTotalOrdersForProduct(productId);

        // Get total profit for the current product
        double totalProfit = await getTotalProfitForProduct(productId);
        // Create a SalesData object and add it to the chartData list
        chartData.add(SalesData(
            totalOrders: totalOrders,
            profit: totalProfit,
            product: index + 1,
            color: index % 2 == 0 ? AppConstant.appPrimaryColor : Colors.green)
        );

        index++;
      }
    } catch (e) {
      print('Error fetching product data: $e');
    }
  }

  Future<int> getTotalOrdersForProduct(String productId) async {
    int totalOrders = 0;

    try {
      // Query the 'orders' collection to get total orders for the specified product
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'orders').where('productId', isEqualTo: productId).get();

      // Calculate total order count
      totalOrders = querySnapshot.size;
      print("total Orders = $totalOrders");
    } catch (e) {
      print('Error retrieving total orders: $e');
    }

    return totalOrders;
  }

  Future<double> getTotalProfitForProduct(String productId) async {
    double totalProfit = 0.0;

    try {
      // Query the 'orders' collection to get total profit for the specified product
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'orders').where('productId', isEqualTo: productId).get();

      // Iterate through the documents and sum up the profits
      querySnapshot.docs.forEach((doc) {
        double profit = doc['productTotalPrice']; // Assuming this field contains the profit
        totalProfit += profit;

        print("total profit = $totalProfit");
      });
    } catch (e) {
      print('Error retrieving total profit: $e');
    }

    return totalProfit;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: fetchProductData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  legend: Legend(isVisible: true),
                  title: ChartTitle(text: 'Sales Data'),
                  series: [
                    ColumnSeries<SalesData, int>(
                      dataSource: chartData,
                      xValueMapper: (SalesData product, _) => product.product,
                      yValueMapper: (SalesData orders, _) => orders.totalOrders,
                      pointColorMapper: (SalesData color, _) =>
                      AppConstant.appPrimaryColor,
                      name: 'Product Orders',),


                    AreaSeries<SalesData, int>(

                      dataSource: chartData,
                      xValueMapper: (SalesData product, _) => product.product,
                      yValueMapper: (SalesData profit, _) => profit.profit,
                      pointColorMapper: (SalesData color, _) =>
                      AppConstant.appPrimaryColor,
                      name: 'Product Sales',
                    ),


                  ],
                );
            }
            },
          ),
        )
    );
  }
}

class SalesData {
  final int product;
  final int totalOrders;
  final double profit;
  final Color color;


  SalesData({
    required this.product,
    required this.totalOrders,
    required this.profit,
    required this.color,
  });
}
