import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pmp12project/ui/home/home_page.dart';
import 'package:pmp12project/ui/menu/bloc/checkout/checkout_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/get_menu_resto/get_menu_restos_bloc.dart';

// Bloc
import 'package:pmp12project/ui/menu/bloc/get_table_restoes/get_table_restoes_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/create_table_resto/create_table_resto_bloc.dart';
// import 'package:pmp12project/ui/menu/bloc/get_menu_restoes/get_menu_restoes_bloc.dart';
// import 'package:pmp12project/ui/checkout/bloc/checkout_bloc.dart';
// import 'package:pmp12project/ui/auth/bloc/login_bloc.dart';
// import 'package:pmp12project/ui/auth/bloc/logout_bloc.dart';
// import 'package:pmp12project/bloc/app_setting_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        // CreateTableRestoBlocBlocProvider(
        //   create: (context) =>
        //   AppSettingBloc()..add(CheckSession()),
        // ),
        // BlocProvider(
        //   create: (context) => LoginBloc(),
        // ),
        // BlocProvider(
        //   create: (context) => LogoutBloc(),
        // ),
        BlocProvider(
          create: (context) => GetMenuRestosBloc(),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4382DF),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}