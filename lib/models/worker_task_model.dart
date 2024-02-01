import 'package:equatable/equatable.dart';

enum TaskStatus {
  pending,
  completed,
}

class WorkerTask extends Equatable {
  WorkerTask({required this.task, required this.deadline});

  final String task;
  final String deadline;
  TaskStatus taskStatus = TaskStatus.pending;

  @override
  // TODO: implement props
  List<Object> get props => [task, deadline];
}
