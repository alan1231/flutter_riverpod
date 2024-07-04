import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/api/FlavorsNotifier.dart';
import 'package:flutter_demo/screens/view/todolist/todolist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class DialogManager {
  static void showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();

    SmartDialog.show(
      alignment: Alignment.center,
      builder: (_) => AlertDialog(
        title: const Text('Add To-Do'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter a task'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SmartDialog.dismiss();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).add(_controller.text);
              SmartDialog.dismiss();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  static void showCreateFlavorDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    SmartDialog.show(
      alignment: Alignment.center,
      builder: (_) => AlertDialog(
        title: const Text('Create Flavor'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter flavor name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Enter description'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(hintText: 'Enter price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              SmartDialog.dismiss();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final notifier = ref.read(flavorsProvider.notifier);
              bool success = await notifier.createFlavor(
                name: nameController.text,
                description: descriptionController.text,
                price: double.parse(priceController.text),
              );
              SmartDialog.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Flavor created successfully!' : 'Failed to create flavor.')),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  static void showDeleteFlavorDialog(BuildContext context, WidgetRef ref, String flavorId) {
    SmartDialog.show(
      alignment: Alignment.center,
      builder: (_) => AlertDialog(
        title: Text('Delete Flavor with id $flavorId'),
        content: const Text('Are you sure you want to delete this flavor?'),
        actions: [
          TextButton(
            onPressed: () => SmartDialog.dismiss(), // 取消操作，关闭对话框
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final notifier = ref.read(flavorsProvider.notifier);
              final success = await notifier.deleteFlavor(flavorId);
              SmartDialog.dismiss(); // 关闭对话框
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Flavor deleted successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete flavor')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  static void showConsumer({
    required Widget Function(BuildContext context, WidgetRef ref) builder,
    bool backDismiss = true,
    bool clickMaskDismiss = true,
    double blurX = 10.0,
    double blurY = 10.0,
    Color maskColor = Colors.transparent,
  }) {
    SmartDialog.show(
      maskColor: Colors.transparent,
      useAnimation: false,
      backDismiss: backDismiss,
      clickMaskDismiss: clickMaskDismiss,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (clickMaskDismiss) {
              SmartDialog.dismiss();
            }
          },
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
                child: Container(
                  color: maskColor,
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Consumer(builder: (context, ref, child) {
                    return builder(context, ref);
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}