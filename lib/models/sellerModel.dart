import 'dart:async';

import 'package:seller_shop/models/sellerModel.dart';

class SellerModel {
 final String sId;
 final String name;
 final String phone;
 final String city;
 final String email;
 final String password;
 // final String sellerDeviceToken;
 final bool isAdmin;
 final bool isActive;
 final dynamic createdOn;

  SellerModel(
      {
        // required this.sellerDeviceToken,
        required this.sId,
        required this.name,
      required this.phone,
      required this.city,
      required this.email,
      required this.password,
      required this.isAdmin,
        required this.isActive,
      required this.createdOn});

  Map<String, dynamic> toMap() {
  return {
    'sId' :sId ,
    'name' : name,
    'phone' : phone,
    'city' : city,
    'email' : email,
    "password" : password,
    'isAdmin' : isAdmin,
    'isActive' : isActive,
    'createdOn' : createdOn,
    // 'sellerDeviceToken' : sellerDeviceToken
  };
  }

  factory SellerModel.fromMap(Map<String,dynamic> json) {
    return SellerModel(
      // sellerDeviceToken:json['sellerDeviceToken'] ,
        sId:json['sId'],
        name: json['name'],
        phone: json['phone'],
        city: json['city'],
        email: json['email'],
        password: json['password'],
        isAdmin: json['isAdmin'],
        isActive: json['isActive'],
        createdOn: json['createdOn']);
  }
}
