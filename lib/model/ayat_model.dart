/*
 * *
 *  * ayat_model.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:57
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/24/2024, 23:57
 *
 */

class AyatModel {
  final int? ayatNumber;
  final String? arabicText;
  final String? latinText;
  final String? indonesianText;
  final Map<String, String>? audio;

  AyatModel({
    this.ayatNumber,
    this.arabicText,
    this.latinText,
    this.indonesianText,
    this.audio,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        ayatNumber: json["nomorAyat"],
        arabicText: json["teksArab"],
        latinText: json["teksLatin"],
        indonesianText: json["teksIndonesia"],
        audio: Map.from(json["audio"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomorAyat": ayatNumber,
        "teksArab": arabicText,
        "teksLatin": latinText,
        "teksIndonesia": indonesianText,
        "audio":
            Map.from(audio!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
