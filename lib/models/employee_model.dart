import 'package:worker_app/models/user_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employee_endpoints.dart';

class Employee extends User {
  Employee({required name, required phone, required email, required this.id})
      : super(email: email, name: name, phone: phone) {
    getMyTasks();
  }

  final String id;
  List<WorkerTask> tasks = [];

  Future<void> getMyTasks() async {
    final List<WorkerTask> allParsedTasks = [];

    final unparsedTasks =
        await getTasks(id, DateTime.parse("2000-01-01"), DateTime.now());

    for (final task in unparsedTasks) {
      final String heading = task['heading'];
      final String deadline = task['last_date'];
      final String stringStatus = task['status'];
      late final TaskStatus status;

      if (stringStatus == 'pending') {
        status = TaskStatus.pending;
      } else if (stringStatus == 'done') {
        status = TaskStatus.completed;
      } else {
        status = TaskStatus.deleted;
      }

      WorkerTask parsedTask =
          WorkerTask(task: heading, deadline: deadline, status: status);

      allParsedTasks.add(parsedTask);
    }

    tasks = allParsedTasks;
  }
}
