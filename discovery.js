// Pals Project: Hyper-Local Discovery Engine

function calculateDistance(lat1, lon1, lat2, lon2) {
    // This is the Haversine formula to find distance on a globe
    const R = 6371; // Radius of Earth in km
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    
    const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * Math.sin(dLon/2) * Math.sin(dLon/2);
              
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    return R * c; // Distance in km
}

// TEST: Customer is at the Market Gate, Vendor is at the Corner
const customerLoc = { lat: 12.9716, lon: 77.5946 };
const vendorLoc = { lat: 12.9720, lon: 77.5950 };

const dist = calculateDistance(customerLoc.lat, customerLoc.lon, vendorLoc.lat, vendorLoc.lon);

console.log("--- PALS DISCOVERY ENGINE ---");
console.log(`Vendor is ${(dist * 1000).toFixed(0)} meters away.`);

if (dist < 0.5) {
    console.log("STATUS: Vendor is NEARBY. Show on Customer Map!");
} else {
    console.log("STATUS: Vendor is too far. Hide to save battery.");
}