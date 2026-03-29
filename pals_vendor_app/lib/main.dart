import 'package:flutter/material.dart';

void main() => runApp(const PalsVendorApp());

class PalsVendorApp extends StatelessWidget {
  const PalsVendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo, // Professional, Trustworthy Blue
      ),
      home: const VendorConsole(),
    );
  }
}

class VendorConsole extends StatelessWidget {
  const VendorConsole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("PALS VENDOR CONSOLE", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 64, color: Colors.indigo),
            SizedBox(height: 16),
            Text("STATION PREPPED: VENDOR MODE", 
              style: TextStyle(color: Colors.grey, letterSpacing: 1.5)),
          ],
        ),
      ),
    );
  }
}