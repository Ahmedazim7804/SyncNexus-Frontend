import 'package:bloc/bloc.dart';
import 'package:worker_app/models/job_model.dart';
import 'package:worker_app/models/worker_task_model.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobLoading());
  Job job = Job(title: "Fix the roof", deadline: "Today");
  bool isJobActive = false;

  void getData() {
    isJobActive = true;
    emit(JobLoaded(job: job));
  }

  void toggleJob() {
    isJobActive = !isJobActive;
    if (isJobActive) {
      emit(JobLoaded(job: job));
    } else {
      emit(JobPaused(job: job));
    }
  }

  void finishedATask(WorkerTask task) {
    job.tasks.remove(task);
    if (job.tasks.isNotEmpty) {
      emit(JobLoaded(job: job));
    } else {
      emit(JobCompleted(job: job));
    }
  }
}
