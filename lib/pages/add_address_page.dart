import 'package:edelivery_flutter/providers/address_provider.dart';
import 'package:edelivery_flutter/theme.dart';
import 'package:flutter/material.dart';
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
  LatLng initalPosition = const LatLng(-4.6310321, 119.5882535);
  AddressProvider addressProvider = AddressProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (addressProvider.userLocations.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
            double.parse(addressProvider.userLocations[0].latitude),
            double.parse(addressProvider.userLocations[0].longitude),
          ),
          zoom: 17);
      initalPosition = LatLng(
        double.parse(addressProvider.userLocations[0].latitude),
        double.parse(addressProvider.userLocations[0].longitude),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider = Provider.of<AddressProvider>(context);
    addresscontroller.text = '${addressProvider.placemark.name ?? ''}'
        '${addressProvider.placemark.locality ?? ''}'
        '${addressProvider.placemark.postalCode ?? ''}'
        '${addressProvider.placemark.country ?? ''}';
    print("address in my view" + addresscontroller.text);
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Address", style: primaryTextStyle),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor1,
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2, color: primaryColor),
            ),
            child: Stack(
              children: [
                GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: initalPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: false,
                    mapToolbarEnabled: false,
                    onCameraIdle: () {
                      addressProvider.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) {
                      addressProvider.setMapController(controller);
                    }),
              ],
            ),
          ),
          SizedBox(
            height: Dimenssions.height20,
          ),
          Container(
            margin: EdgeInsets.all(Dimenssions.height20),
            child: TextFormField(
              autofocus: true,
              controller: addresscontroller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(Dimenssions.radius15)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: BorderRadius.circular(Dimenssions.radius15)),
                hintText: 'Address',
                labelText: "Address",
                labelStyle: primaryTextStyle,
                prefixIcon: Icon(
                  Icons.maps_home_work_outlined,
                  color: primaryTextColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
