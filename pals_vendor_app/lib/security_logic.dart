import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html; // Essential for Web/PWA device ID

class PalsSecurity {
  static const String _idKey = "pals_device_lock_id";

  /// Checks if this is the ONLY device allowed to open the app
  static Future<bool> isAuthorized() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Get a unique ID from the browser/phone storage
    String? lockedId = prefs.getString(_idKey);
    
    // 2. Generate a "Session ID" for this specific device
    String currentSessionId = html.window.navigator.userAgent;

    if (lockedId == null) {
      // FIRST LOGIN: Lock this device forever
      await prefs.setString(_idKey, currentSessionId);
      return true;
    }

    // 3. Compare: If it doesn't match, it's a second device. BLOCK IT.
    return lockedId == currentSessionId;
  }
}