import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLong {
  LatLong({required this.lat, required this.long, this.createdAt});

  double lat;
  double long;
  DateTime? createdAt;

  LatLng toLatLng() {
    return LatLng(lat, long);
  }
}

class LatLongCollection {
  bool isEmpty = true;
  final List<LatLong> collection = [];

  void add(LatLong latLong) {
    if (isEmpty == true) {
      isEmpty = false;
    }
    collection.add(latLong);
  }

  CameraPosition get initialCameraPosition {
    if (isEmpty) {
      return const CameraPosition(
        target: LatLng(15.5937, 80.9629),
        zoom: 4,
      );
    }

    return CameraPosition(target: collection[0].toLatLng(), zoom: 14.4746);
  }

  List<LatLng> toLatLngList() {
    return collection.map((latLong) => latLong.toLatLng()).toList();
  }
}
