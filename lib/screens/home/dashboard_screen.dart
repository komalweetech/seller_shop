import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seller_shop/screens/home/add_products.dart';
import 'package:seller_shop/utils/app_constant.dart';
import 'package:seller_shop/widgets/card_widget.dart';
import 'package:seller_shop/widgets/drawer_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
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
          "Home",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => Get.to(AddProducts()),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String imageUrl = data['imageUrl'] ?? '';
              String name = data['name'] ?? '';
              String subName = data['subNAme'] ?? '';
              String amount = data['amount'] ?? '';
              String description = data['description'] ?? '';
              return Padding(
                padding:  const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20.0),
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
                child:ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                       onTap: () {},
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: SizedBox(
                                height: Get.height /3,
                                width: Get.width,
                                child: Image.network(imageUrl,fit: BoxFit.cover,),
                              ) ,
                            ),
                            const Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: CardWidget(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
            separatorBuilder: (context, index) {
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
}
