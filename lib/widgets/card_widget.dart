
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key,this.name,this.subName,this.amount,this.disc});
  final String? name;
  final String? subName;
  final String? amount;
  final String? disc;


  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {


  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 10,
                spreadRadius: 6,
                offset: Offset(0, 10))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 6),
          SizedBox(height: 3),
          Text(widget.name!,style: TextStyle(color: Colors.black),),
          Text(widget.subName!,style: TextStyle(color: Colors.black),),
          Text(widget.amount!,style: TextStyle(color: Colors.black),),
          Text(widget.disc!,style: TextStyle(color: Colors.black),),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
