import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Bus extends StatefulWidget {
  const Bus({super.key});

  @override
  State<Bus> createState() => _BusState();
}

class _BusState extends State<Bus> {
  //final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destinationLocation = LatLng(27.6194, 85.5388);
  static const LatLng originALocation = LatLng(27.7325, 85.3081);
  static const LatLng originBLocation = LatLng(27.7068, 85.3147);
  static const LatLng originCLocation = LatLng(27.7173, 85.3466);
  static const LatLng originDLocation = LatLng(27.6940, 85.2815);
  static const LatLng originELocation = LatLng(27.6879, 85.3163);

  // LatLng x;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      //currentLocation != null
          // ? const Center(
          //     child: Icon(Icons.location_on_outlined),
          //   )
          // :
          GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: destinationLocation, zoom: 17),
        zoomControlsEnabled: false,
        compassEnabled: true,
        mapToolbarEnabled: false,
        markers: {
          const Marker(markerId: MarkerId("Origin"), position: originALocation),
          const Marker(
              markerId: MarkerId("Destination"), position: destinationLocation)
        },
        polylines: {
          const Polyline(
              polylineId: PolylineId("Route"),
              points: [originALocation, destinationLocation],
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
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            // const Marker(
                            //     markerId: MarkerId("Origin"),
                            //     position: originALocation);
                            GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                  target: destinationLocation, zoom: 17),
                              zoomControlsEnabled: false,
                              compassEnabled: true,
                              mapToolbarEnabled: false,
                              markers: {
                                const Marker(
                                    markerId: MarkerId("Origin"),
                                    position: originALocation),
                                const Marker(
                                    markerId: MarkerId("Destination"),
                                    position: destinationLocation)
                              },
                            );
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
                          // x = originBLocation;
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
                            // x = originCLocation;
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
                      ElevatedButton.icon(
                        onPressed: () {
                          // x = originDLocation;
                        },
                        icon: const Icon(
                          Icons.directions_bus_filled_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Bus D",
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
                          // x = originELocation;
                        },
                        icon: const Icon(
                          Icons.directions_bus_filled_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Bus E",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(131, 151, 136, 1),
                            fixedSize: const Size(300, 50)),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                      // busButton('Bus A'),
                      // busButton('Bus B'),
                      // busButton('Bus C'),
                      // busButton('Bus D'),
                      // busButton('Bus E')
                    ],
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)));
          }),
    );
  }
}

// Widget busButton(String type) {
//   return Column(
//     children: [
//       ElevatedButton.icon(
//         onPressed: () {
//           // {
//           //   const Marker(
//           //       markerId: MarkerId('origin'), position: _BusState.busALocation);
//           //   const Marker(
//           //       markerId: MarkerId('destination'),
//           //       position: _BusState.destinationLocation);
//           // }
//         },
//         icon: const Icon(
//           Icons.directions_bus_filled_outlined,
//           color: Colors.white,
//         ),
//         label: Text(
//           type,
//           style: const TextStyle(color: Colors.white),
//         ),
//         style: ElevatedButton.styleFrom(
//             backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
//             fixedSize: const Size(300, 50)),
//       ),
//       const SizedBox(
//         height: 15,
//       )
//     ],
//   );
// }
