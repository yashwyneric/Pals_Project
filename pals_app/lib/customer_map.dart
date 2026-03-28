import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CustomerMap extends StatefulWidget {
  const CustomerMap({super.key});

  @override
  State<CustomerMap> createState() => _CustomerMapState();
}

class _class _CustomerMapState extends State<CustomerMap> {
  late GoogleMapController mapController;
  
  // Starting position (KGF, Karnataka!)
  static const LatLng _center = LatLng(12.9592, 78.2714); 

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Pals Near You', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        myLocationEnabled: true, // This shows the "Blue Dot" for the customer
        markers: {
          const Marker(
            markerId: MarkerId('vendor_1'),
            position: LatLng(12.9600, 78.2720), // Simulated Vendor Position
            infoWindow: InfoWindow(title: 'Pals Ice Cream - LIVE'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Logic to find nearest vendor
        },
        label: const Text('Find Nearest Truck'),
        icon: const Icon(Icons.location_searching),
        backgroundColor: Colors.orange,
      ),
    );
  }
}