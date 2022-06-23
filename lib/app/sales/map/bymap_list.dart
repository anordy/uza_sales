import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/sales/items/markers_items.dart';
import 'package:uza_sales/app/sales/provider/route_provider.dart';

import '../model/route_model.dart';

const LatLng SOURCE_LOCATION = LatLng(-6.7504594, 39.227826);
const LatLng DEST_LOCATION = LatLng(-6.7778733, 39.2625715);
const double CAMERA_ZOOM = 12;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_INVISIBLE_POSITION = -220;

class ByMap extends StatefulWidget {
  @override
  _ByMapState createState() => _ByMapState();
}

class _ByMapState extends State<ByMap> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/custom-marker.png');

    // destinationIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 2.0),
    //     'assets/icons/custom-marker.png');
  }

  //  set markers
  Iterable markers = [];

  // Set<Marker> _markers = Set<Marker>();
  double pinPillPosition = PIN_VISIBLE_POSITION;
  LatLng currentLocation;
  LatLng middleLocation;
  LatLng destinationLocation;
  bool userBadgeSelected = false;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    // markers = _markers;
    polylinePoints = PolylinePoints();
    // BitmapDescriptor.fromAssetImage(
    //         ImageConfiguration(), 'assets/imagges/custom-marker.png')
    //     .then((value) => sourceIcon = value);

    // set up initial locations
    // this.setInitialLocation();
  }

  void setInitialLocation() {
    currentLocation = LatLng(
      AppConstant.list[0]['lat'],
      AppConstant.list[0]['lon'],
      // SOURCE_LOCATION.latitude,
      // SOURCE_LOCATION.longitude
    );

    // middleLocation = LatLng(
    //   AppConstant.list[1]['lat'],
    //   AppConstant.list[1]['lon'],
    //   // DEST_LOCATION.latitude,
    //   // DEST_LOCATION.longitude
    // );

    destinationLocation = LatLng(
      AppConstant.list[2]['lat'],
      AppConstant.list[2]['lon'],
      // DEST_LOCATION.latitude,
      // DEST_LOCATION.longitude
    );
  }

  @override
  Widget build(BuildContext context) {
    final _routeProvider = Provider.of<RouteProvider>(context);
    this.setSourceAndDestinationMarkerIcons(context);
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            polylines: _polylines,
            markers: Set.from(markers),
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onTap: (LatLng loc) {
              setState(() {
                this.pinPillPosition = PIN_INVISIBLE_POSITION;
                this.userBadgeSelected = false;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              showPinsOnMap(provider: _routeProvider);
              setPolylines(provider: _routeProvider);
            },
          ),
        ),
      ],
    ));
  }

  void showPinsOnMap({RouteProvider provider}) {
    final locations = provider.availableLocation;
    final store = provider.storeNames;
    if (locations.length <= 0) return;
    Iterable _markers = Iterable.generate(locations.length, (index) {
      return Marker(
          markerId: MarkerId(index.toString()),
          draggable: false,
          position: LatLng(
            double.tryParse(locations[index].latitude),
            double.tryParse(locations[index].longitude),
          ),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: store[index]));
    });
    setState(() {
      markers = _markers;
    });
  }

  void setPolylines({RouteProvider provider}) async {
    final locations = provider.availableLocation;
    final locationsLength = locations.length;

    if (locationsLength <= 0) return;

    for (var i = 0; i < locationsLength; i++) {
      var nextIndex = i + 1;

      if (nextIndex >= locationsLength) return;

      var prevPoint = locations[i];
      var nextPoint = locations[nextIndex];

      await getPoints(prevPoint, nextPoint);
      addPolylines(nextIndex);
    }
  }

  Future getPoints(Location origin, Location destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD9OzgsVQTbEw7NkDSB-I5YquJH14WUplg",
      PointLatLng(
          double.tryParse(origin.latitude), double.tryParse(origin.longitude)),
      PointLatLng(double.tryParse(destination.latitude),
          double.tryParse(destination.longitude)),
    );

    if (result.points.isNotEmpty && result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
  }

  void addPolylines(id) {
    Polyline polyline = Polyline(
      polylineId: PolylineId(id.toString()),
      color: Color(0xFF06BE77),
      width: 3,
      points: polylineCoordinates,
    );
    _polylines.add(polyline);
    setState(() {});
  }
}
