/*
 * *
 *  * request.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:13
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:13
 *
 */

import 'package:dio/dio.dart' as dio;
import 'package:quranku/data/repo.dart';

late Repo _repo;

class Request {
  late RequestSurah surah;

  Request() {
    _repo = Repo();
    surah = RequestSurah();
  }
}

class RequestSurah {
  Future<dio.Response> data() {
    return _repo.surah.data();
  }

  Future<dio.Response> detail(int number) {
    return _repo.surah.detail(number);
  }

  Future<dio.Response> interpretation(int number) {
    return _repo.surah.interpretation(number);
  }
}
