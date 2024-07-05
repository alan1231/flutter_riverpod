import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/todo');
          },
          child: Text('Go to Main Screen'),
        ),
      ),
    );
  }
}
