import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_exmple/models/student.dart';
import 'bloc/sql_example_bloc.dart';
import 'injectable/init_injectable.dart';

void main() {
  configureInjection(Env.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: SQLExampleWidget(),
    );
  }
}

class SQLExampleWidget extends StatelessWidget {
  const SQLExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SqlExampleBloc>()..add(GetStudentsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: RefreshIndicator(
            onRefresh: () async =>
                context.read<SqlExampleBloc>()..add(GetStudentsEvent()),
            child: BlocConsumer<SqlExampleBloc, SqlExampleState>(
              listener: (context, state) {
                if (state is StudentsAddedState) {
                  context.read<SqlExampleBloc>().add(GetStudentsEvent());
                }
                if (state is StudentsDeletedState) {
                  context.read<SqlExampleBloc>().add(GetStudentsEvent());
                }
              },
              builder: (context, state) {
                if (state is GetStudentsError) {
                  return const Center(
                    child: Text('error'),
                  );
                }
                if (state is GetStudentsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetStudentsSuccess) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.students?.length ?? 0,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) => Dismissible(
                            background: const SizedBox.shrink(),
                            key: Key('${state.students?[index].id ?? 0}'),
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              context.read<SqlExampleBloc>().add(
                                  DeletedStudentsEvent(
                                      id: state.students?[index].id ?? 0));
                            },
                            child: Container(
                              color: Colors.blue,
                              height: 32,
                              child: Center(
                                child: Text(
                                  state.students?[index].name ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text('Hello World'),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context
                  .read<SqlExampleBloc>()
                  .add(PostStudentsEvent(student: Student(name: 'Item  ')));
            },
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
