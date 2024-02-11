import 'package:equatable/equatable.dart';

enum TaskStatus { pending, completed, deleted }

class WorkerTask extends Equatable {
  WorkerTask(
      {required this.task,
      required this.deadline,
      this.status = TaskStatus.pending});

  final String task;
  final String deadline;
  TaskStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [task, deadline];
}
