import 'package:flutter_demo/api/ApiService.dart';
import 'package:flutter_demo/model/flavors_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlavorsNotifier extends StateNotifier<AsyncValue<FlavorsResponse?>> {
  final ApiService apiService;
  FlavorsNotifier(this.apiService) : super(const AsyncValue.loading()) {
    fetchFlavors();
  }

  // 定义异步方法 fetchFlavors，用于从 API 获取数据
  Future<void> fetchFlavors() async {
    try {
      final response = await apiService.fetchFlavors();
      state = AsyncValue.data(response);
    } catch (error) {
      state = AsyncValue.error(error);
    }
  }

  Future<bool> createFlavor({
    required String name,
    String? description,
    required double price,
  }) async {
    try {
      final newFlavor = {
        "name": name,
        "description": description,
        "price": price,
      };

      await apiService.createFlavor(newFlavor);
      await fetchFlavors();
      return true;
    } catch (error) {
      state = AsyncValue.error(error);
      return false;
    }
  }

    Future<bool> deleteFlavor(String id) async {
    try {
      await apiService.deleteFlavor(id);
      await fetchFlavors();
      return true;
    } catch (error) {
      state = AsyncValue.error(error);
      return false;
    }
  }
}

// 定义 flavorsProvider，使用 StateNotifierProvider 包装 FlavorsNotifier
final flavorsProvider =
    StateNotifierProvider<FlavorsNotifier, AsyncValue<FlavorsResponse?>>((ref) {
  return FlavorsNotifier(ref.read(apiServiceProvider)); // 提供 FlavorsNotifier 实例
});

// 定义 apiServiceProvider，使用 Provider 提供 ApiService 实例
final apiServiceProvider = Provider((ref) => ApiService());
