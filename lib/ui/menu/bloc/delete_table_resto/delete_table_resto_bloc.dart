import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmp12project/data/repo/table_resto_repository.dart';

part 'delete_table_resto_event.dart';
part 'delete_table_resto_state.dart';

class DeleteTableRestoBloc
    extends Bloc<DeleteTableRestoEvent, DeleteTableRestoState> {

  final tableRestoRepository = TableRestoRepository();

  DeleteTableRestoBloc()
      : super(DeleteTableRestoInitial()) {

    on<TableRestoDeleted>((event, emit) async {

      emit(DeleteTableRestoLoading());

      try {

        await tableRestoRepository.deleteTableResto(
          event.id,
        );

        emit(DeleteTableRestoSuccess());

      } catch (e) {

        emit(
          DeleteTableRestoError(
            message: e.toString(),
          ),
        );

      }
    });
  }
}