// Pals Project: Financial Settlement Engine (India 2026)

function calculateSettlement(orderTotal) {
    const platformFeePercent = 0.05; // We take 5% as our commission
    const gstRate = 0.18;           // 18% GST on our service
    const tcsRate = 0.01;           // 1% TCS on the total sale (Govt Rule)

    // 1. Calculate our cut
    const platformFee = orderTotal * platformFeePercent;

    // 2. Calculate GST on our fee (not on the whole order)
    const gstOnFee = platformFee * gstRate;

    // 3. Calculate 1% TCS (to be deposited to Govt)
    const tcsAmount = orderTotal * tcsRate;

    // 4. Total Deductions
    const totalDeductions = platformFee + gstOnFee + tcsAmount;

    // 5. Final Payout to Vendor
    const vendorPayout = orderTotal - totalDeductions;

    return {
        orderTotal: orderTotal.toFixed(2),
        palsCommission: platformFee.toFixed(2),
        govtGST: gstOnFee.toFixed(2),
        govtTCS: tcsAmount.toFixed(2),
        finalVendorPayout: vendorPayout.toFixed(2)
    };
}

// TEST CASE: A customer buys 500 INR worth of Ice Cream
const saleResult = calculateSettlement(500.00);

console.log("--- PALS FINANCIAL SUMMARY ---");
console.log(`Total Sale: ₹${saleResult.orderTotal}`);
console.log(`Pals Service Fee: ₹${saleResult.palsCommission}`);
console.log(`GST (18% on Fee): ₹${saleResult.govtGST}`);
console.log(`TCS (1% on Total): ₹${saleResult.govtTCS}`);
console.log("------------------------------");
console.log(`NET PAYOUT TO VENDOR: ₹${saleResult.finalVendorPayout}`);