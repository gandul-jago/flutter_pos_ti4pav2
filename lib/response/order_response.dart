class OrderResponse {
  final int? id;
  final String? code;
  final int? tableResto;
  final int? user;
  final String? orderStatus;
  final double? totalOrder;
  final double? taxOrder;
  final double? totalPayment;
  final int? userCreate;

  OrderResponse({
    required this.id,
    required this.code,
    required this.tableResto,
    required this.user,
    required this.orderStatus,
    required this.totalOrder,
    required this.taxOrder,
    required this.totalPayment,
    required this.userCreate,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'],
      code: json['code'],
      tableResto: json['table_resto'],
      user: json['user'],
      orderStatus: json['order_status'],
      totalOrder: json['total_order'],
      taxOrder: json['tax_order'],
      totalPayment: json['total_payment'],
      userCreate: json['user_create'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'table_resto': tableResto,
      'user': user,
      'order_status': orderStatus,
      'total_order': totalOrder,
      'tax_order': taxOrder,
      'total_payment': totalPayment,
      'user_create': userCreate,
    };
  }
}