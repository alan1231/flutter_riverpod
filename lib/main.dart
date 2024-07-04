import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/main_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true, // 自动缩放字体
        splitScreenMode: true, // 适配平板、分屏
        builder: (_, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: FlutterSmartDialog.init(builder: (context, child) {
                return child!;
              }),
              home: SafeArea(
                child: MainController(),
              ),
            ));
  }
}
