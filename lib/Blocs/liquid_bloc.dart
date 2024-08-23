import 'package:flutter/material.dart';

class LiquidBloc extends ChangeNotifier {
  double _openValue = 0.0;
  get openValue => _openValue;
  set openValue(value) {
    _openValue = value;
    notifyListeners();
  }

  DraggableDetails? _details;

  DraggableDetails? get details => _details;

  set details(DraggableDetails? value) {
    _details = value;
    notifyListeners();
  }

  bool _isDragging = false;

  bool get isDragging => _isDragging;

  set isDragging(bool value) {
    _isDragging = value;
    notifyListeners();
  }

  bool _isOpening = false;
  get isOpening => _isOpening;
  set isOpening(value) {
    _isOpening = value;
    notifyListeners();
  }

  void openLiquidMenu(AnimationController controller) {
    isOpening = !isOpening;
    if (isOpening) {
      openValue = 25.0;
      controller.forward();
    } else {
      openValue = 0.0;
      controller.reset();
    }
    notifyListeners();
  }
}
