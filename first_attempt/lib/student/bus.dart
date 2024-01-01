import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bus extends StatefulWidget {
  const Bus({super.key});

  @override
  State<Bus> createState() => _BusState();
}

class _BusState extends State<Bus> {
  //final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destinationLocation = LatLng(27.6194, 85.5388);
  static const LatLng busALocation = LatLng(27.6194, 85.5388);

  // LocationData? currentLocation;

  // void getCurrentLocation() {
  //   Location location = Location();

  //   location.getLocation().then(
  //     (location) {
  //       currentLocation = location;
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //currentLocation == null
          // ? const Center(
          //     child: Icon(Icons.location_on_outlined),
          //   ),
          GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: destinationLocation, zoom: 17),
        zoomControlsEnabled: false,
        compassEnabled: true,
        markers: {
          const Marker(
              markerId: MarkerId("source"), position: destinationLocation)
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
                      ListTile(
                        title: const Text("Bus A"),
                        onTap: () {
                          const Marker(
                              markerId: MarkerId("source"),
                              position: destinationLocation);
                        },
                      ),
                      busButton('Bus A'),
                      busButton('Bus B'),
                      busButton('Bus C'),
                      busButton('Bus D'),
                    ],
                  );
                });
          }),
    );
  }
}

Widget busButton(String type) {
  return TextButton.icon(
      onPressed: () {
        {
          const Marker(
              markerId: MarkerId('origin'), position: _BusState.busALocation);
          const Marker(
              markerId: MarkerId('destination'),
              position: _BusState.destinationLocation);
        }
      },
      icon: const Icon(
        Icons.directions_bus_filled_outlined,
        color: Colors.black87,
      ),
      label: Text(
        type,
        style: const TextStyle(color: Colors.black87),
      ));
}
