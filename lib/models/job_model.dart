import 'package:worker_app/bloc/cubit/employee/location_cubit.dart';
import 'package:worker_app/models/worker_task_model.dart';
import 'package:worker_app/provider/employer_endpoints.dart';

class Job {
  Job(
      {required this.jobId,
      required this.title,
      required this.desc,
      required this.employerId,
      required this.amount,
      this.latLong,
      this.done,
      this.deleted});

  final String jobId;
  final String title;
  final String desc;
  final String employerId;
  final String amount;
  LatLong? latLong;
  bool? done;
  bool? deleted;

  Future<void> removeThisJob() async {
    await deleteJob(jobId);
    deleted = true;
  }

  Future<void> completeThisJob() async {
    await completeJob(jobId);
    done = true;
  }
}
