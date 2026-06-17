import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmp12project/data/repo/table_resto_repository.dart';
import 'package:pmp12project/param/table_resto_param.dart';
import 'package:pmp12project/response/table_resto_response.dart';

part 'create_table_resto_event.dart';

part 'create_table_resto_state.dart';

class CreateTableRestoBloc
    extends Bloc<CreateTableRestoEvent, CreateTableRestoState> {
  final TableRestoRepository tableRestoRepository = TableRestoRepository();

  CreateTableRestoBloc() : super(CreateTableRestoInitial()) {
    // Mendaftarkan masing-masing event ke handler-nya sendiri
    on<TableRestoCreated>(_onTableRestoCreated);
    on<TableRestoUpdated>(_onTableRestoUpdated);
  }

  // Handler untuk Menambah Meja Resto Baru
  FutureOr<void> _onTableRestoCreated(
    TableRestoCreated event,
    Emitter<CreateTableRestoState> emit,
  ) async {
    emit(CreateTableRestoLoading());
    try {
      final param = TableRestoParam(
        event.tableRestoParam.code,
        event.tableRestoParam.name,
        event.tableRestoParam.capacity,
      );

      TableRestoResponse response = await tableRestoRepository.addTableResto(
        param,
      );
      emit(CreateTableRestoSuccess(tableRestoResponse: response));
    } catch (e) {
      // Mengirim state error jika proses gagal (misal: RTO atau server error)
      emit(CreateTableRestoError(message: e.toString()));
    }
  }

  // Handler untuk Mengupdate/Mengedit Meja Resto
  FutureOr<void> _onTableRestoUpdated(
    TableRestoUpdated event,
    Emitter<CreateTableRestoState> emit,
  ) async {
    emit(CreateTableRestoLoading());
    try {
      final param = TableRestoParam(
        event.tableRestoParam.code,
        event.tableRestoParam.name,
        event.tableRestoParam.capacity,
      );

      // Asumsi di repository kamu ada method updateTableResto
      // Seringkali update butuh ID meja, sesuaikan dengan struktur data milikmu
      TableRestoResponse response = await tableRestoRepository.updateTableResto(
        event.id,
        param,
      );

      emit(CreateTableRestoSuccess(tableRestoResponse: response));
    } catch (e) {
      emit(CreateTableRestoError(message: e.toString()));
    }
  }
}
