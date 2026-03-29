import 'package:flutter/material.dart';
import 'security_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool allowed = await PalsSecurity.isAuthorized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: allowed 
      ? const HomeScreen() 
      : const Scaffold(body: Center(child: Text("ACCESS DENIED: LOCKED TO ANOTHER DEVICE"))),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("HELLO WORLD: SECURE SESSION")));
  }
}