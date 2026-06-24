part of 'delete_table_resto_bloc.dart';

@immutable
sealed class DeleteTableRestoState {}

final class DeleteTableRestoInitial extends DeleteTableRestoState {}

final class DeleteTableRestoLoading extends DeleteTableRestoState {}

final class DeleteTableRestoSuccess extends DeleteTableRestoState {}

final class DeleteTableRestoError extends DeleteTableRestoState {
  final String message;

  DeleteTableRestoError({
    required this.message,
  });
}