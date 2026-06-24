import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pmp12project/core/api_client.dart';
import 'package:pmp12project/data/models/table_resto_model.dart';
import 'package:pmp12project/param/table_resto_param.dart';
import 'package:pmp12project/response/table_resto_response.dart';

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
  Future<TableRestoResponse> addTableResto(TableRestoParam tableRestoParam)async{
    try{
      var response = await dio.post('table-restos', data: tableRestoParam.toJson());
      debugPrint('POST Table Resto : ${response.data}');
      return TableRestoResponse.fromJson(response.data);
    }on DioException catch(e){
      throw Exception(e);
    }
  }
  Future<TableRestoResponse> updateTableResto(

      int id,
      TableRestoParam tableRestoParam,
      ) async {

    try {

      var response = await dio.put(
        'table-resto-detail/$id',
        data: tableRestoParam.toJson(),
      );

      debugPrint('UPDATE Table Resto : ${response.data}');

      return TableRestoResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
  Future<void> deleteTableResto(int id) async {
    try {

      await dio.delete(
        'table-resto-detail/$id',
      );

    } on DioException catch (e) {
      throw Exception(e);
    }
  }
  Future<TableRestoModel?> getTableByCode(String code) async {
    try {
      final response = await dio.get('table-restos');

      List data = response.data;

      for (var item in data) {
        if (item['code'] == code) {
          return TableRestoModel.fromJson(item);
        }
      }

      return null;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
