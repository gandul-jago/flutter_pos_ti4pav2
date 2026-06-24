import 'package:flutter/material.dart';
import 'package:pmp12project/data/models/menu_resto_models.dart';

class MenuRestoDetailPage extends StatefulWidget {
  final MenuRestoModel menu;

  const MenuRestoDetailPage({super.key, required this.menu});

  @override
  State<MenuRestoDetailPage> createState() => _MenuRestoDetailPageState();
}

class _MenuRestoDetailPageState extends State<MenuRestoDetailPage> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(widget.menu.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(widget.menu.imageMenu, height: 200)),

            const SizedBox(height: 20),

            Text(
              widget.menu.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text('Kode : ${widget.menu.code}'),

            Text('Kategori : ${widget.menu.category}'),

            Text('Status : ${widget.menu.menuStatus}'),

            const SizedBox(height: 10),

            Text(
              'Rp ${widget.menu.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (qty > 1) {
                      setState(() {
                        qty--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),

                Text(
                  '$qty',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      qty++;
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'Deskripsi Penjual',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.menu.description ?? '-',
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$qty ${widget.menu.name} berhasil dibeli',
                      ),
                    ),
                  );
                },
                child: const Text('BELI'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
