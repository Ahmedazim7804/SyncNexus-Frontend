import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/models/lat_long_model.dart';
part 'location_state.dart';

class EmployerLocationCubit extends Cubit<EmployerLocationState> {
  EmployerLocationCubit() : super(LocationLoading()) {
    isLocationEnabled();
  }

  LatLong position = LatLong(lat: 0, long: 0);

  void isLocationEnabled() async {
    final isLocationOn =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;

    if (isLocationOn) {
      emit(LocationOn());
    } else {
      emit(LocationDisabled());
    }
  }

  Future<void> getLocation() async {
    checkForPermission();

    final isLocationOn =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (isLocationOn) {
      Position tempPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      double lat = tempPosition.latitude;
      double long = tempPosition.longitude;
      position = LatLong(lat: lat, long: long);

      emit(LocationAvailable());
    } else {
      emit(LocationDisabled());
    }
  }

  Future<void> checkForPermission() async {
    if (await Permission.location.isGranted) {
      return;
    }

    if (await Permission.location.isDenied) {
      Permission.locationWhenInUse.request().then(
        (value) {
          emit(LocationPermissionDenied());
          if (value == PermissionStatus.denied) {
            openAppSettings();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      );
    }

    if (await Permission.location.isPermanentlyDenied) {
      Permission.locationWhenInUse.request().then(
        (value) {
          if (value == PermissionStatus.denied) {
            emit(LocationPermissionDenied());
            openAppSettings();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
      );
    }
  }
}
