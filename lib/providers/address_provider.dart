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
  UserLocationModel _userLocation;

  AddressProvider();

  String get selectedAddress => _selectedAddress;

  get addressTypeIndex => _addressTypeIndex;

  GoogleMapController get googleMapController => _mapController;

  set selectedAddress(String selectedAddress) {
    _selectedAddress = selectedAddress;
    notifyListeners();
  }

  List<UserLocationModel> get userLocations => _userLocations;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  final List<String> _addressTypeList = [
    'Home',
    'Office',
    'Other',
  ];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;

  List<UserLocationModel> _userLocations = [];

  List<UserLocationModel> _addressList = [];
  List<UserLocationModel> get addressList => _addressList;
  List<UserLocationModel> _allAddressList = [];
  List<UserLocationModel> get allAddressList => _allAddressList;

  GoogleMapController _mapController;
  bool _isLoading = false;
  bool _updateAddressData = true;
  bool _changeAddress = true;
  bool _loading = false;
  Position _position;
  Position _pickPosition;

  bool get loading => _loading;
  bool get updateAddressData => _updateAddressData;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    notifyListeners();
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      notifyListeners();
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
          // ignore: no_leading_underscores_for_local_identifiers
          String _address = await getAddressfromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
          _loading = false;
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
      _loading = false;
      notifyListeners();
    } else {
      _updateAddressData = true;
    }
  }

  List<UserLocationModel> get userLocation => _userLocations;

  set products(List<UserLocationModel> userLocations) {
    _userLocations = userLocations;
    notifyListeners();
  }

  Future<void> getUserLocations() async {
    try {
      List<UserLocationModel> userLocations =
          await AddressService().getAddress();
      _userLocations = userLocations;
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

  Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  UserLocationModel dataAdress;
  UserLocationModel get dataAddress => getUserAddress();

  getUserAddress() {
    Future<UserLocationModel> _dataAddress =
        AddressService().getUserAddressFormLocal();
    notifyListeners();
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    notifyListeners();
  }

  Future<bool> addAddress({
    String customerName,
    String phoneNumber,
    String address,
    double latitude,
    double longitude,
    int addressType,
  }) async {
    try {
      UserLocationModel userLocationModel = await AddressService().addAddress(
        customerName: customerName,
        phoneNumber: phoneNumber,
        address: address,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        addressType: addressType,
      );
      _userLocation = userLocationModel;
      getAddressList();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getAddressList() async {
    Response response = await AddressService().getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        _addressList.add(UserLocationModel.fromJson(item));
        _allAddressList.add(UserLocationModel.fromJson(item));
      }
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    notifyListeners();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
  }
}
