import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uza_sales/app/sales/items/markers_items.dart';

class ByMap extends StatefulWidget {
  const ByMap({Key key}) : super(key: key);

  @override
  _ByMapState createState() => _ByMapState();
}

class _ByMapState extends State<ByMap> {
  Completer<GoogleMapController> _controller = Completer();
  // // marker 1
  //   static final Marker _marker1 = Marker(
  //   markerId: MarkerId('_marker1'),
  //   infoWindow: InfoWindow(title: "Mwenge Shop"),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(-6.7697769,39.2254963)
  //   );
  //   // marker 2
  //   static final Marker _marker2 = Marker(
  //   markerId: MarkerId('_marker2'),
  //   infoWindow: InfoWindow(title: "Mori Shop"),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   position: LatLng(-6.7767266,39.2258542)
  //   );
  //   // marker 3
  //    static final Marker _marker3 = Marker(
  //   markerId: MarkerId('_marker3'),
  //   infoWindow: InfoWindow(title: "Wanyama Shop"),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   position: LatLng(-6.7818233,39.2309568)
  //   );
  Iterable markers = [];

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: AppConstant.list[index]["title"]));
  });

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.7767266, 39.2258542),
    zoom: 13,
  );
  static Polyline _kpolyline = Polyline(
      polylineId: PolylineId('_kPolyline'),
      color: Color(0xFF06BE77),
      points: [
        LatLng(-6.7767266, 39.2258542),
        LatLng(-6.7818233, 39.2309568),
        LatLng(-6.7697769, 39.2254963)
      ],
      width: 3);

  @override
  void initState() {
    super.initState();
    setState(() {
      markers = _markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(markers),
        polylines: {
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Color(0xFF06BE77),
            width: 5,
            points: AppConstant.list
                .map((e) => LatLng(e['lat'], e['lon']))
                .toList(),
          ),
        },
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
