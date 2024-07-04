import 'package:flutter/material.dart';
import 'package:flutter_demo/api/ApiService.dart';
import 'package:flutter_demo/api/FlavorsNotifier.dart';
import 'package:flutter_demo/model/flavors_model.dart';
import 'package:flutter_demo/tools/app_colors.dart';
import 'package:flutter_demo/tools/smart_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlavorsListScreen extends ConsumerWidget {
  const FlavorsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorsResponseAsync = ref.watch(flavorsProvider);

    return _buildFlavorsListView(context, ref, flavorsResponseAsync);
  }

  Widget _buildFlavorsListView(BuildContext context, WidgetRef ref,
      AsyncValue<FlavorsResponse?> flavorsResponseAsync) {
    return flavorsResponseAsync.when(
      data: (flavorsResponse) {
        if (flavorsResponse == null || flavorsResponse.flavors.isEmpty) {
          return const Center(child: Text('No flavors available'));
        } else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0), // 圆角半径
                border: Border.all(color: AppColors.primary, width: 10.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // 阴影偏移量
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // 确保子组件也有圆角
                child: ListView(
                  children: _buildFlavorsList(context, ref, flavorsResponse),
                ),
              ),
            ),
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  List<Widget> _buildFlavorsList(
      BuildContext context, WidgetRef ref, FlavorsResponse flavorsResponse) {
    return flavorsResponse.flavors.map((flavor) {
      return ListTile(
        leading: flavor.image_path != null && flavor.image_path.isNotEmpty
            ? Image.network(
                '${ApiService.https}storage/${flavor.image_path}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : null,
        title: Text(flavor.name),
        subtitle: Text(flavor.description),
        trailing: Text(flavor.price.toString()),
        onTap: () => DialogManager.showDeleteFlavorDialog(
            context, ref, flavor.id.toString()), // 添加点击事件
      );
    }).toList();
  }
}
