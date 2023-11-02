import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  double? longitude;
  double? latitude;
  bool permissionAllowed = false;
  var selectedAddress;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
      permissionAllowed = true;
      notifyListeners();
    } else {
      print("Permissions not allowed");
    }
  }

  void onCameraMove(CameraPosition cameraposition) async {
    latitude = cameraposition.target.latitude;
    longitude = cameraposition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    // final coordinates = Coordinates(latitude, longitude);
    // final addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // selectedAddress = addresses.first;
    // print("${selectedAddress.featureName}: ${selectedAddress.addressLine}");
  }
}
