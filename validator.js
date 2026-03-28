// Pals Vendor Validation Engine
function validateVendor(data) {
    console.log(`Checking credentials for: ${data.businessName}...`);

    // 1. Check Aadhaar (Must be 12 digits)
    const isAadhaarValid = /^\d{12}$/.test(data.aadhaar);
    
    // 2. Check GST (Simplified check for 15 characters)
    const isGSTValid = data.gst.length === 15;

    if (isAadhaarValid && isGSTValid) {
        return "✅ STATUS: VERIFIED. Welcome to the Pals Ecosystem.";
    } else {
        return "❌ STATUS: REJECTED. Please check Aadhaar (12 digits) and GST (15 chars).";
    }
}

// Test Case: Let's pretend a vendor is signing up
const newVendor = {
    businessName: "Pals Ice Cream & Steamed Snacks",
    aadhaar: "123456789012", // 12 digits
    gst: "22AAAAA0000A1Z5"  // 15 digits
};

console.log(validateVendor(newVendor));