// head.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h, // 使用 ScreenUtil 设置高度
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        'Header',
        style: TextStyle(color: Colors.white, fontSize: 24.sp),
      ),
    );
  }
}
