/*
 * *
 *  * quran_ku_channel.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/30/2024, 16:55
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/30/2024, 16:55
 *
 */

import 'package:flutter/services.dart';
import 'package:quranku/common/constants.dart';

class QuranKuChannel {
  static QuranKuChannel? _singleton;

  factory QuranKuChannel() => _singleton ??= QuranKuChannel._internal();

  QuranKuChannel._internal();

  static QuranKuChannel get shared => _singleton ??= QuranKuChannel._internal();

  Biometric biometric = Biometric();
}

class Biometric {
  final MethodChannel _channel = const MethodChannel("id.nesd.quranku.channel");

  Future<bool> isFingerprintAvailable() async {
    try {
      bool result = await _channel.invokeMethod('checkFingerprint');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> authFingerprint() async {
    try {
      bool result = await _channel.invokeMethod('authFingerprint');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.value(false);
    }
  }
}
