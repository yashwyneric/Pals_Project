// Pals 2026: The "Walking Distance" Rule
function getMarketStatus(distanceInMeters) {
    if (distanceInMeters < 200) {
        return { status: "FRESH_ZONE", message: "Vendor is a 2-minute walk away!" };
    } else {
        return { status: "NEARBY", message: "Vendor is in your area." };
    }
}