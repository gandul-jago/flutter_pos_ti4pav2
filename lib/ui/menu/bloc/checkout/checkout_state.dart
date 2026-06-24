part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutSuccess extends CheckoutState {
  final List<OrderMenuModel> listOrderMenu;
  final double subTotal;
  final double totalQuantity;

  CheckoutSuccess({
    required this.listOrderMenu,
    required this.subTotal,
    required this.totalQuantity,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError({required this.message});
}
