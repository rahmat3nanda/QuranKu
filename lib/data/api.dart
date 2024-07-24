/*
 * *
 *  * api.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:02
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:02
 *
 */

class API {
  APISurah surah = APISurah();
}

class APISurah {
  final String data = "surat";

  String detail(int number) => "surat/$number";

  String interpretation(int number) => "surat/$number";
}
