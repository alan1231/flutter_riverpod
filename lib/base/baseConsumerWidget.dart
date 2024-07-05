import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseConsumerWidget extends ConsumerWidget {
  final bool showAppBar;
  final String title;

  BaseConsumerWidget({Key? key, this.showAppBar = false, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(title)) : null,
      body: buildContent(context, ref),
    );
  }

  Widget buildContent(BuildContext context, WidgetRef ref);
}
