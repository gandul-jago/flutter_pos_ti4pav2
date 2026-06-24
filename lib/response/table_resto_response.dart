import 'package:pmp12project/response/table_resto_data_response.dart';

class TableRestoResponse {
  final String message;
  final TableRestoDataResponse? tableRestoDataResponse;

  TableRestoResponse({
    required this.message,
    required this.tableRestoDataResponse,
  });

  factory TableRestoResponse.fromJson(Map<String, dynamic> json) {
    TableRestoDataResponse? tableRestoDataResponse;
    return TableRestoResponse(
      message: json['message'],
      tableRestoDataResponse: json['data'] != null
          ? TableRestoDataResponse.fromJson(json['data'])
          : tableRestoDataResponse,
    );
  }
}
