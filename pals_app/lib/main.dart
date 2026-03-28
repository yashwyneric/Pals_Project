import 'package:flutter/material.dart';

void main() => runApp(const PalsApp());

class PalsApp extends StatelessWidget {
  const PalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      home: const VendorDashboard(),
    );
  }
}

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  bool isLive = false;
  bool hasOrder = false;
  String _statusMessage = "OFFLINE";

  // Real-world Finance for KGF Market
  double orderAmount = 500.00;
  
  // Logic for the Accept Button
  void _handleAccept() {
    // 1. Calculate the 1% TCS (Tax Collected at Source) 
    double tcs = orderAmount * 0.01;
    double vendorNet = orderAmount - tcs;

    setState(() {
      hasOrder = false;
      _statusMessage = "PREPARING (Net: ₹${vendorNet.toStringAsFixed(2)})";
    });

    // 2. Trigger the Real UPI Intent (GPay/PhonePe)
    PalsPayment.startPayment(
      amount: orderAmount, 
      orderId: "PALS-KGF-2026-01"
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Accepted! ₹${vendorNet.toStringAsFixed(2)} will be settled."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLive ? Colors.green.shade50 : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Pals Vendor Console"),
        centerTitle: true,
        backgroundColor: isLive ? Colors.green : Colors.deepOrange.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // 1. THE STATUS ICON
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isLive ? Colors.green : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLive ? Icons.storefront : Icons.storefront_outlined,
                size: 80,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),
            Text(
              isLive ? _statusMessage : "OFFLINE",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // 2. THE MASTER TOGGLE
            Transform.scale(
              scale: 1.5,
              child: Switch(
                value: isLive,
                onChanged: (value) {
                  setState(() {
                    isLive = value;
                    _statusMessage = isLive ? "ONLINE" : "OFFLINE";
                    if (isLive) {
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) setState(() => hasOrder = true);
                      });
                    } else {
                      hasOrder = false;
                    }
                  });
                },
                activeColor: Colors.green,
              ),
            ),

            const SizedBox(height: 40),

            // 3. THE LIVE ORDER CARD
            if (isLive && hasOrder) 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.restaurant, color: Colors.white)),
                        title: Text("NEW ORDER #2026", style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("2x Ice Cream | 1x Hot Momos"),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total: ₹$orderAmount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ElevatedButton.icon(
                              onPressed: _handleAccept,
                              icon: const Icon(Icons.check),
                              label: const Text("ACCEPT"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            if (isLive && !hasOrder && _statusMessage == "ONLINE")
              const Text("Waiting for customers in KGF...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}