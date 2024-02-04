part of 'job_cubit.dart';

abstract class JobState {}

final class JobLoading extends JobState {}

final class JobPaused extends JobState {}

final class JobLoaded extends JobState {}

final class JobCompleted extends JobState {}
