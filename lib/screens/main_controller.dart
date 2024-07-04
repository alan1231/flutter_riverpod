import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'view/foot/foot_screen.dart';

class MainController extends ConsumerStatefulWidget {
  @override
  _MainControllerState createState() => _MainControllerState();
}

class _MainControllerState extends ConsumerState<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 150.h,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text('Header'),
                        background: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: EdgeInsets.only(bottom: 50.h), // 留出底部空间
                          child: MainScreen(),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FootScreen(),
          ),
        ],
      ),
    );
  }
}
