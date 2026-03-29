import 'package:flutter/material.dart';

void main() => runApp(const PalsAdminApp());

class PalsAdminApp extends StatelessWidget {
  const PalsAdminApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red), // Alert/Admin Red
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PALS ADMIN: FEEDBACK"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text("Sample Feedback: 'Best Ice Cream in KGF!'"),
              subtitle: Text("From: Customer App | Status: New"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.report_problem, color: Colors.red),
              title: Text("Sample Feedback: 'TCS Calculation confirmed at ₹495'"),
              subtitle: Text("From: Vendor App | Status: Verified"),
            ),
          ),
        ],
      ),
    );
  }
}