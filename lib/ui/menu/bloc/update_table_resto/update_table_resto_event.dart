part of 'update_table_resto_bloc.dart';

@immutable
sealed class UpdateTableRestoEvent {}

final class TableRestoUpdated extends UpdateTableRestoEvent {
  final int id;
  final TableRestoParam tableRestoParam;

  TableRestoUpdated({
    required this.id,
    required this.tableRestoParam,
  });
}