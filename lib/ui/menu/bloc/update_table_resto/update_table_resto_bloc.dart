import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmp12project/data/repo/table_resto_repository.dart';
import 'package:pmp12project/param/table_resto_param.dart';
import 'package:pmp12project/response/table_resto_response.dart';

part 'update_table_resto_event.dart';
part 'update_table_resto_state.dart';

class UpdateTableRestoBloc
    extends Bloc<UpdateTableRestoEvent, UpdateTableRestoState> {

  final tableRestoRepository = TableRestoRepository();

  UpdateTableRestoBloc()
      : super(UpdateTableRestoInitial()) {

    on<TableRestoUpdated>((event, emit) async {

      emit(UpdateTableRestoLoading());

      try {

        final param = TableRestoParam(
          event.tableRestoParam.code,
          event.tableRestoParam.name,
          event.tableRestoParam.capacity,
        );

        TableRestoResponse response =
        await tableRestoRepository.updateTableResto(
          event.id,
          param,
        );

        emit(
          UpdateTableRestoSuccess(
            tableRestoResponse: response,
          ),
        );

      } catch (e) {

        emit(
          UpdateTableRestoError(
            message: e.toString(),
          ),
        );

      }
    });
  }
}