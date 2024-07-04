import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/view/flavors/flavors_list_screen.dart';
import 'package:flutter_demo/screens/view/todolist/todo_list_screen.dart';
import 'package:flutter_demo/tools/smart_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabbarScreen extends ConsumerStatefulWidget {
  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends ConsumerState<TabbarScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _refreshFlavors() async {
    DialogManager.showCreateFlavorDialog(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['To-Do List', 'Flavors'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[_selectedIndex]),
          actions: _selectedIndex == 1
              ? [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _refreshFlavors,
                  ),
                ]
              : null,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            TodoListScreen(),
            const FlavorsListScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
            automaticIndicatorColorAdjustment: true,
            onTap: _onTabTapped,
            tabs: const [
              Tab(text: 'Todos'),
              Tab(text: 'Flavors'),
            ],
            indicatorColor: Colors.transparent,
          ),
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () =>
                    DialogManager.showAddTodoDialog(context, ref), // 使用封装的对话框函数
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
