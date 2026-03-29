import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

class PalsSecurity {
  static const String _idKey = "pals_device_lock_v1";

  static Future<bool> isAuthorized() async {
    final prefs = await SharedPreferences.getInstance();
    String? lockedId = prefs.getString(_idKey);
    
    // Generates a unique "Fingerprint" based on the device hardware/browser
    String currentId = "${html.window.navigator.userAgent}-${html.window.navigator.platform}";

    if (lockedId == null) {
      await prefs.setString(_idKey, currentId);
      return true;
    }
    return lockedId == currentId;
  }
}