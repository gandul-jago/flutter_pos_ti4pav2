import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_ti4pav2/core/api_client.dart';
import 'package:flutter_pos_ti4pav2/data/models/table_resto_model.dart';
import 'package:flutter_pos_ti4pav2/param/table_resto_param.dart';
import 'package:flutter_pos_ti4pav2/response/table_resto_response.dart';

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
      var response = await dio.post('table-restos', data : tableRestoParam.toJson());
      debugPrint('POST Table Resto : ${response.data}');
      return TableRestoResponse.fromJson(response.data);
    }on DioException catch(e){
      throw Exception(e);
    }
  }
}
