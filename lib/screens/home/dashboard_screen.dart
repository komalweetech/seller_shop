import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller_shop/screens/bottombar/chart_screen.dart';
import 'package:seller_shop/screens/bottombar/total_orders.dart';
import 'package:seller_shop/screens/bottombar/total_product.dart';
import 'package:seller_shop/screens/bottombar/total_profit.dart';

import '../../utils/app_constant.dart';
import '../../widgets/drawer_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    const TotalProduct(),
    const TotalOrders(),
    const TotalProfit(),
    const ChartScreen(),
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appPrimaryColor,
        title: Text(
          "Shop",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              // onTap: () => Get.to(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('assets/icon/product0.png',width: 30,height: 30,color: Colors.white,),
              label: '',
              activeIcon: Image.asset('assets/icon/package1.png',width: 30,height: 30,color: Colors.white,)),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icon/cart0.png',width: 30,height: 30,color: Colors.white,),
              label: '',
              activeIcon: Image.asset('assets/icon/cart1.png',width: 30,height: 30,color: Colors.white,)),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icon/profits0.png',width: 30,height: 30,color: Colors.white,),
              label: '',
              activeIcon: Image.asset('assets/icon/profits1.png',width: 30,height: 30,color: Colors.white,)),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icon/chart0.png',width: 30,height: 30,color: Colors.white,),
              label: '',
              activeIcon: Image.asset('assets/icon/chart1.png',width: 30,height: 30,color: Colors.white,)),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppConstant.appPrimaryColor,
        unselectedItemColor: AppConstant.appTextColor,
        selectedItemColor: AppConstant.appTextColor,
        iconSize: 28,
        selectedFontSize: 14,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedFontSize: 14,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
      ),
      body: tabs[selectedIndex],
    );
  }
}
