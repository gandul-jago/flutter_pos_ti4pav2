import 'package:flutter/foundation.dart';

class TableRestoParam {
  final String? code;
  final String? name;
  final int? capacity;

  TableRestoParam(this.code, this.name, this.capacity);

  //json to dart model
  factory TableRestoParam.formJson(Map<String, dynamic> json) {
    return TableRestoParam(json['code'], json['name'], json['capacity']);
  }

  // dart model to json
  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'capacity': capacity};
  }
}
