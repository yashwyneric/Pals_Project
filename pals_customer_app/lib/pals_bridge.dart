// Pals Project: 2026 Settlement Bridge
class PalsBridge {
  static const double tcsRate = 0.01; // 1% Govt TCS

  static Map<String, double> calculateSettlement(double amount) {
    double tcs = amount * tcsRate;
    double vendorNet = amount - tcs;
    
    return {
      'total': amount,
      'tcs': tcs,
      'vendor_net': vendorNet,
    };
  }
}