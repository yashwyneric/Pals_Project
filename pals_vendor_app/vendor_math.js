// Pals Vendor Earnings Calculator
const orderValue = 500.00;
const tcsRate = 0.01; // 1% Government Tax for 2026

const tcsDeduction = orderValue * tcsRate;
const vendorPayout = orderValue - tcsDeduction;

console.log("--- PALS VENDOR SETTLEMENT ---");
console.log(`Customer Paid: ₹${orderValue}`);
console.log(`Govt TCS (1%): -₹${tcsDeduction}`);
console.log(`Final Vendor Payout: ₹${vendorPayout}`);
console.log("------------------------------");