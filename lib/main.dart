import 'package:flutter/material.dart';
import 'package:flutter_demo/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() {
  final appRouter = AppRouter();
  runApp(
    ProviderScope(
      child: MyApp(appRouter: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  MyApp({required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true, // 自动缩放字体
      splitScreenMode: true, // 适配平板、分屏
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: appRouter.getRouter().routerDelegate,
        routeInformationParser: appRouter.getRouter().routeInformationParser,
        routeInformationProvider:
            appRouter.getRouter().routeInformationProvider,
        builder: (context, child) {
          return FlutterSmartDialog.init(
            builder: (context, child) {
              return SafeArea(child: child!);
            },
          )(context, child);
        },
      ),
    );
  }
}
