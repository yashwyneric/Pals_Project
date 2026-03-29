import 'package:url_launcher/url_launcher.dart';

class PalsPayment {
  // 2026 Indian Standard for UPI Deep Linking
  static Future<void> startPayment({required double amount, required String orderId}) async {
    final String upiId = "yashwyneric@okaxis"; // Your Business ID
    final String name = "Pals Ice Cream KGF";
    
    // This URI string tells the phone to open a Banking App (GPay/PhonePe)
    final String url = 
      "upi://pay?pa=$upiId&pn=$name&am=$amount&tr=$orderId&cu=INR&tn=Order%20$orderId";

    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print("PAYMENT: Handing over to UPI App for Order $orderId");
      } else {
        print("ERROR: No UPI app found on this device.");
      }
    } catch (e) {
      print("PAYMENT_ERROR: $e");
    }
  }
}