/*
 * *
 *  * general.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:45
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 18:04
 *
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quranku/common/constants/app_string.dart';

class AppLog {
  static bool debugMode = false;
  static String tag = "[${AppString.appName.split(" ").first}]";

  static void print(dynamic data, {bool debug = false}) {
    String message = "[${DateTime.now().toUtc()}]$tag$data";
    if (debugMode || debug) {
      debugPrint(message);
    } else {
      log(message);
    }
  }
}
