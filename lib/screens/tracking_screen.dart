import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:collabcar/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({required this.title, required this.user, Key? key})
      : super(key: key);

  final String title;
  final User user;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    setState(() {
      init();
      getCurrentLocation();
    });
  }

  StreamSubscription? _locationSubscription;
  Location _locationTracker = Location();
  Set<Marker> markers = <Marker>{};
  Set<Circle> circles = <Circle>{};
  late GoogleMapController _controller;

  CameraPosition initialLocation = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(num latitude, num longitude, num accuracy,
      num bearing, Uint8List imageData) {
    LatLng latlng = LatLng(latitude.toDouble(), longitude.toDouble());
    setState(() {
      markers.clear();
      markers.add(Marker(
          markerId: const MarkerId("home"),
          position: latlng,
          rotation: bearing.toDouble(),
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)));
      circles.clear();
      circles.add(Circle(
          circleId: const CircleId("car"),
          radius: accuracy.toDouble(),
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70)));
    });
  }

  void init() async {
    await databaseReference
        .child("location")
        .child(widget.user.id)
        .once()
        .then((value) async {
      var location = value.snapshot.value as LinkedHashMap;
      print(location.toString());
      var latitude = location['locationData']['latitude'];
      var longitude = location['locationData']['longitude'];
      var accuracy = location['locationData']['accuracy'];
      var bearing = location['locationData']['bearing'];

      Uint8List imageData = await getMarker();

      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: (bearing as num).toDouble(),
          target: LatLng(
              (latitude as num).toDouble(), (longitude as num).toDouble()),
          tilt: 0,
          zoom: 18.00)));
      updateMarkerAndCircle(latitude, longitude, accuracy, bearing, imageData);
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();

      if (_locationSubscription != null) {
        _locationSubscription?.cancel();
      }

      _locationSubscription = databaseReference
          .child("location")
          .child(widget.user.id)
          .onChildChanged
          .listen((newLocalData) {
        if (_controller != null) {
          var newLocationData = newLocalData.snapshot.value as LinkedHashMap;
          var latitude = newLocationData['latitude'];
          var longitude = newLocationData['longitude'];
          var accuracy = newLocationData['accuracy'];
          var bearing = newLocationData['bearing'];
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: (bearing as num).toDouble(),
                  target: LatLng((latitude as num).toDouble(),
                      (longitude as num).toDouble()),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(
              latitude, longitude, accuracy, bearing, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription?.cancel();
      databaseReference.onDisconnect();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: markers,
        circles: circles,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
