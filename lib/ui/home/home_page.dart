import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../menu/pages/dashboard_page.dart';
import '../menu/pages/menu_resto_page.dart';
import '../menu/pages/profile_page.dart';
import '../menu/pages/table_resto_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> list = [
    DashboardPage(),
    MenuRestoPage(),
    TableRestoPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 10,
        selectedIndex: currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onDestinationSelected: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.shop_add), label: 'Order'),
          NavigationDestination(icon: Icon(Iconsax.task), label: 'History'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
      body: list[currentIndex],
    );
  }
}