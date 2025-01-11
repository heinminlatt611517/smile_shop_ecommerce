import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/widgets/common_button_view.dart';

import '../utils/dimens.dart';
import '../utils/images.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  loc.LocationData? _currentLocation;
  final loc.Location _location = loc.Location(); // Use 'loc.Location'
  Marker? _currentLocationMarker;
  Marker? _tappedLocationMarker;
  String _address = "Tap on the map to get address";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _searchAndNavigate(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(location.latitude, location.longitude),
            15,
          ),
        );

        setState(() {
          _tappedLocationMarker = Marker(
            markerId: const MarkerId("search_location"),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: query),
          );
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error finding location: $e";
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    /// Get current location
    final location = await _location.getLocation();
    setState(() {
      _currentLocation = location;
      _addCurrentLocationMarker(_currentLocation!);
    });
  }

  void _addCurrentLocationMarker(loc.LocationData location) {
    final marker = Marker(
      markerId: const MarkerId("current_location"),
      position: LatLng(location.latitude!, location.longitude!),
      infoWindow: const InfoWindow(title: "You are here"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _currentLocationMarker = marker;
    });

    /// Move the camera to the current location
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(location.latitude!, location.longitude!),
        15,
      ),
    );
  }

  Future<void> _getAddressFromCoordinates(LatLng position) async {
    /// Add a marker at the tapped location
    final marker = Marker(
      markerId: const MarkerId("tapped_location"),
      position: position,
      infoWindow: const InfoWindow(title: "Tapped Location"),
    );

    setState(() {
      _tappedLocationMarker = marker;
    });
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String state = place.administrativeArea ?? "";
        String township = place.locality ?? "";

        print("State: $state");
        print("Township: $township");
        setState(() {
          _address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });

        print("Address: $_address");
      } else {
        setState(() {
          _address = "No address found.";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error fetching address: $e";
      });
    }
  }

  Future<void> _handleTap(LatLng tappedPoint) async {
    /// Add a marker at the tapped location
    final marker = Marker(
      markerId: const MarkerId("tapped_location"),
      position: tappedPoint,
      infoWindow: const InfoWindow(title: "Tapped Location"),
    );

    setState(() {
      _tappedLocationMarker = marker;
    });

    /// Get address from coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedPoint.latitude,
        tappedPoint.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        debugPrint("PlaceStreet>>>>>>${place.street}");
        setState(() {
          _address =
              "${place.street},${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          _address = "No address found";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _currentLocation?.latitude ?? 0.0,
                  _currentLocation?.longitude ??
                      0.0), // Default to San Francisco
              zoom: 12,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: _getAddressFromCoordinates,
            markers: {
              if (_currentLocationMarker != null) _currentLocationMarker!,
              if (_tappedLocationMarker != null) _tappedLocationMarker!,
            },
          ),

          ///back arrow
          Positioned(
            top: 50,
            child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              margin:const EdgeInsets.only(left: kMarginMedium),
              padding:const EdgeInsets.all(kMarginMedium),
              decoration:const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle),
              child: Image.asset(
                kBackIcon,
                fit: BoxFit.cover,
                height: 10,
                width: 10,
              ),
            ),
          ),),
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            child: Column(
              children: [
                TextField(
                  cursorColor: kPrimaryColor,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search for a place",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _searchAndNavigate(searchController.text);
                      },
                    ),
                  ),
                  onSubmitted: (val) {
                    _searchAndNavigate(searchController.text);
                  },
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _address,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Visibility(
                    visible: _address != "Tap on the map to get address",
                    child: const SizedBox(
                      height: 14,
                    ),
                  ),
                  Visibility(
                      visible: _address != "Tap on the map to get address",
                      child: CommonButtonView(
                          label: 'Confirm Address',
                          labelColor: Colors.white,
                          bgColor: kPrimaryColor,
                          onTapButton: () {
                            if (_address != "Tap on the map to get address") {
                              Navigator.pop(context, _address);
                            }
                          }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
