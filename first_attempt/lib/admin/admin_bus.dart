import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AdminBus extends StatefulWidget {
  const AdminBus({super.key});

  @override
  State<AdminBus> createState() => _AdminBusState();
}

class _AdminBusState extends State<AdminBus> {
  static const LatLng destinationLocation = LatLng(27.6194, 85.5388);

  static const LatLng tindobato = LatLng(27.6314, 85.5187);
  static const LatLng busStand = LatLng(27.6298, 85.5245);
  static const LatLng budol = LatLng(27.6279, 85.5327);
  static const LatLng kuBusstand = LatLng(27.6298, 85.5245);

  LatLng x = destinationLocation;
  LatLng y = destinationLocation;

  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // currentLocation != null
          //     ? const Center(
          //         child: Icon(Icons.location_on_outlined),
          //       )
          //     :
          GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: destinationLocation, zoom: 17),
        zoomControlsEnabled: false,
        compassEnabled: true,
        mapToolbarEnabled: false,
        markers: {
          Marker(markerId: const MarkerId("Origin"), position: x),
          Marker(markerId: const MarkerId("Destination"), position: y)
        },
        polylines: {
          Polyline(
              polylineId: const PolylineId("Route"),
              points: [x, y],
              color: Colors.red)
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          child: const Icon(Icons.track_changes),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ListView(
                    children: [
                      const SizedBox(
                        height: 35,
                        child: Divider(
                          thickness: 5,
                          indent: 100,
                          endIndent: 100,
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                x = tindobato;
                                y = busStand;
                              });
                            },
                            icon: const Icon(
                              Icons.directions_bus_filled_outlined,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Bus A",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(131, 151, 136, 1),
                                fixedSize: const Size(300, 50)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                x = busStand;
                                y = budol;
                              });
                            },
                            icon: const Icon(
                              Icons.directions_bus_filled_outlined,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Bus B",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(131, 151, 136, 1),
                                fixedSize: const Size(300, 50)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                x = budol;
                                y = kuBusstand;
                              });
                            },
                            icon: const Icon(
                              Icons.directions_bus_filled_outlined,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Bus C",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(131, 151, 136, 1),
                                fixedSize: const Size(300, 50)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)));
          }),
    );
  }
}
