import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  static const Duration _duration = Duration(milliseconds: 400);
  static Timer? _timer;

  ///debounce calls to [action] with automatic cancellation
  static void debounce(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(_duration, () {
      action.call();
      _timer?.cancel();
    });
  }
}
