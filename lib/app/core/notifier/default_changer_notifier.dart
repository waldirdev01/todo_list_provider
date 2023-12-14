import 'package:flutter/foundation.dart';

class DefaultChangNotifier extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _success = false;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isLoading => _isLoading;
  bool get isSuccess => _success;

  void showLoading() => _isLoading = true;
  void hideLoading() => _isLoading = false;
  void success() => _success = true;
  void setError(String? message) => _error = message;
  void resetState() {
    setError(null);
    _success = false;
  }

  showloadingAndResetState() {
    showLoading();
    resetState();
  }
}
