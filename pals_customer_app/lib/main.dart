import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PalsCustomerApp(), debugShowCheckedModeBanner: false));

class PalsCustomerApp extends StatefulWidget {
  const PalsCustomerApp({super.key});
  @override
  State<PalsCustomerApp> createState() => _PalsCustomerAppState();
}

class _PalsCustomerAppState extends State<PalsCustomerApp> {
  bool _isMapReady = false;
  bool _isLoggedIn = false;
  bool _otpSent = false;
  bool _isOnline = true; 

  @override
  void initState() {
    super.initState();
    // Simulate initial loading/searching time (The Puff)
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _isMapReady = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Connectivity Guard
    if (!_isOnline) return OfflineScreen(onRetry: () => setState(() => _isOnline = true));

    // 2. The Radar Splash
    if (!_isMapReady) return const RadarSplash();

    // 3. Login Flow (Login -> OTP -> Map)
    if (!_isLoggedIn) {
      if (!_otpSent) {
        return LoginScreen(onSendOTP: () => setState(() => _otpSent = true));
      } else {
        return OTPScreen(
          onVerify: () => setState(() => _isLoggedIn = true),
          onBack: () => setState(() => _otpSent = false),
        );
      }
    }

    // 4. The Map Screen
    return const MapScreen();
  }
}

// --- LOGIN SCREEN ---
class LoginScreen extends StatelessWidget {
  final VoidCallback onSendOTP;
  const LoginScreen({super.key, required this.onSendOTP});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🫰", style: TextStyle(fontSize: 80)),
            const SizedBox(height: 20),
            const Text("WELCOME TO PALS", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.phone, color: Colors.orange),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              onPressed: onSendOTP,
              child: const Text("SEND OTP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// --- OTP SCREEN ---
class OTPScreen extends StatelessWidget {
  final VoidCallback onVerify;
  final VoidCallback onBack;
  const OTPScreen({super.key, required this.onVerify, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: onBack)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text("Verification Code", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Enter the 4-digit code sent to your mobile", style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _otpBox()),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              onPressed: onVerify,
              child: const Text("VERIFY & CONTINUE", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox() => Container(
    width: 60, height: 60,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
    child: const Center(child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number, style: TextStyle(color: Colors.orange, fontSize: 24, fontWeight: FontWeight.bold), decoration: InputDecoration(border: InputBorder.none))),
  );
}

// --- OFFLINE SCREEN ---
class OfflineScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const OfflineScreen({super.key, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: Colors.orange, size: 80),
            const Text("CONNECTION LOST", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(onPressed: onRetry, child: const Text("TRY AGAIN", style: TextStyle(color: Colors.orange))),
          ],
        ),
      ),
    );
  }
}

// --- RADAR SPLASH ---
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
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: Tween(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
              child: FadeTransition(
                opacity: Tween(begin: 1.0, end: 0.0).animate(_controller),
                child: Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.orange, width: 2))),
              ),
            ),
            const SizedBox(height: 20),
            const Text("PALS", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 6)),
            const Text("SEARCHING KGF...", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
          ],
        ),
      ),
    );
  }
}

// --- MAP SCREEN ---
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          const Center(child: Text("KGF MAP REFERENCE", style: TextStyle(color: Colors.white10))),
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
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.format_list_bulleted, size: 18),
                  label: const Text("VIEW AS LIST"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              children: [
                _clusterBtn(Icons.tune_rounded, false),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _clusterBtn(Icons.my_location, true),
                    const SizedBox(width: 15),
                    _clusterBtnText("🫰"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.orange, child: Text("🫰")),
            accountName: Text("Pals Member"),
            accountEmail: Text("GOLD STATUS", style: TextStyle(color: Colors.orange, fontSize: 10)),
          ),
          ListTile(leading: const Icon(Icons.card_membership, color: Colors.white70), title: const Text("Membership", style: TextStyle(color: Colors.white)), onTap: () {}),
          ListTile(leading: const Icon(Icons.confirmation_number_outlined, color: Colors.white70), title: const Text("Coupons", style: TextStyle(color: Colors.white)), onTap: () {}),
          const Spacer(),
          const Text("v1.0.0 - KGF Edition", style: TextStyle(color: Colors.white24, fontSize: 10)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _clusterBtn(IconData icon, bool orange) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: orange ? Colors.orange : Colors.black.withOpacity(0.6), shape: BoxShape.circle, border: orange ? null : Border.all(color: Colors.white10)),
    child: Icon(icon, color: orange ? Colors.black : Colors.orange),
  );

  Widget _clusterBtnText(String text) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle, border: Border.all(color: Colors.white10)),
    child: Text(text, style: const TextStyle(fontSize: 24)),
  );
}