// models/flavor_model.dart
class Flavor {
  int id;
  String name;
  String description;
  String price;
  String image_path;
  Flavor({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image_path,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) {
    return Flavor(
      id: json['id'] ?? 0, // 提供一个默认值 0，防止 id 为 null
      name: json['name'],
      description: json['description'] ?? '',
      price: json['price'],
      image_path: json['image_path'],
    );
  }

  // 添加 toJson 方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_path': image_path,
    };
  }
}

class FlavorsResponse {
  List<Flavor> flavors;

  FlavorsResponse({required this.flavors});

  factory FlavorsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['flavors'] as List;
    List<Flavor> flavorList = list.map((i) => Flavor.fromJson(i)).toList();

    return FlavorsResponse(flavors: flavorList);
  }
}