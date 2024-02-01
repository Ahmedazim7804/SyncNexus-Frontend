import 'package:worker_app/models/worker_task_model.dart';

class Job {
  Job({required this.title, required this.deadline});
  final String title;
  final String deadline;
  int totalTasks = 5;
  int completedTasks = 4;

  List<WorkerTask> tasks = [
    WorkerTask(task: "Pick up Materials", deadline: "23 Jan, 1PM"),
    WorkerTask(task: "Fix tire", deadline: "24 Jan, 1PM"),
  ];
}
