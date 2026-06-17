import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/create_table_resto/create_table_resto_bloc.dart';
import '../../../param/table_resto_param.dart';

class PostTableResto extends StatelessWidget {
  const PostTableResto({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTableRestoBloc(),
      child: const TableRestoForm(),
    );
  }
}

class TableRestoForm extends StatefulWidget {
  const TableRestoForm({super.key});

  @override
  State<TableRestoForm> createState() => _TableRestoFormState();
}

class _TableRestoFormState extends State<TableRestoForm> {
  final tecCode = TextEditingController();
  final tecName = TextEditingController();
  final tecCapacity = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    tecCode.dispose();
    tecName.dispose();
    tecCapacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Resto Form')),
      body: BlocConsumer<CreateTableRestoBloc, CreateTableRestoState>(
        listener: (context, state) {
          if (state is CreateTableRestoSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data berhasil disimpan...')),
            );
            tecCode.clear();
            tecName.clear();
            tecCapacity.clear();
          } else if (state is CreateTableRestoError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is CreateTableRestoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: tecCode,
                      keyboardType: TextInputType.name,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Kode meja masih kosong'
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Kode Meja',
                        hintText: 'Masukkan kode meja',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: tecName,
                      keyboardType: TextInputType.name,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama meja masih kosong'
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Nama Meja',
                        hintText: 'Masukkan nama meja',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: tecCapacity,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Kapasitas meja masih kosong'
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Kapasitas Meja',
                        hintText: 'Masukkan kapasitas meja',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.inversePrimary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final tableRestoParam = TableRestoParam(
                              tecCode.text,
                              tecName.text,
                              int.tryParse(tecCapacity.text) ?? 0,
                            );
                            context.read<CreateTableRestoBloc>().add(
                              TableRestoCreated(
                                tableRestoParam: tableRestoParam,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'SIMPAN',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
