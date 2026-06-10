import 'package:flutter/material.dart';

class TableRestoParam {

  final String? code;
  final String? name;
  final int? capacity;

  TableRestoParam({required this.code, required this.name, required this.capacity});

  factory TableRestoParam.fromJson (Map<String, dynamic> json){
    return TableRestoParam(code: json['code'], name: json['name'], capacity: json['capacity']);
  }

  Map<String,dynamic> toJson() {
    return {'code' : code, 'name' : name, 'capacity' : capacity};
  }
}