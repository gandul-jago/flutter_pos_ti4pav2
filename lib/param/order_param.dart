import 'order_menu_param.dart';

class OrderParam {
  final int tableResto;
  final int user;
  final int userCreate;
  final List<OrderMenuParam> listOrderMenuParam;

  OrderParam({
    required this.tableResto,
    required this.user,
    required this.userCreate,
    required this.listOrderMenuParam,
  });

  factory OrderParam.fromJson(Map<String, dynamic> json) {
    return OrderParam(
        tableResto: json['table_resto'],
        user: json['user'],
        userCreate: json['user_create'],
        listOrderMenuParam: List<OrderMenuParam>.from(
            json['order_order_detail'].map(
                    (element) => OrderMenuParam.fromJson(element)
            )
        )
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_resto': tableResto,
      'user': user,
      'user_create': userCreate,
      'order_order_detail': List<dynamic>.from(
        listOrderMenuParam.map((element) => element.toJson()).toList(),
      )
    };
  }
}