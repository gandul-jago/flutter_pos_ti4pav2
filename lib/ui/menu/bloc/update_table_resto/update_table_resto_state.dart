part of 'update_table_resto_bloc.dart';

@immutable
sealed class UpdateTableRestoState {}

final class UpdateTableRestoInitial extends UpdateTableRestoState {}

final class UpdateTableRestoLoading extends UpdateTableRestoState {}

final class UpdateTableRestoSuccess extends UpdateTableRestoState {
  final TableRestoResponse? tableRestoResponse;

  UpdateTableRestoSuccess({
    required this.tableRestoResponse,
  });
}

final class UpdateTableRestoError extends UpdateTableRestoState {
  final String message;

  UpdateTableRestoError({
    required this.message,
  });
}