import 'package:collabcar/models/place.dart';
import 'package:collabcar/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({
    this.isSelecting = false,
    this.isPlaceFromSelection = true,
    Key? key,
  }) : super(key: key);

  final bool isSelecting;
  final bool isPlaceFromSelection;

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? _currentPosition;
  LatLng? _pickedLocation;

  Set<Marker> markers = <Marker>{};

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

  void _selectLocation(LatLng position, SearchProvider searchData) {
    setState(() {
      _pickedLocation = position;

      if (widget.isPlaceFromSelection) {
        searchData.setPlaceFrom(Place(
          latitude: position.latitude,
          longitude: position.longitude,
          address: "",
        ));
      } else {
        searchData.setPlaceTo(Place(
          latitude: position.latitude,
          longitude: position.longitude,
          address: "",
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<SearchProvider>(context, listen: false);
    if (searchData.search.placeFrom != null) {
      markers.add(Marker(
        markerId: const MarkerId('placeFrom'),
        position: LatLng(searchData.search.placeFrom!.latitude,
            searchData.search.placeFrom!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ));
    }
    if (searchData.search.placeTo != null) {
      markers.add(Marker(
        markerId: const MarkerId('placeTo'),
        position: LatLng(searchData.search.placeTo!.latitude,
            searchData.search.placeTo!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
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
          ? Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Helyszín keresése',
                      suffixIcon: Icon(Icons.search),
                    ),
                    autofillHints: [AutofillHints.fullStreetAddress],
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      zoom: 10,
                    ),
                    onTap: widget.isSelecting
                        ? (lng) => _selectLocation(lng, searchData)
                        : null,
                    markers: markers,
                  ),
                ),
              ],
            )
          : const CircularProgressIndicator(),
    );
  }
}
