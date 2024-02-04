import 'package:bloc/bloc.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/models/worker_task_model.dart';

part 'job_state.dart';

enum JobStatus {
  active("Active"),
  paused("Paused"),
  completed("Completed");

  const JobStatus(this.value);
  final String value;
}

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobLoading());
  Job job = Job(title: "Fix the roof", deadline: "Today");
  bool isJobActive = false;
  late JobStatus jobStatus;

  void getData() {
    jobStatus = JobStatus.active;
    isJobActive = true;
    emit(JobLoaded());
  }

  void toggleJob() {
    isJobActive = !isJobActive;
    if (isJobActive) {
      jobStatus = JobStatus.active;
      emit(JobLoaded());
    } else {
      jobStatus = JobStatus.paused;
      emit(JobPaused());
    }
  }

  void finishedATask(WorkerTask task) {
    job.tasks.remove(task);
    if (job.tasks.isNotEmpty) {
      jobStatus = JobStatus.active;
      emit(JobLoaded());
    } else {
      jobStatus = JobStatus.completed;
      emit(JobCompleted());
    }
  }
}
