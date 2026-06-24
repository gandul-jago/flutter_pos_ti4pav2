part of 'delete_table_resto_bloc.dart';

@immutable
sealed class DeleteTableRestoEvent {}

final class TableRestoDeleted extends DeleteTableRestoEvent {
  final int id;

  TableRestoDeleted({
    required this.id,
  });
}