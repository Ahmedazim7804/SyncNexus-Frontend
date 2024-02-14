import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
part 'location_state.dart';

class LatLong {
  LatLong({required this.lat, required this.long});

  double lat;
  double long;
}

class EmployeeLocationCubit extends Cubit<EmployeeLocationState> {
  EmployeeLocationCubit() : super(LocationLoading()) {
    checkForPermission();
    sendLocationAfter5Minutes();
  }

  LatLong position = LatLong(lat: 0, long: 0);

  void isLocationEnabled() async {
    final isLocationOn =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;

    if (isLocationOn) {
      emit(LocationOn());
    }
  }

  void sendLocationAfter5Minutes() async {
    final isLocationOn =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;
    if (isLocationOn) {
      Position tempPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      double lat = tempPosition.latitude;
      double long = tempPosition.longitude;
      position = LatLong(lat: lat, long: long);

      emit(LocationAvailable());

      // await addLocation(lat, long);
    } else {
      emit(LocationDisabled());
    }

    // Future.delayed(const Duration(seconds: 5)).then((_) {
    //   sendLocationAfter5Minutes();
    // });
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
