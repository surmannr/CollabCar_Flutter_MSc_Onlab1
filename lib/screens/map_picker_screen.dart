import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({this.isSelecting = false, Key? key}) : super(key: key);

  final bool isSelecting;

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? _currentPosition;
  LatLng? _pickedLocation;

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  void _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Geolocator szolgáltatás elérhetőség ellenőrzése
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('A helymeghatározó szolgáltatás nem elérhető.');
    }

    // Engedély ellenőrzése, ha megtagadja a felhasználó akkor az alkalmazás nem működik tovább.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'A helymeghatározáshoz szükséges engedélyeket el kell fogadni.');
      }
    }

    // Ha teljesen elutasította, akkor szintén ne működjön tovább.
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'A helymeghatározáshoz szükséges megadni az engedélyt.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Válassz ki egy helyet!'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: _currentPosition != null
          ? GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 10,
              ),
              onTap: widget.isSelecting ? _selectLocation : null,
              markers: _pickedLocation != null
                  ? {
                      Marker(
                          markerId: const MarkerId('place1'),
                          position: _pickedLocation!),
                    }
                  : {},
            )
          : const Text(
              "Nem sikerült elérni a térképet, kérlek próbáld újra később."),
    );
  }
}
