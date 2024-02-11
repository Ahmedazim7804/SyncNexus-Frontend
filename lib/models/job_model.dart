import 'package:worker_app/bloc/cubit/employee_location_cubit.dart';
import 'package:worker_app/models/worker_task_model.dart';

class Job {
  Job(
      {required this.title,
      required this.desc,
      required this.employerId,
      required this.amount,
      this.latLong,
      this.done,
      this.deleted});
  final String title;
  final String desc;
  final String employerId;
  final String amount;
  LatLong? latLong;
  bool? done;
  bool? deleted;
}
