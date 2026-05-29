import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_ti4pb/core/api_client.dart';
import 'package:flutter_pos_ti4pb/data/models/table_resto_model.dart';

class TableRestoRepository extends ApiClient {
  Future<List<TableRestoModel>> getTableRestos() async {
    try {
      var response = await dio.get('table-restos');
      debugPrint('GET ALL Table Resto : ${response.data}');
      List list = response.data;
      List<TableRestoModel> listTableResto = list
          .map((elemet) => TableRestoModel.fromJson((elemet)))
          .toList();
      return listTableResto;
    } on DioException catch (e) {
      debugPrint('Error : ${e.toString()}');
      throw Exception(e);
    }
  }
}
