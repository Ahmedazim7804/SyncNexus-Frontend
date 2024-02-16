part of "location_cubit.dart";

abstract class LocationState {}

final class LocationLoading extends LocationState {}

final class LocationPermissionDenied extends LocationState {}

final class LocationPermissionGranted extends LocationState {}

final class LocationOn extends LocationState {}

final class LocationDisabled extends LocationState {}
