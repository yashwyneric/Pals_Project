import 'package:flutter/material.dart';
import 'order_logic.dart';
import 'pals_bridge.dart';

class VendorConsole extends StatefulWidget {
  @override
  _VendorConsoleState createState() => _VendorConsoleState();
}

class _VendorConsoleState extends State<VendorConsole> {
  String _status = "RECEIVED";
  String _settlementText = "";

  void _handleAcceptOrder(String orderId, double totalAmount) {
    // 1. Calculate the 2026 Settlement (Net of 1% TCS)
    var settlement = PalsBridge.calculateSettlement(totalAmount);
    
    // 2. Trigger the UPI Request for the Customer
    PalsPayment.startPayment(amount: totalAmount, orderId: orderId);

    // 3. Update the UI to "Preparing"
    setState(() {
      _status = "PREPARING...";
      _settlementText = "Net Settlement: ₹${settlement['vendor_net']} (after 1% TCS)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pals Vendor Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Order Status: $_status", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(_settlementText, style: TextStyle(color: Colors.green, fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              onPressed: () => _handleAcceptOrder("PALS-KGF-001", 500.0),
              child: Text("ACCEPT ORDER", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}