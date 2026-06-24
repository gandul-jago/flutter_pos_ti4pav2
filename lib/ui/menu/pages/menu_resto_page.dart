// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pmp12project/data/models/menu_resto_models.dart';
// import 'package:pmp12project/ui/menu/bloc/get_menu_resto/get_menu_restos_bloc.dart';
//
// import 'menu_resto_detail_page.dart';
//
// class MenuRestoPage extends StatelessWidget {
//   const MenuRestoPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => GetMenuRestosBloc()..add(MenuRestosFetched()),
//       child: const MenuRestoView(),
//     );
//   }
// }
//
// class MenuRestoView extends StatelessWidget {
//   const MenuRestoView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Menu Resto'),
//       ),
//       body: BlocBuilder<GetMenuRestosBloc, GetMenuRestosState>(
//         builder: (context, state) {
//           if (state is GetMenuRestosLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (state is GetMenuRestosError) {
//             return Center(
//               child: Text(state.message),
//             );
//           }
//
//           if (state is GetMenuRestosLoaded) {
//             return ListView.separated(
//               itemCount: state.list.length,
//               separatorBuilder: (_, __) => const Divider(),
//               itemBuilder: (context, index) {
//                 final menu = state.list[index];
//                 MenuRestoModel menuRestoModel = state.listMenuResto[index];
//                 return ListTile(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => MenuRestoDetailPage(
//                           menu: menu,
//                         ),
//                       ),
//                     );
//                   },
//
//                   leading: Image.network(
//                     menu.imageMenu,
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.cover,
//                   ),
//
//                   title: Text(menu.name),
//
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(menu.category),
//                       Text('Rp ${menu.price.toStringAsFixed(0)}'),
//                     ],
//                   ),
//
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                 );
//
//               },
//             );
//           }
//
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }

// dari AI jir, yang di atas punya g tau
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp12project/data/models/menu_resto_models.dart';
import 'package:pmp12project/ui/menu/bloc/get_menu_resto/get_menu_restos_bloc.dart';
import 'menu_resto_detail_page.dart';

class MenuRestoPage extends StatelessWidget {
  const MenuRestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetMenuRestosBloc()..add(MenuRestosFetched()),
      child: const MenuRestoView(),
    );
  }
}

class MenuRestoView extends StatelessWidget {
  const MenuRestoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Resto'),
      ),
      body: BlocBuilder<GetMenuRestosBloc, GetMenuRestosState>(
        builder: (context, state) {
          if (state is GetMenuRestosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetMenuRestosError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is GetMenuRestosLoaded) {
            return ListView.separated(
              itemCount: state.list.length, // Menggunakan state.list konsisten sampai bawah
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                //  PERBAIKAN 1: Cukup gunakan satu model yang konsisten dari state.list
                final MenuRestoModel menu = state.list[index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MenuRestoDetailPage(
                          menu: menu,
                        ),
                      ),
                    );
                  },
                  //  PERBAIKAN 2: Proteksi Image.network agar tidak crash jika link null/kosong
                  leading: menu.imageMenu != null && menu.imageMenu!.isNotEmpty
                      ? Image.network(
                    menu.imageMenu!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.fastfood, size: 40); // Icon pengganti jika link rusak
                    },
                  )
                      : const Icon(Icons.fastfood, size: 40), // Icon pengganti jika memang tidak ada gambar

                  title: Text(menu.name ?? 'Tanpa Nama'),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menu.category ?? '-'),
                      // Gunakan ?? 0 untuk mengantisipasi jika field price di model bernilai null
                      Text('Rp ${(menu.price ?? 0).toStringAsFixed(0)}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}