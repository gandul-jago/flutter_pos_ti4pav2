part of 'get_menu_restos_bloc.dart';

@immutable
sealed class GetMenuRestosEvent {}

final class MenuRestosFetched
    extends GetMenuRestosEvent {}