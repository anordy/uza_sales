import 'package:flutter/material.dart';

class L10n {
    static final all = [
      const Locale('en'),
      const Locale('sw')
    ];

      static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸 English';
      case 'sw':
        return '🇹🇿 Swahili';
      default:
        return '🇺🇸 English';
    }
  }
}