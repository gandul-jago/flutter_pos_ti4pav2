import 'package:bloc/bloc.dart';
import 'package:flutter_pos_ti4pav2/data/repo/table_resto_repository.dart';
import 'package:flutter_pos_ti4pav2/param/table_resto_param.dart';
import 'package:flutter_pos_ti4pav2/response/table_resto_response.dart';
import 'package:meta/meta.dart';

part 'create_table_resto_event.dart';

part 'create_table_resto_state.dart';

class CreateTableRestoBloc
    extends Bloc<CreateTableRestoEvent, CreateTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  CreateTableRestoBloc() : super(CreateTableRestoInitial()) {
    on<TableRestoCreated>((event, emit) {
      try {
        final param = TableRestoParam(
            event.tableRestoParam.code, event.tableRestoParam.name,
            event.tableRestoParam.capacity );
        TableRestoResponse response = await tableRestoRepository.addTableResto(
            param);
        emit (CreateTableRestoSuccess(tableRestoResponse: response));
      } catch (e) {
        emit(CreateTableRestoError(message: e.toString()));
      }
    });
  }
}
