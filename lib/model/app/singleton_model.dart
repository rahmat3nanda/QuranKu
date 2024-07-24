/*
 * *
 *  * singleton_model.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:47
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 21:22
 *
 */

import 'package:flutter/material.dart';
import 'package:quranku/model/interpretation_model.dart';
import 'package:quranku/model/surah_detail_model.dart';
import 'package:quranku/model/surah_model.dart';

class SingletonModel {
  static SingletonModel? _singleton;

  factory SingletonModel() => _singleton ??= SingletonModel._internal();

  SingletonModel._internal();

  static SingletonModel withContext(BuildContext context) {
    _singleton ??= SingletonModel._internal();
    _singleton!.context = context;

    return _singleton!;
  }

  static SingletonModel get shared => _singleton ??= SingletonModel._internal();

  BuildContext? context;
  SingletonSurah surah = SingletonSurah();

  void destroy() {
    _singleton = null;
  }
}

class SingletonSurah {
  List<SurahModel> data = [];
  List<SurahDetailModel> detail = [];
  List<InterpretationModel> interpretation = [];
}
