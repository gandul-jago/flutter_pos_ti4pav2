import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pmp12project/data/models/menu_resto_models.dart';
import 'package:pmp12project/data/models/order_menu_model.dart';
import 'package:pmp12project/param/order_menu_param.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc()
    : super(CheckoutSuccess(listOrderMenu: [], subTotal: 0, totalQuantity: 0)) {
    on<AddMenuRestoPressed>((event, emit) {
      var currentState = state as CheckoutSuccess;
      List<OrderMenuModel> newCheckout = [...currentState.listOrderMenu];
      emit(CheckoutLoading());
      // TODO: implement event handler

      if (newCheckout.any(
        (element) => element.menuRestoModel == event.menuRestoModel,
      )) {
        var index = newCheckout.indexWhere(
          (element) => element.menuRestoModel == event.menuRestoModel,
        );
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(
          OrderMenuModel(menuRestoModel: event.menuRestoModel, quantity: 1),
        );
      }
    });
  }
}
