import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/view/flavors/flavors_list_screen.dart';
import 'package:flutter_demo/tools/smart_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h, // 使用 ScreenUtil 设置高度
      child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: Image.asset(
              'assets/images/foot/foot_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 按钮和文字
          Positioned(
            left: 0,
            right: 0,
            bottom: 10.h, // 偏移位置
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton(context, Icons.apps, '其他', () {
                  print('其他按钮被点击');
                }),
                _buildButton(context, Icons.leaderboard, '排行榜', () {
                  print('排行榜按钮被点击');
                }),
                _buildButton(context, Icons.shopping_bag, '商城', () {
                  print('商城按钮被点击');
                }),
                _buildButton(context, Icons.card_giftcard, '赠禮', () {
                  print('赠礼按钮被点击');
                }),
                _buildButton(context, Icons.group, '公會', () {
                  DialogManager.showConsumer(
                    builder: (context, ref) {
                      return const FlavorsListScreen();
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData iconData, String text,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 25.w,
            color: Colors.white,
          ),
          SizedBox(height: 1.h),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
