part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

final class AddMenuRestoPressed extends CheckoutEvent {
  final MenuRestoModel menuRestoModel;
  AddMenuRestoPressed({required this.menuRestoModel});
}

final class RemoveMenuRestoPressed extends CheckoutEvent{

  final MenuRestoModel menuRestoModel;

  RemoveMenuRestoPressed({required this.menuRestoModel});
}