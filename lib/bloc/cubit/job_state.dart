part of 'job_cubit.dart';

enum JobStatus {
  active("Active"),
  paused("Paused"),
  completed("Completed");

  const JobStatus(this.value);
  final String value;
}

abstract class JobState {}

final class JobLoading extends JobState {}

final class JobPaused extends JobState {
  JobPaused({required this.job});
  final JobStatus jobStatus = JobStatus.paused;
  final Job job;
}

final class JobLoaded extends JobState {
  JobLoaded({required this.job});
  final JobStatus jobStatus = JobStatus.active;
  final Job job;
}

final class JobCompleted extends JobState {
  JobCompleted({required this.job});
  final JobStatus jobStatus = JobStatus.completed;
  final Job job;
}
