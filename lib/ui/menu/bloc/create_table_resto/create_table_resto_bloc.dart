import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmp12project/data/repo/table_resto_repository.dart';
import 'package:pmp12project/param/table_resto_param.dart';
import 'package:pmp12project/response/table_resto_response.dart';

part 'create_table_resto_event.dart';

part 'create_table_resto_state.dart';

class CreateTableRestoBloc
    extends Bloc<CreateTableRestoEvent, CreateTableRestoState> {
  final tableRestoRepository = TableRestoRepository();

  CreateTableRestoBloc() : super(CreateTableRestoInitial()) {
    on<TableRestoCreated>((event, emit) async {
      emit(CreateTableRestoLoading());
      try {
        final param = TableRestoParam(
            event.tableRestoParam.code, event.tableRestoParam.name,
            event.tableRestoParam.capacity);
        TableRestoResponse response = await tableRestoRepository.addTableResto(
            param);
        emit(CreateTableRestoSuccess(tableRestoResponse: response));
      } catch (e) {
        emit(CreateTableRestoError(message: e.toString()));
      }
    });
  }
}
