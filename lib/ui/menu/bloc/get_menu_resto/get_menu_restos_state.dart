part of 'get_menu_restos_bloc.dart';

@immutable
sealed class GetMenuRestosState {}

final class GetMenuRestosInitial
    extends GetMenuRestosState {}

final class GetMenuRestosLoading
    extends GetMenuRestosState {}

final class GetMenuRestosLoaded
    extends GetMenuRestosState {

  final List<MenuRestoModel> list;

  GetMenuRestosLoaded({
    required this.list,
  });
}

final class GetMenuRestosError
    extends GetMenuRestosState {

  final String message;

  GetMenuRestosError(this.message);
}