import 'package:flutter/material.dart';

void main() => runApp(const CustomerApp());

class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: const CustomerMap(),
    );
  }
}

class CustomerMap extends StatelessWidget {
  const CustomerMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Near Me - KGF")),
      body: Stack(
        children: [
          // The "Map" (Placeholder for KGF)
          Container(color: Colors.grey[200], child: const Center(child: Text("MAP VIEW: KOLAR GOLD FIELDS"))),
          // The Pulsing Radar Dot
          const Center(child: PulsingRadar()),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.orange),
          onPressed: () {}, 
          child: const Text("PAY NOW (₹500)", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class PulsingRadar extends StatefulWidget {
  const PulsingRadar({super.key});
  @override
  State<PulsingRadar> createState() => _PulsingRadarState();
}

class _PulsingRadarState extends State<PulsingRadar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 20 + (80 * _controller.value),
          height: 20 + (80 * _controller.value),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange.withOpacity(1 - _controller.value)),
        );
      },
    );
  }
}