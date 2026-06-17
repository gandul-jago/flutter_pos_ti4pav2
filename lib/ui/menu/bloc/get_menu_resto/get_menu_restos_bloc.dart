import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:pmp12project/data/models/menu_resto_models.dart';
import 'package:pmp12project/data/repo/menu_resto_repository.dart';
part 'get_menu_restos_event.dart';
part 'get_menu_restos_state.dart';

class GetMenuRestosBloc
    extends Bloc<GetMenuRestosEvent, GetMenuRestosState> {

  final menuRestoRepository = MenuRestoRepository();

  GetMenuRestosBloc()
      : super(GetMenuRestosInitial()) {

    on<MenuRestosFetched>((event, emit) async {

      emit(GetMenuRestosLoading());

      try {

        var response =
        await menuRestoRepository.getMenuRestos();

        emit(GetMenuRestosLoaded(list: response));

      } catch (e) {

        emit(GetMenuRestosError(e.toString()));

      }
    });
  }
}