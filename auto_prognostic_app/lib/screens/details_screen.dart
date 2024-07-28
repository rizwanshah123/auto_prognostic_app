import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final Widget widget;

  const DetailsScreen({required this.title, required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            )),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(
            bottom: 20.h,
          ),
          child: widget),
    );
  }
}
