import 'dart:async';
import 'package:flutter/foundation.dart';

enum VoiceState { idle, listening, analyzing, parsed }

class VoiceProvider extends ChangeNotifier {
  VoiceState _state = VoiceState.idle;
  Timer? _timer;

  String _detectedText = 'صرفت ٤٠ جنيه فطار';
  double _parsedAmount = 40.0;
  String _parsedDescription = 'فطار';
  String _parsedCategory = 'أكل';
  String _parsedCategoryEmoji = '🍔';

  VoiceState get state => _state;
  String get detectedText => _detectedText;
  double get parsedAmount => _parsedAmount;
  String get parsedDescription => _parsedDescription;
  String get parsedCategory => _parsedCategory;
  String get parsedCategoryEmoji => _parsedCategoryEmoji;

  void toggleVoice() {
    if (_state == VoiceState.idle) {
      _state = VoiceState.listening;
      notifyListeners();

      _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 2500), () {
        if (_state == VoiceState.listening) {
          _state = VoiceState.analyzing;
          notifyListeners();

          _timer = Timer(const Duration(milliseconds: 1000), () {
            _state = VoiceState.parsed;
            notifyListeners();
          });
        }
      });
    } else if (_state == VoiceState.listening) {
      _state = VoiceState.analyzing;
      notifyListeners();

      _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 1000), () {
        _state = VoiceState.parsed;
        notifyListeners();
      });
    }
  }

  void resetVoice() {
    _timer?.cancel();
    _state = VoiceState.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
