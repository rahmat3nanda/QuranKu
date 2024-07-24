/*
 * *
 *  * repo.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:11
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:11
 *
 */

import 'package:dio/dio.dart' as dio;
import 'package:quranku/data/dio.dart';
import 'package:quranku/data/api.dart';

late API _api;
late Dio _dio;

class Repo {
  late RepoSurah surah;

  Repo() {
    _api = API();
    _dio = Dio();
    surah = RepoSurah();
  }
}

class RepoSurah {
  Future<dio.Response> data() async {
    return await _dio.get(url: _api.surah.data);
  }

  Future<dio.Response> detail(int number) async {
    return await _dio.get(url: _api.surah.detail(number));
  }

  Future<dio.Response> interpretation(int number) async {
    return await _dio.get(url: _api.surah.interpretation(number));
  }
}
