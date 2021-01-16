
import 'dart:async';

import 'package:flutter/services.dart';

class DoubleTapPlayerView {
  static const MethodChannel _channel =
      const MethodChannel('double_tap_player_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
