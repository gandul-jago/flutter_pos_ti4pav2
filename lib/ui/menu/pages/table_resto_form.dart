import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp12project/ui/menu/bloc/create_table_resto/create_table_resto_bloc.dart';
import '../../../param/table_resto_param.dart';
import 'package:pmp12project/data/repo/table_resto_repository.dart';
import 'package:pmp12project/data/models/table_resto_model.dart';
import 'package:pmp12project/ui/menu/bloc/update_table_resto/update_table_resto_bloc.dart';

class PostTableResto extends StatelessWidget {
  const PostTableResto({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CreateTableRestoBloc(),
        ),
        BlocProvider(
          create: (_) => UpdateTableRestoBloc(),
        ),
      ],
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
  bool isEditMode = false;

  TableRestoModel? selectedTable;

  final tableRepository = TableRestoRepository();
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

            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Berhasil'),
                  content: const Text(
                    'Data meja berhasil disimpan.',
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );

            tecCode.clear();
            tecName.clear();
            tecCapacity.clear();
          } else if (state is CreateTableRestoError) {

            if (state.message.contains('400')) {

              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Meja Sudah Ada'),
                    content: Text(
                      'Meja dengan kode "${tecCode.text}" sudah terdaftar.\n\nApakah Anda ingin mengedit meja ini?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Kembali'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(dialogContext);

                          final table =
                          await tableRepository.getTableByCode(
                            tecCode.text,
                          );

                          if (table != null) {
                            setState(() {
                              selectedTable = table;
                              isEditMode = true;

                              tecName.text = table.name ?? '';
                              tecCapacity.text =
                                  table.capacity?.toString() ?? '';
                            });
                          }
                        },
                        child: const Text('Edit Meja'),
                      ),
                    ],
                  );
                },
              );

            } else {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );

            }
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
                    if (isEditMode)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Mengedit data meja ${tecCode.text}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
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
                          backgroundColor: isEditMode
                              ? Colors.green
                              : Theme.of(context).colorScheme.inversePrimary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {

                            final tableRestoParam = TableRestoParam(
                              tecCode.text,
                              tecName.text,
                              int.tryParse(
                                tecCapacity.text,
                              ) ??
                                  0,
                            );

                            if (isEditMode) {

                              context.read<UpdateTableRestoBloc>().add(
                                TableRestoUpdated(
                                  id: selectedTable!.id!,
                                  tableRestoParam: tableRestoParam,
                                ),
                              );

                            } else {

                              context.read<CreateTableRestoBloc>().add(
                                TableRestoCreated(
                                  tableRestoParam: tableRestoParam,
                                ),
                              );

                            }
                          }
                        },
                        child: Text(
                          isEditMode ? 'UPDATE' : 'SIMPAN',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
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
