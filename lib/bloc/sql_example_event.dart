part of 'sql_example_bloc.dart';

@immutable
abstract class SqlExampleEvent {}

class GetStudentsEvent extends SqlExampleEvent {}

class PostStudentsEvent extends SqlExampleEvent {
  final Student student;
  PostStudentsEvent({required this.student});
}

class DeletedStudentsEvent extends SqlExampleEvent {
  final int id;
  DeletedStudentsEvent({required this.id});
}
