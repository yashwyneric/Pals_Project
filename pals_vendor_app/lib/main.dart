class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    bool vendorIsNear = true; // Later this will be real-time data

    return Scaffold(
      backgroundColor: Colors.black, // Professional Radar Look
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (vendorIsNear) ...[
              const Icon(Icons.radar, color: Colors.orange, size: 120),
              const SizedBox(height: 20),
              const Text("1 VENDOR FOUND IN KGF", style: TextStyle(color: Colors.white, fontSize: 18)),
            ] else ...[
              const Icon(Icons.search, color: Colors.grey, size: 80),
              const Text("SEARCHING FOR VENDORS...", style: TextStyle(color: Colors.grey)),
            ],
          ],
        ),
      ),
    );
  }
}