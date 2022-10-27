import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:edelivery_flutter/theme.dart';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController googleMapController;
  final LatLng initialPosition;
  const PickAddressMap({
    Key key,
    this.fromAddress,
    this.fromSignup,
    this.googleMapController,
    this.initialPosition,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  LatLng _initialPosition;
  GoogleMapController _mapController;
  CameraPosition _cameraPosition;
  AddressProvider addressProvider = AddressProvider();
  @override
  void initState() {
    super.initState();
    if (addressProvider.userLocations.isEmpty) {
      _initialPosition = widget.initialPosition;
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (addressProvider.addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(
            addressProvider.getAddress['latitude'],
          ),
          double.parse(
            addressProvider.getAddress['longitude'],
          ),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    addressProvider.updatePosition(_cameraPosition, true);
                  },
                ),
                Center(
                  child: addressProvider.loading
                      ? const AssetImage('assets/pin_map.png')
                      : const CircularProgressIndicator(),
                ),
                Positioned(
                  top: Dimenssions.height30,
                  left: Dimenssions.width20,
                  right: Dimenssions.width20,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimenssions.radius20)),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            '${addressProvider.pickPlacemark.name ?? ''}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimenssions.font16,
                                fontWeight: semiBold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Icon(Icons.location_on, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 200,
                    left: Dimenssions.width20,
                    right: Dimenssions.width20,
                    child: InkWell(
                      onTap: addressProvider.loading
                          ? null
                          : () {
                              if (addressProvider.pickPosition.latitude != 0 &&
                                  addressProvider.pickPlacemark.name != null) {
                                if (widget.fromAddress) {
                                  if (widget.googleMapController != null) {
                                    widget.googleMapController.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: LatLng(
                                              addressProvider
                                                  .pickPosition.latitude,
                                              addressProvider
                                                  .pickPosition.longitude),
                                          zoom: 17,
                                        ),
                                      ),
                                    );
                                    addressProvider.setAddAddressData();
                                  }
                                  Navigator.pushNamed(context, '/add-address');
                                }
                              }
                            },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimenssions.radius20)),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                'Pilih Lokasi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimenssions.font16,
                                    fontWeight: semiBold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> _determinatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
