part of 'location_cubit.dart';

abstract class EmployerLocationState {}

final class LocationLoading extends EmployerLocationState {}

final class LocationDisabled extends EmployerLocationState {}

final class LocationPermissionDenied extends EmployerLocationState {}

final class LocationOn extends EmployerLocationState {}

final class LocationAvailable extends EmployerLocationState {}
