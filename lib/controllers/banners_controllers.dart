
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersControllers  extends GetxController{

  RxList<String> bannerUrls = RxList<String>([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBannersUrls();
  }

  // fetch banners from databese
  Future<void> fetchBannersUrls() async {
    try{
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('banners').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String imageUrl = data['imageUrl'];
              // You can use the imageUrl to display the image
              return ListTile(
                title: Image.network(imageUrl),
              );
            }).toList(),
          );
        },
      );
    }catch (e) {
    print('Error : $e');
    }
  }
}