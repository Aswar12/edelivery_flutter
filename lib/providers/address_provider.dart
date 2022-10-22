import 'dart:async';
import 'dart:convert';

import 'package:edelivery_flutter/models/user_location_model.dart';
import 'package:edelivery_flutter/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class AddressProvider with ChangeNotifier {
  String _selectedAddress;

  String get selectedAddress => _selectedAddress;

  set selectedAddress(String selectedAddress) {
    _selectedAddress = selectedAddress;
    notifyListeners();
  }

  List<UserLocationModel> get userLocations => _userLocations;

  set userLocations(List<UserLocationModel> userLocations) {
    _userLocations = userLocations;
    notifyListeners();
  }

  Position _position;
  Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<String> addressType = [
    'Home',
    'Office',
    'School',
    'Other',
  ];
  int addressTypeIndex = 0;

  List<UserLocationModel> _userLocations = [];
  GoogleMapController _mapController;
  bool _loading = false;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    notifyListeners();
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      try {
        if (fromAddress) {
          _position = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> getUserLocations(String token) async {
    try {
      List<UserLocationModel> userLocations =
          await AddressService().getAddress(token);
      _userLocations = userLocations;
      return userLocations;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = 'Unknown Location Found';

    Response response = await AddressService().getAddressFromGeocode(latLng);

    if (response.statusCode == 200) {
      _address = jsonDecode(response.body)["results"][0]["formatted_address"]
          .toString();
      print('printting address' + _address);
      notifyListeners();
      return _address;
    } else {
      print('error google map api not found');
    }
  }
}
