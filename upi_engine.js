// Pals Project: UPI Deep Link Generator
// This creates a link that triggers GPay/PhonePe on a customer's phone.

function generateUPILink(vendorUPI, vendorName, amount, orderID) {
    // Standard UPI Format: upi://pay?pa=ADDRESS&pn=NAME&am=AMOUNT&tr=ID&cu=INR
    
    const baseUrl = "upi://pay";
    const params = new URLSearchParams({
        pa: vendorUPI,             // Vendor's UPI ID (e.g., vendor@okaxis)
        pn: vendorName,            // Vendor's Business Name
        am: amount.toString(),     // Amount in INR
        tr: orderID,               // Unique Transaction Reference
        cu: "INR",                 // Currency
        tn: `Payment for Pals Order #${orderID}` // Note shown to customer
    });

    return `${baseUrl}?${params.toString()}`;
}

// TEST CASE: Customer pays ₹500 to "Pals Ice Cream"
const testLink = generateUPILink(
    "pals.vendor77@okicici", 
    "Pals Ice Cream", 
    500.00, 
    "PALS-100293"
);

console.log("--- PALS UPI INTENT LINK ---");
console.log(testLink);
console.log("----------------------------");
console.log("When a customer clicks this on their phone, GPay will open automatically.");