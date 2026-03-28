import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class CustomerMap extends StatefulWidget {
  const CustomerMap({super.key});

  @override
  State<CustomerMap> createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  late GoogleMapController mapController;
  double _markerOpacity = 1.0;
  Timer? _timer;

  static const LatLng _center = LatLng(12.9592, 78.2714); // KGF Center

  @override
  void initState() {
    super.initState();
    // Start the Pulsing Radar (Blinks every 800ms)
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (mounted) {
        setState(() => _markerOpacity = _markerOpacity == 1.0 ? 0.3 : 1.0);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pals Discovery: KGF'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: GoogleMap(
        // Inside the Scaffold of CustomerMap, after the body:
bottomSheet: Container(
  height: 120,
  decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  ),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pals Ice Cream", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("₹500.0 • 200m away", style: TextStyle(color: Colors.grey[600])),
            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text("Pals Ice Cream", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    Text("₹500.0 • 200m away", style: TextStyle(color: Colors.grey[600])),
    
    // ADD THIS LINE HERE:
    const Text("FSSAI: 23321004000XXX", style: TextStyle(fontSize: 10, color: Colors.blueGrey)),
  ],
),
          ],
        ),
        ElevatedButton(
          onPressed: () {
             // This will trigger the UPI Link we built!
             print("Opening GPay for order...");
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
          child: const Text("PAY NOW"),
        )
      ],
    ),
  ),
),
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: const CameraPosition(target: _center, zoom: 15.0),
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('vendor_1'),
            position: const LatLng(12.9600, 78.2720),
            alpha: _markerOpacity, // The "Pulse" effect
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            infoWindow: const InfoWindow(title: 'Pals Ice Cream - LIVE'),
          ),
        },
      ),
    );
  }
}