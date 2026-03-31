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
    // Simulate "Puff" and Radar search time
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
          if (_isMapReady) const MapScreen(),
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
          const Text("SEARCHING KGF...", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
        ],
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A1A),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text("🫰", style: TextStyle(fontSize: 30)),
              ),
              accountName: const Text("Pals Member", style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: const Text("GOLD STATUS", style: TextStyle(color: Colors.orange, fontSize: 10)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(alignment: Alignment.centerLeft, child: Text("PALS CLUB", style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 2))),
            ),
            _drawerItem(Icons.card_membership, "Membership Status", "Gold Tier"),
            _drawerItem(Icons.confirmation_number_outlined, "My Coupons", "4 Active"),
            _drawerItem(Icons.stars_rounded, "Reward Points", "1,250 pts"),
            const Divider(color: Colors.white10),
            _drawerItem(Icons.history, "My Orders", null),
            _drawerItem(Icons.favorite_border, "Saved Carts", null),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)),
                onPressed: () {},
                child: const Text("BECOME A VENDOR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const Text("v1.0.0 - KGF Edition", style: TextStyle(color: Colors.white24, fontSize: 10)),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Stack(
        children: [
          // MAP BACKGROUND
          Container(color: const Color(0xFF121212), child: const Center(child: Text("KGF MAP REFERENCE", style: TextStyle(color: Colors.white10)))),
          
          // TOP UI
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () => scaffoldKey.currentState?.openDrawer()),
                      const Text("PALS", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20)),
                      IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.format_list_bulleted, size: 18),
                  label: const Text("VIEW AS LIST", style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
          ),

         // --- THE NEW UTILITY CLUSTER (Bottom-Left) ---
        Positioned(
          bottom: 30,
          left: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. FILTER (Top of the Recenter)
              GestureDetector(
                onTap: () => print("Filter Tapped"),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: const Icon(Icons.tune_rounded, color: Colors.orange, size: 28),
                ),
              ),
              const SizedBox(height: 15), // Space between Filter and Recenter
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 2. RECENTER BUTTON (The Anchor)
                  GestureDetector(
                    onTap: () => print("Recenter Tapped"),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                      ),
                      child: const Icon(Icons.my_location, color: Colors.black, size: 28),
                    ),
                  ),
                  const SizedBox(width: 15), // Space between Recenter and Fav
                  
                  // 3. FAVORITE (To the right of Recenter)
                  GestureDetector(
                    onTap: () => print("Finger Heart Tapped"),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Text("🫰", style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

  Widget _drawerItem(IconData icon, String title, String? trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 20),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      trailing: trailing != null ? Text(trailing, style: const TextStyle(color: Colors.orange, fontSize: 12)) : null,
      onTap: () {},
    );
  }
}