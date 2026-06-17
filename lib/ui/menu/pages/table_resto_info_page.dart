import 'package:flutter/material.dart';
import 'package:pmp12project/data/models/table_resto_model.dart';

class TableRestoInfoPage extends StatelessWidget {
  final TableRestoModel tableRestoModel;

  const TableRestoInfoPage({super.key, required this.tableRestoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Info Table Resto')),
      body: Center(child: Text('${tableRestoModel.name}')),
    );
  }
}
