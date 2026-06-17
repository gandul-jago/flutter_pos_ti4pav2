import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp12project/ui/home/home_page.dart';
import 'package:pmp12project/ui/menu/bloc/create_table_resto/create_table_resto_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/get_table_restoes/get_table_restoes_bloc.dart';
import 'package:pmp12project/ui/menu/pages/table_resto_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetTableRestoesBloc(),
        ),
        BlocProvider(
          create: (context) => CreateTableRestoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0x4382DF),
          ),
        ),
        // home: BlocProvider(
        //   create: (context) => GetTableRestoesBloc(),
        //   child: TableRestoPage(),
        // ),
        home: HomePage(),
      ),
    );
  }
}


