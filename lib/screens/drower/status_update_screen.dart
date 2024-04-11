import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/app_constant.dart';

class StatusUpdateScreen extends StatefulWidget {
  const StatusUpdateScreen({super.key});

  @override
  State<StatusUpdateScreen> createState() => _StatusUpdateScreenState();
}



class _StatusUpdateScreenState extends State<StatusUpdateScreen> {
  late Future<List<DocumentSnapshot>> _ordersFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ordersFuture = getAllOrders();
  }

  // Function to retrieve all data from the "orders" collection
  Future<List<DocumentSnapshot>> getAllOrders() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('orders').get();

    print("all order document ======${querySnapshot.docs}");
    return querySnapshot.docs;
  }

// Function to update the status of a document in the "orders" collection
  Future<void> updateOrderStatus(String orderId, bool newStatus) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': newStatus});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(
            color: AppConstant.appTextColor
        ) ,
        backgroundColor: AppConstant.appPrimaryColor,
        title: const Text('UpDate Status ',style: TextStyle(color: AppConstant.appTextColor),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _ordersFuture,
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }else{
            List<DocumentSnapshot>? orders = snapshot.data;
            if(orders != null && orders.isNotEmpty){
              return ListView.builder(
                itemCount: orders.length,
                  itemBuilder: (context,index) {
                    DocumentSnapshot order = orders[index];
                    bool currentStatus = false;
                    if (order.exists && order.data() != null) {
                      final data = order.data()! as Map<String, dynamic>;
                      if (data.containsKey('status')) {
                        currentStatus = data['status'] as bool;
                      } else {
                        print('Status key not found in order data.');
                      }
                    } else {
                      print('Invalid order object or order data is null or order does not exist.');
                    }

                    return Padding(
                      padding:  EdgeInsets.only(top: 8,left: 08,right: 08),
                      child: Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 5,
                        color: AppConstant.appTextColor,
                        child: ListTile(
                          title:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Id:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18)),
                              Text(order.id,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                            ],
                          ),
                          subtitle: Text(currentStatus ? 'Order Status: Delivered' : 'Order Status: Pending..',style: TextStyle(fontWeight: FontWeight.w500)),
                          trailing: IconButton(
                            icon: const Icon(Icons.update),
                            onPressed: () async {
                              await updateOrderStatus(order.id, !currentStatus);
                              setState(() {
                                // Update UI with the new status
                                _ordersFuture = getAllOrders(); // Refresh order list
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  });
            }
            else {
              return Center(child: Text('No orders found.'));
            }
          }
        },
      ),
    );
  }
}
