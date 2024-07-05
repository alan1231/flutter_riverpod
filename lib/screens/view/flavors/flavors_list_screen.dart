import 'package:flutter/material.dart';
import 'package:flutter_demo/api/ApiService.dart';
import 'package:flutter_demo/api/FlavorsNotifier.dart';
import 'package:flutter_demo/base/BaseConsumerWidget.dart';
import 'package:flutter_demo/model/flavors_model.dart';
import 'package:flutter_demo/tools/smart_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlavorsListScreen extends BaseConsumerWidget {
  FlavorsListScreen({Key? key, bool showAppBar = false})
      : super(key: key, showAppBar: showAppBar, title: 'Flavors List');

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    final flavorsResponseAsync = ref.watch(flavorsProvider);

    return Container(
        color: Colors.white,
        child: _buildFlavorsListView(context, ref, flavorsResponseAsync));
  }

  Widget _buildFlavorsListView(BuildContext context, WidgetRef ref,
      AsyncValue<FlavorsResponse?> flavorsResponseAsync) {
    return flavorsResponseAsync.when(
      data: (flavorsResponse) {
        if (flavorsResponse == null || flavorsResponse.flavors.isEmpty) {
          return const Center(child: Text('No flavors available'));
        } else {
          return ListView(
            children: _buildFlavorsList(context, ref, flavorsResponse),
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
