import 'package:pmp12project/data/models/menu_resto_models.dart';
import 'package:pmp12project/param/order_menu_param.dart';

class OrderMenuModel {
  MenuRestoModel menuRestoModel;
  int quantity;

  OrderMenuModel({required this.menuRestoModel, required this.quantity});

  OrderMenuParam toOrderMenuModel(){
    return OrderMenuParam(menuResto: menuRestoModel.id, quantity: quantity);
  }
}