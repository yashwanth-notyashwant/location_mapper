import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  MapController mapController = MapController();
  late LatLng currentLocation;
  LatLng? tappedLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      tappedLocation = latlng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 400,
                    margin: EdgeInsets.all(20),
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: currentLocation,
                        zoom: 14.0,
                        onTap: _handleTap,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: [
                            if (currentLocation != null)
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: currentLocation,
                                builder: (ctx) => Icon(
                                  Icons.location_pin,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                              ),
                            if (tappedLocation != null)
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: tappedLocation!,
                                builder: (ctx) => Icon(
                                  Icons.location_pin,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            child: Container(
                              height: 38,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 5),
                                child: Text(
                                  "Get location on pin ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                            // onPressed: () async {
                            //   final coordinates = new Coordinates(
                            //       tappedLocation!.latitude,
                            //       tappedLocation!.longitude);
                            //   var addresses = await Geocoder.local
                            //       .findAddressesFromCoordinates(coordinates);
                            //   var first = addresses.first;
                            //   print(
                            //       "${first.featureName} : ${first.addressLine}");
                            // },
                            onPressed: () async {
                              if (tappedLocation!.latitude == null) {
                                return;
                              }
                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      tappedLocation!.latitude,
                                      tappedLocation!.longitude);
                              var street =
                                  await placemarks[1].toString().trim();
                              var country =
                                  await placemarks[3].toString().trim();
                              var name = await placemarks[0].toString().trim();
                              var postalcode =
                                  await placemarks[4].toString().trim();
                              var areaa = await placemarks[2].toString().trim();

                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Container(
                                    height: 80,
                                    child: Text(
                                      '       $name,$street "" $areaa "" $postalcode "" $country ""  ',
                                    ),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: tappedLocation == null
            ? null
            : BottomAppBar(
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'You tapped at: ${tappedLocation!.latitude}, ${tappedLocation!.longitude}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
