class OrderMenuParam {
  final int? menuResto;
  final int? quantity;

  OrderMenuParam({
    required this.menuResto,
    required this.quantity,
  });

  factory OrderMenuParam.fromJson(Map<String, dynamic> json) {
    return OrderMenuParam(
      menuResto: json['menu_resto'] ?? json['menuResto'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_resto': menuResto,
      'quantity': quantity,

    };
  }
}