import 'package:flutter/material.dart';

mixin SafeNotifyMixin on ChangeNotifier {
  bool _isDisposed = false;

  void safeNotify() {
    if (!_isDisposed) {
      notifyListeners();
      return;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
