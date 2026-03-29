import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PalsCustomerApp(), debugShowCheckedModeBanner: false));

class PalsCustomerApp extends StatefulWidget {
  const PalsCustomerApp({super.key});
  @override
  State<PalsCustomerApp> createState() => _PalsCustomerAppState();
}

class _PalsCustomerAppState extends State<PalsCustomerApp> with SingleTickerProviderStateMixin {
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    // Simulate "Puff" and Radar search time before showing the Map
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _isMapReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. THE FINAL MAP UI (Visible when ready)
          if (_isMapReady) const MapScreen(),

          // 2. THE RADAR & SPLASH LAYER (Puffs away when map is ready)
          AnimatedOpacity(
            opacity: _isMapReady ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 800),
            child: const RadarSplash(),
          ),
        ],
      ),
    );
  }
}

// --- THE RADAR / SPLASH STATION ---
class RadarSplash extends StatefulWidget {
  const RadarSplash({super.key});
  @override
  State<RadarSplash> createState() => _RadarSplashState();
}

class _RadarSplashState extends State<RadarSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween(begin: 1.0, end: 0.0).animate(_controller),
              child: Container(
                width: 120, height: 120,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.orange, width: 2)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("PALS", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 6)),
          const SizedBox(height: 10),
          const Text("SEARCHING KGF...", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
        ],
      ),
    );
  }
}

// --- THE MAP STATION ---
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Placeholder
        Container(color: const Color(0xFF121212), child: const Center(child: Text("MAP VIEW", style: TextStyle(color: Colors.white24)))),

        // TOP UI: Hamburger, Logo, Dots, and List View Button
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
                    const Text("PALS", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20)),
                    IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // LIST VIEW BUTTON (Center Top)
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.list, size: 18),
                label: const Text("VIEW AS LIST", style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),

        // BOTTOM UI: Fav (Left) and Filter (Right)
        Positioned(bottom: 30, left: 20, child: FloatingActionButton.small(backgroundColor: Colors.white10, onPressed: () {}, child: const Icon(Icons.favorite, color: Colors.red))),
        Positioned(bottom: 30, right: 20, child: FloatingActionButton(backgroundColor: Colors.orange, onPressed: () {}, child: const Icon(Icons.tune, color: Colors.black))),
      ],
    );
  }
}