class MenuRestoModel {
  final int? id;
  final String code;
  final String name;
  final double price;
  final String description;
  final String imageMenu;
  final String category;
  final String menuStatus;
  final String status;

  MenuRestoModel({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
    required this.description,
    required this.imageMenu,
    required this.category,
    required this.menuStatus,
    required this.status,
  });

  factory MenuRestoModel.fromJson(Map<String, dynamic> json) {
    return MenuRestoModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      price: json['price']?.toDouble(),
      description: json['description'],
      imageMenu: json['image_menu'],
      category: json['category'],
      menuStatus: json['menu_status'],
      status: json['status'],
    );
  }
}