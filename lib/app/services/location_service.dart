import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    } else if (permission == LocationPermission.deniedForever) {
      return false;
    } else if (permission == LocationPermission.unableToDetermine) {
      return false;
    } else {
      return true;
    }
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<double> getLatitude() async {
    Position position = await getCurrentLocation();
    return position.latitude;
  }

  Future<double> getLongitude() async {
    Position position = await getCurrentLocation();
    return position.longitude;
  }

  Future<String> getAddressFromLatLng() async {
    await getCurrentLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(await getLatitude(), await getLongitude());
    Placemark location = placemarks.first;
    String? address = location.locality;
    return address.toString();
  }
  Future<String> getAddressFromLatLngNew({required double lat,required double long}) async {
    await getCurrentLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark location = placemarks.first;
    String? address = "${location.name} ${location.administrativeArea} ${location.country}";
    return address.toString();
  }
}
