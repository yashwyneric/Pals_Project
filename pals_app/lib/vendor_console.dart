// Inside your "Accept" button onPressed function:
void _handleAcceptOrder(String orderId, double totalAmount) {
  // 1. Calculate the 2026 Settlement (Net of 1% TCS)
  var settlement = PalsBridge.calculateSettlement(totalAmount);
  print("Settling Order: ₹${settlement['vendor_net']} to Vendor");

  // 2. Trigger the UPI Request for the Customer
  PalsPayment.startPayment(
    amount: totalAmount, 
    orderId: orderId
  );

  // 3. Update the UI to "Preparing"
  setState(() {
    _status = "Preparing...";
  });
}