class TableRestoDataResponse {
  final int? id;
  final String? code;
  final String? name;
  final int? capacity;
  final String tablestatus;
  final String? status;


  TableRestoDataResponse(
      {required this.id, required this.code, required this.name, required this.capacity, required this.tablestatus, required this.status});


  factory TableRestoDataResponse.fromJson (Map<String, dynamic> json){
    return TableRestoDataResponse(id: json['id'],
        code: json['code'],
        name: json['name'],
        capacity: json['capacity'],
        tablestatus: json['tablestatus'],
        status: json['status']);
  }

}