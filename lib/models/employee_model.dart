import 'package:worker_app/bloc/cubit/employee/location_cubit.dart';
import 'package:worker_app/models/user_model.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
import 'package:worker_app/models/lat_long_model.dart';
import 'package:intl/intl.dart';

class Employee extends User {
  Employee(
      {required name,
      required phone,
      required email,
      required this.id,
      this.removed = false})
      : super(email: email, name: name, phone: phone) {
    getMyTasks();
    getLastRecordedLocation();
  }

  final String id;
  List<WorkerTask> tasks = [];
  bool removed;
  LatLongCollection locationRecords = LatLongCollection();

  Future<void> getMyTasks() async {
    final List<WorkerTask> allParsedTasks = [];

    try {
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
    } catch (e) {
      removed = true;
      return;
    }
  }

  Future<void> getLastRecordedLocation() async {
    final latLongCollectionUnparsed =
        await getLocation(id, DateTime.parse("2000-01-01"), DateTime.now());

    for (final rawLatLong in latLongCollectionUnparsed) {
      final lat = rawLatLong['location_lat'];
      final long = rawLatLong['location_long'];
      final DateTime createdAt = DateTime.parse(rawLatLong['created_at']);

      LatLong latLong = LatLong(lat: lat, long: long, createdAt: createdAt);

      locationRecords.add(latLong);
    }
  }
}
