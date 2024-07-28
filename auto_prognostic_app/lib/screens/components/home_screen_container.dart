import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreenContainer extends StatelessWidget {
  String img;
  String name;
  HomeScreenContainer(this.img, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 19.h,
      width: 40.w,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(38, 66, 11, 1), //New
            blurRadius: 2.0,
          )
        ],
        borderRadius: BorderRadius.circular(9),
        color: Colors.white.withOpacity(.7),
      ),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Image.asset(
            img,
            height: 10.h,
          ),
          const Divider(),
          SizedBox(
            height: 1.h,
          ),
          Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
