import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite_exmple/repo/repo.dart';
import '../models/student.dart';

part 'sql_example_event.dart';
part 'sql_example_state.dart';

@injectable
class SqlExampleBloc extends Bloc<SqlExampleEvent, SqlExampleState> {
  final Repo _repo;
  SqlExampleBloc(this._repo) : super(SqlExampleInitial()) {
    on<GetStudentsEvent>((event, emit) async {
      emit(GetStudentsLoading());
      await _repo.getStudents().then((value) {
        emit(GetStudentsSuccess(value));
      }).catchError((e) {
        emit(GetStudentsError());
      });
    });
    on<PostStudentsEvent>((event, emit) async {
      await _repo.postStudent(event.student).then((value) {
        emit(StudentsAddedState());
      }).catchError((e) {
        emit(GetStudentsError());
      });
    });
    on<DeletedStudentsEvent>((event, emit) async {
      await _repo.deleteStudent(event.id).then((value) {
        emit(StudentsDeletedState());
      }).catchError((e) {
        emit(GetStudentsError());
      });
    });
  }
}
