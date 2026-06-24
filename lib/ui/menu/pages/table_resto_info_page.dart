// import 'package:flutter/material.dart';
// import 'package:pmp12project/data/models/table_resto_model.dart';
//
// class TableRestoInfoPage extends StatelessWidget {
//   final TableRestoModel tableRestoModel;
//
//   const TableRestoInfoPage({super.key, required this.tableRestoModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Info Table Resto')),
//       body: Center(child: Text('${tableRestoModel.name}')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Jangan lupa import flutter_bloc
import 'package:pmp12project/data/models/table_resto_model.dart';
import 'package:pmp12project/param/table_resto_param.dart'; // Sesuaikan path TableRestoParam kamu
import 'package:pmp12project/ui/menu/bloc/update_table_resto/update_table_resto_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/update_table_resto/update_table_resto_bloc.dart'; // Sesuaikan path BLoC kamu

class TableRestoInfoPage extends StatefulWidget {
  final TableRestoModel tableRestoModel;

  const TableRestoInfoPage({super.key, required this.tableRestoModel});

  @override
  State<TableRestoInfoPage> createState() => _TableRestoInfoPageState();
}

class _TableRestoInfoPageState extends State<TableRestoInfoPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _codeController;
  late TextEditingController _nameController;
  late TextEditingController _capacityController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.tableRestoModel.code);
    _nameController = TextEditingController(text: widget.tableRestoModel.name);
    _capacityController = TextEditingController(text: widget.tableRestoModel.capacity?.toString() ?? '0');
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  // Fungsi untuk memicu Event BLoC
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // 1. Bungkus data inputan ke dalam TableRestoParam
      final param = TableRestoParam(
        _codeController.text,
        _nameController.text,
        int.parse(_capacityController.text),
      );

      // 2. Tambahkan event ke UpdateTableRestoBloc
      context.read<UpdateTableRestoBloc>().add(
        TableRestoUpdated(
          id: widget.tableRestoModel.id ?? 0, // Pastikan ID ada, berikan default 0 jika null
          tableRestoParam: param,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTableRestoBloc, UpdateTableRestoState>(
      listener: (context, state) {
        // Jika sedang loading, kita bisa tampilkan dialog loading gantung
        if (state is UpdateTableRestoLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        // Jika sukses memperbarui data di Django
        if (state is UpdateTableRestoSuccess) {
          Navigator.pop(context); // Tutup dialog loading
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Meja berhasil diperbarui!')),
          );
          Navigator.pop(context); // Kembali ke halaman daftar meja
        }

        // Jika terjadi error dari API Django
        if (state is UpdateTableRestoError) {
          Navigator.pop(context); // Tutup dialog loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Table Resto'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _onSubmit,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor / Kode Meja',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Kode meja tidak boleh kosong';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Meja',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Nama meja tidak boleh kosong';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _capacityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kapasitas (Orang)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Kapasitas tidak boleh kosong';
                    if (int.tryParse(value) == null) return 'Harus berupa angka';
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: _onSubmit,
                  child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}