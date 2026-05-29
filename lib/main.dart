import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_ti4pb/ui/home/home_page.dart';
import 'package:flutter_pos_ti4pb/ui/menu/bloc/get_table_restoes/get_table_restoes_bloc.dart';
import 'package:flutter_pos_ti4pb/ui/menu/pages/table_resto_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: BlocProvider(
      //   create: (context) => GetTableRestoesBloc(),
      //   child: TableRestoPage(),
      // ),
      home: HomePage(),
    );
  }
}


