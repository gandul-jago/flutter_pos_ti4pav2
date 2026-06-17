import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pmp12project/core/api_client.dart';
import 'package:pmp12project/data/models/menu_resto_models.dart';


class MenuRestoRepository extends ApiClient {

  Future<List<MenuRestoModel>> getMenuRestos() async {
    try {
      var response = await dio.get('menu-restos');

      debugPrint('GET ALL MENU : ${response.data}');

      List list = response.data;

      List<MenuRestoModel> listMenu = list
          .map((e) => MenuRestoModel.fromJson(e))
          .toList();

      return listMenu;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}