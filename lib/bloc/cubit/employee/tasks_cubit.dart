import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker_app/models/worker_task_model.dart';
part 'tasks_state.dart';

class EmployeeTasksCubit extends Cubit<EmployeeTasksState> {
  EmployeeTasksCubit() : super(EmployeeTasksLoading());

  void getTasks() {}
}
