import 'package:edelivery_flutter/models/user_location_model.dart';
import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:edelivery_flutter/providers/auth_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:edelivery_flutter/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phoneNumbercontroller = TextEditingController();
  TextEditingController customerNamecontroller = TextEditingController();
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(-4.6310321, 119.5882535), zoom: 17);
  bool _islogged;
  bool isLoading = false;
  LatLng initalPosition = const LatLng(-4.6310321, 119.5882535);
  AddressProvider addressProvider = AddressProvider();

  @override
  void initState() {
    super.initState();
    _determinatePosition();
    _islogged = Provider.of<AuthProvider>(context, listen: false).user != null;
    if (addressProvider.userLocations.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
            double.parse(addressProvider.getAddress["latitude"]),
            double.parse(addressProvider.getAddress["longitude"]),
          ),
          zoom: 17);
      initalPosition = LatLng(
        double.parse(addressProvider.getAddress["latitude"]),
        double.parse(addressProvider.getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserLocationModel userLocationModel;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    if (authProvider.user != null && customerNamecontroller.text.isEmpty) {
      customerNamecontroller.text = authProvider.user.name;
      phoneNumbercontroller.text = authProvider.user.phoneNumber;
      if (addressProvider.userLocations.isNotEmpty) {}
    }
    addresscontroller.text = '${addressProvider.placemark.name ?? ''}'
        '${addressProvider.placemark.locality ?? ''}'
        '${addressProvider.placemark.postalCode ?? ''}'
        '${addressProvider.placemark.country ?? ''}';

    print("address in my view" + addresscontroller.text);

    handleAddAddress() async {
      setState(() {
        isLoading = true;
      });

      if (await addressProvider.addAddress(
        customerName: customerNamecontroller.text,
        phoneNumber: phoneNumbercontroller.text,
        addressType: addressProvider.addressTypeIndex,
        address: addresscontroller.text,
        latitude: addressProvider.position.latitude,
        longitude: addressProvider.position.longitude,
      )) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Berhasil Menambahkan Alamat Tujuan',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Menambahkan Alamat Tujuan !',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget saveAddressButton() {
      return Container(
        height: Dimenssions.width50,
        width: double.infinity,
        margin: EdgeInsets.only(
            top: Dimenssions.height20,
            bottom: Dimenssions.height20,
            left: Dimenssions.width25,
            right: Dimenssions.width25),
        child: TextButton(
          onPressed: handleAddAddress,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Save Address',
            style: primaryTextStyle.copyWith(
              fontSize: Dimenssions.font18,
              fontWeight: medium,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Address", style: primaryTextStyle),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: Dimenssions.height220,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: primaryColor),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    // onTap: (latLng) {
                    //   Navigator.popAndPushNamed(context, '/pick-address',
                    //       arguments: PickAddressMap(
                    //         fromSignup: false,
                    //         fromAddress: false,
                    //         googleMapController:
                    //             addressProvider.googleMapController,
                    //         initialPosition: initalPosition,
                    //       ));
                    // },

                    initialCameraPosition:
                        CameraPosition(target: initalPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    mapToolbarEnabled: true,
                    onCameraIdle: () {
                      addressProvider.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) {
                      addressProvider.setMapController(controller);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimenssions.height20, top: Dimenssions.height20),
              height: Dimenssions.height50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: addressProvider.addressTypeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        addressProvider.setAddressTypeIndex(index);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: Dimenssions.width10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssions.width20,
                              vertical: Dimenssions.height10),
                          margin: EdgeInsets.only(
                            right: Dimenssions.width10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimenssions.radius20 / 4),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color:
                                      addressProvider.addressTypeIndex == index
                                          ? mainColor
                                          : Theme.of(context).disabledColor)
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.all(Dimenssions.height20),
              child: TextFormField(
                controller: customerNamecontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  hintText: 'Nama Penerima',
                  labelText: "Masukkan Nama Penerima",
                  labelStyle: primaryTextStyle,
                  prefixIcon: Icon(
                    Icons.person,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(Dimenssions.height20),
              child: TextFormField(
                controller: phoneNumbercontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  hintText: 'Masukkan Nomor Telepon',
                  labelText: "Nomor Telepon",
                  labelStyle: primaryTextStyle,
                  prefixIcon: Icon(
                    Icons.phone_android_outlined,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(Dimenssions.height20),
              child: TextFormField(
                controller: addresscontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                      borderRadius:
                          BorderRadius.circular(Dimenssions.radius15)),
                  hintText: 'Address',
                  labelText: "Delivery Address",
                  labelStyle: primaryTextStyle,
                  prefixIcon: Icon(
                    Icons.map_outlined,
                    color: primaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isLoading
          ? Container(
              margin: EdgeInsets.all(Dimenssions.height20),
              child: const LoadingButton())
          : saveAddressButton(),
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
