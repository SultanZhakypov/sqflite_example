part of 'sql_example_bloc.dart';

@immutable
abstract class SqlExampleState extends Equatable {}

class SqlExampleInitial extends SqlExampleState {
  @override
  List<Object?> get props => [];
}

class GetStudentsSuccess extends SqlExampleState {
  final List<Student>? students;
  GetStudentsSuccess(this.students);

  @override
  List<Object?> get props => [students];
}

class StudentsAddedState extends SqlExampleState {
  @override
  List<Object?> get props => [];
}
class StudentsDeletedState extends SqlExampleState {
  @override
  List<Object?> get props => [];
}

class GetStudentsError extends SqlExampleState {
  @override
  List<Object?> get props => [];
}

class GetStudentsLoading extends SqlExampleState {
  @override
  List<Object?> get props => [];
}
