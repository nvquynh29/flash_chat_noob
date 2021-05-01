import 'package:flutter/material.dart';

extension TextEditingExtension on TextEditingController {
  bool get isValid {
    if (this.text != null) {
      return this.text.trim().isNotEmpty;
    }
    return false;
  }
}
